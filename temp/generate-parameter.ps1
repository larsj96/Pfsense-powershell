
$data = import-csv  C:\Scripts\pfsense-powershell\temp\updatefirewallrule.csv

$data | ForEach-Object {

    $PARAMETERTOPTEXT = "
.PARAMETER $($_.key)
$($_.Description)
"
Write-Host $PARAMETERTOPTEXT -ForegroundColor Green
}




$data | ForEach-Object {

    # Create interface
    $PARAMETER = "
[Parameter()]
  $|$($_.key),
"
Write-Host $PARAMETER -ForegroundColor Green
}

get-help Set-ADUser -detailed