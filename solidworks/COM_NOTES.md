# SolidWorks COM API: подключение, приёмы, подводные камни

Проверено на SOLIDWORKS 2023 SP1 (31.1.0), Windows 11. Источники: `SP-LAB-GRANT`
(`tools/README.md`, `tools/solidworks/` — построение и правка деталей, сборки, чертежи;
октябрь 2026) и `PIKAPOMP` (`tools/solidworks/` — осмотр только на чтение; ноябрь 2026).

## Подключение

Только к **запущенному** экземпляру: `GetActiveObject('SldWorks.Application')`.
Новый экземпляр (`Dispatch`/`CreateObject`) не создавать.

### PowerShell без Python (Windows PowerShell 5.1)

Работает «из коробки», без установки чего-либо. Обычный вызов методов
(`$sw.RevisionNumber()`) падает с `TYPE_E_ELEMENTNOTFOUND` — вызывать через
`InvokeMember`:

```powershell
$BF = [Reflection.BindingFlags]
function M($o, $n) { $a = @($args); [System.__ComObject].InvokeMember($n, $BF::InvokeMethod, $null, $o, $a) }
function P($o, $n) { [System.__ComObject].InvokeMember($n, $BF::GetProperty, $null, $o, $null) }
$sw = [Runtime.InteropServices.Marshal]::GetActiveObject('SldWorks.Application')
M $sw 'RevisionNumber'
$doc = P $sw 'ActiveDoc'; M $doc 'GetPathName'; M $doc 'GetSaveFlag'
```

Готовые скрипты — `tools/sw_look_ro.ps1` (документы, дерево сборки, PNG вида) и
`tools/sw_boxes_ro.ps1` (габариты компонентов). Запуск:
`powershell.exe -NoProfile -ExecutionPolicy Bypass -File <скрипт>`. Вывод — UTF-8
(`[Console]::OutputEncoding`).

### Python (pywin32)

- Нужен `pywin32` (на машине PIKAPOMP его не было ни в 3.12, ни в 3.13 — тогда
  PowerShell).
- Поздняя привязка: `GetDocuments`, `GetTitle`, `GetPathName`, `GetSaveFlag` и др. могут
  приходить свойствами, а не методами: `v = getattr(obj, name); v = v() if callable(v) else v`.
- Чистая поздняя привязка может давать `DISP_E_MEMBERNOTFOUND` (например
  `IModelDoc2.FirstFeature`); надёжнее ранняя привязка через makepy
  (`win32com.client.gencache`) и обёртки типизированных интерфейсов.
- Аргументы-`null` для COM: `VARIANT(VT_DISPATCH, None)` вместо `None` (иначе «несоответствие
  типа», например в `SelectByID2(..., Callout, ...)`).
- Скрипт заканчивать `sys.stdout.flush(); os._exit(0)` — иначе процесс может повиснуть на
  COM при выходе.
- Вывод: `PYTHONIOENCODING=utf-8` (иначе ошибка cp1251/cp1252 на кириллице).

### Песочницы агентов

- **Codex Desktop (Windows), 30.10.2026:** `GetActiveObject` из песочницы →
  `MK_E_UNAVAILABLE` (`-2147221021`) при открытом SolidWorks; тот же вызов с повышенными
  правами (`require_escalated`) подключился. Не обходить созданием нового экземпляра.
- **Claude Code (Windows), инструмент Bash:** записи за пределами рабочей папки могут
  попадать в изолированный слой. COM-скрипты и установки запускать из PowerShell.

## Осмотр, не меняя модель

- Открыть только для чтения: `OpenDoc6(path, type, 1 | 2, "", errs, warns)`
  (type: 1 деталь, 2 сборка, 3 чертёж; 1 = silent, 2 = read-only). Закрывать после,
  только если документ не был открыт до этого.
- Скрипты осмотра не должны вызывать `CloseDoc` для документов, открытых пользователем
  (такая ошибка была в SP-LAB-GRANT `sw_asm_ro.py`/`sw_inspect_ro.py`).
