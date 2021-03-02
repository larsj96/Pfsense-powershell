function New-PfsenseFirewallRule {
    <#
.PARAMETER type
Set a firewall rule type (pass,�block,�reject)


.PARAMETER interface
Set which interface the rule will apply to. You may specify either the interface?s descriptive name, the pfSense ID (wan, lan, optx), or the physical interface id (e.g. igb0). Floating rules are not supported.


.PARAMETER ipprotocol
Set which IP protocol(s) the rule will apply to (inet,�inet6,�inet46)


.PARAMETER protocol
Set which transfer protocol the rule will apply to. If�tcp,�udp,�tcp/udp, you must define a source and destination port


.PARAMETER icmptype
Set the ICMP subtype of the firewall rule. Multiple values may be passed in as array, single values may be passed as string.�Only available when�protocol�is set to�icmp. If�icmptype�is not specified all subtypes are assumed


.PARAMETER src
Set the source address of the firewall rule. This may be a single IP, network CIDR, alias name, or interface. When specifying an interface, you may use the physical interface ID, the descriptive interfance name, or the pfSense ID. To use only interface address, add�ip�to the end of the interface name otherwise the
entire interface?s subnet is implied. To negate the context of the source address, you may prepend the address with�!


.PARAMETER dst
Set the destination address of the firewall rule. This may be a single IP, network CIDR, alias name, or interface. When specifying an interface, you may use the physical interface ID, the descriptive interface name, or the pfSense ID. To only use interface address, add�ip�to the end of the interface name otherwise
the entire interface?s subnet is implied. To negate the context of the source address, you may prepend the address with�!


.PARAMETER srcport
Set the TCP and/or UDP source port or port alias of the firewall rule. This is only necessary if you have specified the�protocol�to�tcp,�udp,�tcp/udp


.PARAMETER dstport
Set the TCP and/or UDP destination port or port alias of the firewall rule. This is only necessary if you have specified the�protocol�to�tcp,�udp,�tcp/udp


.PARAMETER gateway
Set the routing gateway traffic will take upon match (optional)


.PARAMETER disabled
Disable the rule upon creation (optional)


.PARAMETER descr
Set a description for the rule (optional)


.PARAMETER log
Enabling rule matche logging (optional)


.PARAMETER top
Add firewall rule to top of access control list (optional)


.PARAMETER apply
Specify whether or not you would like this rule to be applied immediately, or simply written to the configuration to be applied later. Typically, if you are creating multiple rules at once it Is best to set this to false and apply the changes afterwards using the�/api/v1/firewall/apply�endpoint. Otherwise, If you are only creating a single rule, you may set this true to apply it immediately. Defaults to false. (optional)

.EXAMPLE
New-PfsenseFirewallRule -type "block" -interface "WAN" -protocol "tcp/udp" -src "192.168.1.0/24" -srcport "any" -dst "192.168.2.0/24" -ipprotocol "inet" -dstport "443" -descr "This is a test rule added via API"

#>

    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true,
            ValueFromPipeline = $true)]
        [ValidateNotNullorEmpty()]
        [ValidateSet(
            "pass",
            "block",
            "reject"
        )]
        [string]
        $type,

        [Parameter()]
        [string]
        $interface,

        [Parameter(Mandatory = $true,
            ValueFromPipeline = $true)]
        [ValidateNotNullorEmpty()]
        [ValidateSet(
            "inet",
            "inet6",
            "inet46"
        )]
        [string]
        $ipprotocol,

        
        [Parameter(Mandatory = $true,
            ValueFromPipeline = $true)]
        [ValidateNotNullorEmpty()]
        [ValidateSet(
            "tcp",
            "udp", 
            "tcp/udp"
        )]
        [string]
        $protocol, #tcp, udp, tcp/udp

        [Parameter()]
        $icmptype,

        [Parameter()]
        $src,

        [Parameter()]
        $dst,

        [Parameter()]
        $srcport,

        [Parameter()]
        $dstport,

        [Parameter()]
        $gateway,

        [Parameter()]
        $disabled,

        [Parameter()]
        $descr,

        [Parameter()]
        $log,

        [Parameter()]
        $top,

        [Parameter()]
        $apply
    )
    
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
        $jsonpayload = $payload |  ConvertTo-Json

        write-verbose $jsonpayload
        invoke-restmethod "$($pfsenseconnection.server)api/v1/firewall/rule"  -Headers $pfsenseconnection.headers -body $jsonpayload -method "POST"

    }
}

