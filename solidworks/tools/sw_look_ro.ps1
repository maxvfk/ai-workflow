# Только чтение: открытые документы SolidWorks и дерево активной сборки.
# Поздняя привязка через InvokeMember (обычный адаптер PowerShell падает на TYPE_E_ELEMENTNOTFOUND).
[Console]::OutputEncoding = [Text.Encoding]::UTF8
$BF = [Reflection.BindingFlags]
function M($o, $n) { $a = @($args); [System.__ComObject].InvokeMember($n, $BF::InvokeMethod, $null, $o, $a) }
function P($o, $n) { [System.__ComObject].InvokeMember($n, $BF::GetProperty, $null, $o, $null) }

$sw = [Runtime.InteropServices.Marshal]::GetActiveObject('SldWorks.Application')
"SW " + (M $sw 'RevisionNumber')
$ad = P $sw 'ActiveDoc'
"ACTIVE " + (M $ad 'GetPathName') + " type=" + (M $ad 'GetType') + " dirty=" + (M $ad 'GetSaveFlag')
$d = M $sw 'GetFirstDocument'
while ($d -ne $null) { "  open: " + (M $d 'GetPathName') + " dirty=" + (M $d 'GetSaveFlag'); $d = M $d 'GetNext' }

function Walk($c, $ind) {
  $b = M $c 'GetBox' $false $false
  $s = "$ind" + (P $c 'Name2') + " | sup=" + (M $c 'GetSuppression2')
  if ($b) { $s += " | {0:N0}x{1:N0}x{2:N0} y[{3:N0},{4:N0}]" -f (($b[3]-$b[0])*1000), (($b[4]-$b[1])*1000), (($b[5]-$b[2])*1000), ($b[1]*1000), ($b[4]*1000) }
  $s
  if ($ind.Length -lt 8) { $ch = M $c 'GetChildren'; if ($ch) { foreach ($k in $ch) { Walk $k ($ind + "    ") } } }
}
if ((M $ad 'GetType') -eq 2) { foreach ($c in (M $ad 'GetComponents' $true)) { Walk $c "" } }
if ($args.Count -gt 0) { "img " + (M $ad 'SaveAs3' $args[0] 0 2) }
"dirty after=" + (M $ad 'GetSaveFlag')
