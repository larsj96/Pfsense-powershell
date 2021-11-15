function Update-dhcpInterFace {
    <#
    .PARAMETER interface
    Specify which interface's DHCP configuration to update. You may specify either the interface's descriptive name, the pfSense ID (wan, lan, optx), or the physical interface id (e.g. igb0). This Interface must host a static IPv4 subnet that has more than one available within the subnet.
    
    
    .PARAMETER enable
    Enable or disable the DHCP server for this Interface (optional)
    
    
    .PARAMETER range_from
    Update the DHCP pool's start IPv4 address. This must be an available address within the Interface's subnet and be less than the�range_to�value. (optional)
    
    
    .PARAMETER range_to
    Update the DHCP pool's end IPv4 address. This must be an available address within the Interface's subnet and be greater than the�range_from�value. (optional)
    
    
    .PARAMETER dnsserver
    Update the DNS servers to include In DHCP leases. Multiple values may be passed in as an array or single values may be passed in as a string. Each value must be a valid IPv4 address. Alternatively, you may pass In an empty array to revert to the system default. (optional)
    
    
    .PARAMETER domain
    Update the domain name to Include In the DHCP lease. This must be a valid domain name or an empty string to assume the system default (optional)
    
    
    .PARAMETER domainsearchlist
    Update the search domains to include In the DHCP lease. You may pass In an array for multiple entries or a string for single entries. Each entry must be a valid domain name. (optional)
    
    
    .PARAMETER mac_allow
    Update the list of allowed MAC addresses. You may pass In an array for multiple entries or a string for single entries. Each entry must be a full or partial MAC address. Alternatively, you may specify an empty array to revert to default (optional)
    
    
    .PARAMETER mac_deny
    Update the list of denied MAC addresses. You may pass In an array for multiple entries or a string for single entries. Each entry must be a full or partial MAC address. Alternatively, you may specify an empty array to revert to default (optional)
    
    
    .PARAMETER gateway
    Update the gateway to include In DHCP leases. This value must be a valid IPv4 address within the Interface's subnet. Alternatively, you can pass In an empty string to revert to the system default. (optional)
    
    
    .PARAMETER ignorebootp
    Update whether or not to ignore BOOTP requests. True to Ignore, false to allow. (optional)
    
    
    .PARAMETER denyunknown
    Update whether or not to ignore unknown MAC addresses. If true, you must specify MAC addresses in the�mac_allow�field or add a static DHCP entry to receive DHCP requests. (optional)
    # update DHCP interface 
    #>

    [CmdletBinding()]
    param (
        [Parameter()]
        $interface,
    
    
        [Parameter()]
        $enable,
    
    
        [Parameter()]
        $range_from,
    
    
        [Parameter()]
        $range_to,
    
    
        [Parameter()]
        $dnsserver,
    
    
        [Parameter()]
        $domain,
    
    
        [Parameter()]
        $domainsearchlist,
    
    
        [Parameter()]
        $mac_allow,
    
    
        [Parameter()]
        $mac_deny,
    
    
        [Parameter()]
        $gateway,
    
    
        [Parameter()]
        $ignorebootp,
    
    
        [Parameter()]
        $denyunknown
    )

    <#
    $interfacepayload = @{
        'interface'  = "Nginxz"
        'enable'     = $true
        'range_from' = "10.120.1.10"
        'range_to'   = "10.120.1.100"
        'dnsserver'  = "1.1.1.1"
        'gateway'    = "10.120.1.1"
    }

    $jsonbody = $interfacepayload | ConvertTo-Json


    $data = invoke-restmethod "https://192.168.2.1/api/v1/services/dhcpd"  -Headers $headers -Body $jsonbody -method "PUT"
    $data.data

    #>

    begin {
    }
    
    process {
        $payload = @{}
    
        foreach ($param in $PSBoundParameters.GetEnumerator()) {
            # Skip any common parameters (Debug, Verbose, etc)
            if ([System.Management.Automation.PSCmdlet]::CommonParameters -contains $param.key) {
                continue
            }
            $payload.add($param.Key, $param.Value)
        }      
    }
    end {

        $jsonpayload = $payload | ConvertTo-Json
        write-verbose $jsonpayload
        invoke-restmethod "$($pfsenseconnection.server)api/v1/services/dhcpd" -Headers $pfsenseconnection.headers -body $jsonpayload -method "PUT"
    }


}