function Remove-PfsenseFirewallRule {

    <#
.PARAMETER tracker	
Specify the rule tracker ID to delete

.PARAMETER apply	
Specify whether or not you would like this rule deletion to be applied immediately, or simply written to the configuration to be applied later. Typically, if you are deleting multiple rules at once it Is best to set this to false and apply the changes afterwards using the /api/v1/firewall/apply endpoint. Otherwise, If you are only deleting a single rule, you may set this true to apply it immediately. Defaults to false. (optional)

#>

    [CmdletBinding()]
    param (
        [Parameter()]
        $tracker,


        [Parameter()]
        $apply
    )
    
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

        Write-Warning "Use caution when making this call, removing rules may result in API/webConfigurator lockout"

    }
    end {
        $jsonpayload = $payload | ConvertTo-Json

        write-verbose $jsonpayload
        invoke-restmethod "$($pfsenseconnection.server)api/v1/firewall/rule"  -Headers $pfsenseconnection.headers -body $jsonpayload -method "DELETE"

    }
}

function Update-PfsenseFirewallRule {
    <#
.PARAMETER tracker
Specify the tracker ID of the rule to update


.PARAMETER type
Update the firewall rule type (pass,�block,�reject) (optional)


.PARAMETER interface
Update the interface the rule will apply to. You may specify either the interface?s descriptive name, the pfSense ID (wan, lan, optx), or the physical interface id (e.g. igb0). Floating rules are not supported. (optional)


.PARAMETER ipprotocol
Update which IP protocol(s) the rule will apply to (inet,�inet6,�inet46) (optional)


.PARAMETER protocol
Update the transfer protocol the rule will apply to. If�tcp,�udp,�tcp/udp, you must define a source and destination port. (optional)


.PARAMETER icmptype
Update the ICMP subtype of the firewall rule. Multiple values may be passed in as array, single values may be passed as string.�Only available when�protocol�is set to�icmp. If�icmptype�is not specified all subtypes are assumed�(optional)


.PARAMETER src
Update the source address of the firewall rule. This may be a single IP, network CIDR, alias name, or interface. When specifying an interface, you may use the physical interface ID, the descriptive interfance name, or the pfSense ID. To use only interface address, add�ip�to the end of the interface name otherwise the entire interface?s subnet is implied. To negate the context of the source address, you may prepend the address with�!�(optional)


.PARAMETER dst
Update the destination address of the firewall rule. This may be a single IP, network CIDR, alias name, or interface. When specifying an interface, you may use the physical interface ID, the descriptive interface name, or the pfSense ID. To only use interface address, add�ip�to the end of the interface name otherwise the entire interface?s subnet is implied. To negate the context of the source address, you may prepend the address with�!�(optional)


.PARAMETER srcport
Update the TCP and/or UDP source port or port alias of the firewall rule. This is only necessary if you have specified the�protocol�to�tcp,�udp,�tcp/udp�(optional)


.PARAMETER dstport
Update the TCP and/or UDP destination port or port alias of the firewall rule. This is only necessary if you have specified the�protocol�to�tcp,�udp,�tcp/udp


.PARAMETER gateway
Update the routing gateway traffic will take upon match (optional)


.PARAMETER disabled
Disable the rule upon modification (optional)


.PARAMETER descr
Update the description of the rule (optional)


.PARAMETER log
Enable rule matched logging (optional)


.PARAMETER top
Move firewall rule to top of access control list (optional)


.PARAMETER apply
Specify whether or not you would like this rule update to be applied immediately, or simply written to the configuration to be applied later. Typically, if you are updating multiple rules at once it Is best to set this to false and apply the changes afterwards using the�/api/v1/firewall/apply�endpoint. Otherwise, If you are only updating a single rule, you may set this true to apply it immediately. Defaults to false. (optional)

#>


    [CmdletBinding()]
    param (
        [Parameter()]
        $tracker,


        [Parameter()]
        $type,


        [Parameter()]
        $interface,


        [Parameter()]
        $ipprotocol,


        [Parameter()]
        $protocol,


        [Parameter()]
        $icmptype,


        [Parameter()]
        $src,


        [Parameter()]
        $dst,


        [Parameter()]
        $srcport,


        [Parameter()]
        $dstport,


        [Parameter()]
        $gateway,


        [Parameter()]
        $disabled,


        [Parameter()]
        $descr,


        [Parameter()]
        $log,


        [Parameter()]
        $top,


        [Parameter()]
        $apply
    )
    
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
        invoke-restmethod "$($pfsenseconnection.server)api/v1/firewall/rule"  -Headers $pfsenseconnection.headers -body $jsonpayload -method "PUT"

    }
}

function Get-PfsenseFirewallRule {
    [CmdletBinding()]
    param (
        
    )
    
    begin {
        
    }
    
    process {
        $data = invoke-restmethod "$($pfsenseconnection.server)api/v1/firewall/rule"  -Headers $pfsenseconnection.headers -method "GET"

        $data.data
    }
    
    end {
        
    }
}

New-PfsenseFirewallRule -type "block" -interface "WAN" -protocol "tcp/udp" -src "192.168.1.0/24" -srcport "any" -dst "192.168.2.0/24" -ipprotocol "inet" -dstport "443" -descr "This is a test rule added via API"