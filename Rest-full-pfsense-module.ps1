
Add-pfsenseinterfacevlan -if "vmx2" -tag "1441" -descr "nein" -verbose
Add-pfsenseinterface -if "vmx2.26" -descr "Test" -verbose
get-pfsenseinterfacevlan



get-verb

get-help Add-pfsenseinterface -detailed
get-help Add-pfsenseinterfacevlan -detailed
get-help update-pfsenseinterface -detailed