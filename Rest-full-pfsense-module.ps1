
#Add-pfsenseinterfacevlan -if "vmx2" -tag "1441" -descr "nein" -verbose
#Add-pfsenseinterface -if "vmx2.26" -descr "Test" -verbose
#get-pfsenseinterfacevlan



#get-verb

#get-help Add-pfsenseinterface -detailed
#get-help Add-pfsenseinterfacevlan -detailed
#get-help update-pfsenseinterface -detailed




$Public = @( Get-ChildItem -Path C:\Scripts\pfsense-powershell\Public\*.ps1 -ErrorAction SilentlyContinue )

#Dot source the files
Foreach ($import in @($Public)) {
    Try {
        . $import.fullname
    }
    Catch {
        Write-Error -Message "Failed to import function $($import.fullname): $_"
    }
}