- Габариты: `Component2.GetBox(False, False)` (м) — у облегчённых компонентов габарита нет:
  перед этим `asm.ResolveAllLightWeightComponents(False)` (меняет состояние загрузки —
  только при необходимости).
- `GetPartBox` учитывает эскизы — одиночные эскизы раздувают габарит; габарит тела —
  `GetBodies2(0, False)[0].GetBodyBox`.
- Снимок текущего вида без изменения модели: `doc.SaveAs3(path.png, 0, 2)` (экспорт копии).
- Проверка формы поверхности: лучи `Extension.SelectByRay` +
  `SelectionManager.GetSelectionPoint2` по сетке — карта высот; горизонтальные лучи —
  габарит на заданной высоте.

## Правка

- Править в том же файле: открыть → построить → сохранить; внутренний ID и ссылки сборок
  сохраняются. «Сохранить как» для детали в открытой сборке переключает сборку на новый
  файл.
- Размер менять параметром, а не сдвигом точек эскиза (иначе тело уезжает):
  `doc.Parameter('D1@Эскиз1').SetSystemValue3(v, 1, None)` + перестроение.
- Перед вытяжкой/вырезом явно выделять нужный эскиз (`FeatureByPositionReverse(0)`) —
  сброс выделения приводил к построению не от того эскиза.
- Каждый вырез проверять по уменьшению объёма и отсутствию **новых** пересечений
  (сравнивать с исходным числом пересечений модели).
- Плоскости: направление смещения проверять по `RefPlane.Transform`.
- Цвет: внешний вид материала через API не подхватывается — задавать явно; скрытие
  плоскостей работает только в активном документе. Массовую перекраску не повторять —
  затрёт внешний вид, заданный пользователем.
- Перенос компонента сборки: `IComponent2.Transform2 = <MathTransform>`; зафиксированный
  компонент сначала `UnfixComponent`, потом снова зафиксировать.

### Уравнения и конфигурации

- Уравнение только для одной конфигурации: сделать её активной (`ShowConfiguration2`) и
  `SetEquationAndConfigurationOption(i, текст, 1, пустой массив BSTR)`. Вариант 3 с
  именем неактивной конфигурации возвращает −1.
- Значение глобальной переменной менять записью свойства `Equation`
  (`DISPATCH_PROPERTYPUT`), а не `Delete` + `Add2` — после удаления зависящие уравнения
  ломаются.
- Новый элемент, созданный при одной активной конфигурации, в других может быть погашен:
  `SetSuppression2(1, 2, пустой массив)`.

### Прочие элементы

- Текст эскиза — `ModelDoc2.InsertSketchText` (не `SketchManager`); шрифт —
  `GetTextFormat`/`SetTextFormat`.
- `InsertWrapFeature2` (тиснение) на сплайновой грани через API не создаётся. Рельеф по
  кривой поверхности: эскиз на плоскости → бобышка «до поверхности» (T1=4) → вырез
  «смещение от поверхности» (T1=5).
- Начало вытяжки со смещением: `ExtrudeFeatureData2.AccessSelections` → `FromType=3`,
  `FromOffsetDistance`, `FromOffsetReverse` → `ModifyDefinition`. `SetFromEntity(плоскость)`
  однажды сломал элемент без возможности отката — только восстановление из снимка.

## Экспорт и чертежи

- STEP в своей системе координат: `Extension.SetUserPreferenceString(16, 0, 'имя СК')`;
  задавать заново после каждого `ShowConfiguration2`. По умолчанию STL/STEP — в осях
  модели (у деталей с осью Y вверх слайсер кладёт деталь на бок).
- Чертёж детали по раскладке JSON (`SP-LAB-GRANT tools/solidworks/build_part_drawing.py`):
  размеры по коротким именам (`D1@Эскиз2`), подписи `prefix/suffix`, разворот разреза;
  примечания — короткими строками.

## Стабильность

- 35 открытых окон деталей роняли SolidWorks — закрывать открытое агентом.
- Модальный диалог SolidWorks вешает COM-вызов без тайм-аута — для долгих операций
  предпочитать MCP-сервер с обработкой диалогов.
