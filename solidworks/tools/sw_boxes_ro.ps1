# Только чтение: габариты (мм) всех компонентов активной сборки SolidWorks и всей сборки.
[Console]::OutputEncoding = [Text.Encoding]::UTF8
$BF = [Reflection.BindingFlags]
function M($o, $n) { $a = @($args); [System.__ComObject].InvokeMember($n, $BF::InvokeMethod, $null, $o, $a) }
function P($o, $n) { [System.__ComObject].InvokeMember($n, $BF::GetProperty, $null, $o, $null) }
$sw = [Runtime.InteropServices.Marshal]::GetActiveObject('SldWorks.Application')
$ad = P $sw 'ActiveDoc'
foreach ($c in (M $ad "GetComponents" $false)) {
  $n = P $c 'Name2'; if ($n -match 'iso') { continue }
  $b = M $c 'GetBox' $false $false
  if ($b) { "{0} | sup={7} | x[{1:N1},{2:N1}] y[{3:N1},{4:N1}] z[{5:N1},{6:N1}]" -f $n, ($b[0]*1000), ($b[3]*1000), ($b[1]*1000), ($b[4]*1000), ($b[2]*1000), ($b[5]*1000), (M $c 'GetSuppression2') }
}
$e = M $ad 'GetBox' 0
if ($e) { "ASM x[{0:N1},{1:N1}] y[{2:N1},{3:N1}] z[{4:N1},{5:N1}]" -f ($e[0]*1000),($e[3]*1000),($e[1]*1000),($e[4]*1000),($e[2]*1000),($e[5]*1000) }
"dirty after=" + (M $ad 'GetSaveFlag')
