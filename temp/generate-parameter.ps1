

get-item C:\Scripts\pfsense-powershell\temp\*.csv

$data = import-csv  C:\Scripts\pfsense-powershell\temp\UpdateNATPortForwards.csv

$data | ForEach-Object {

    $PARAMETERTOPTEXT = "
.PARAMETER $($_.key)
$($_.Description)
"
Write-Host $PARAMETERTOPTEXT -ForegroundColor Green
}




$data | ForEach-Object {
<#


  # NAT Port Forwards
    $PARAMETER = "
[Parameter()]
  $|$($_.key),
"
#>

  #Update NAT Port Forwards
  $PARAMETER = "
  [Parameter()]
  $'ø'$($_.key),
  "


Write-Host $PARAMETER -ForegroundColor Green
}

get-help Set-ADUser -detailed