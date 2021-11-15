
# TODO REPLACE local-port "with "-" instead of "_" (underscore)


function New-PfsenseFirewallNATPortForward {
    <#

.PARAMETER interface
Set which interface the rule will apply to. You may specify either the interface's descriptive name, the pfSense ID (wan, lan, optx), or the physical interface id (e.g. igb0). Floating rules are not supported.


.PARAMETER protocol
Set which transfer protocol the rule will apply to. If tcp, udp, tcp/udp, you must define a source and destination port


.PARAMETER src
Set the source address of the firewall rule. This may be a single IP, network CIDR, alias name, or interface. When specifying an interface, you may use the physical interface ID, the descriptive interface name, or the pfSense ID. To use only interface address, add ip to the end of the interface name otherwise the entire interface's subnet is implied. To negate the context of the source address, you may prepend the address with !


.PARAMETER dst
Set the destination address of the firewall rule. This may be a single IP, network CIDR, alias name, or interface. When specifying an interface, you may use the physical interface ID, the descriptive interface name, or the pfSense ID. To only use interface address, add ip to the end of the interface name otherwise the entire interface's subnet is implied. To negate the context of the source address, you may prepend the address with !


.PARAMETER srcport
Set the TCP and/or UDP source port of the firewall rule. This is only necessary if you have specified the protocol to tcp, udp, tcp/udp


.PARAMETER dstport
Set the TCP and/or UDP destination port of the firewall rule. This is only necessary if you have specified the protocol to tcp, udp, tcp/udp


.PARAMETER target
Specify the IP to forward traffic to


.PARAMETER local_port
Set the TCP and/or UDP port to forward traffic to. This is only necessary if you have specified the protocol to tcp, udp, tcp/udp. Port ranges may be specified using colon or hyphen.


.PARAMETER natreflection
Set the NAT reflection mode explicitly (optional)

.PARAMETER descr
Set a description for the rule (optional)


.PARAMETER disabled
Disable the rule upon creation (optional)


.PARAMETER top
Add this port forward rule to top of access control list (optional)


.PARAMETER apply
Specify whether or not you would like this port forward to be applied immediately, or simply written to the configuration to be applied later. Typically, if you are creating multiple port forwards at once it Is best to set this to false and apply the changes afterwards using the /api/v1/firewall/apply endpoint. Otherwise, If you are only creating a single port forward, you may set this true to apply it immediately. Defaults to false. (optional)


#>

    [CmdletBinding()]
    param (
        [Parameter()]
        $interface,
        
      
        [Parameter()]
        $protocol,
        
      
        [Parameter()]
        $src,
        
      
        [Parameter()]
        $dst,
        
      
        [Parameter()]
        $srcport,
        
      
        [Parameter()]
        $dstport,
        
      
        [Parameter()]
        $target,
        
        [Parameter()]
        $localport,
        
      
        [Parameter()]
        $natreflection,
        
      
        [Parameter()]
        $descr,
        
      
        [Parameter()]
        $disabled,
        
      
        [Parameter()]
        $top,
        
      
        [Parameter()]
        $apply

    )

    begin {
        
    }
    
    process {
        $payload = @{}
    

        $PSBoundParameters.Remove('localport') 
        foreach ($param in $PSBoundParameters.GetEnumerator()) {
            # Skip any common parameters (Debug, Verbose, etc)
            if ([System.Management.Automation.PSCmdlet]::CommonParameters -contains $param.key) {
                continue
            
            }      

            $payload.add($param.Key, $param.Value)
            write-host $payload -ForegroundColor Yellow
        }
    }
    end {
        $jsonpayload = $payload |  ConvertTo-Json

        # Be aware that "local-port" uses "-" instead of "_"

        write-verbose $jsonpayload
        invoke-restmethod "$($pfsenseconnection.server)api/v1/firewall/nat/port_forward"  -Headers $pfsenseconnection.headers -body $jsonpayload -method "POST"
    }
}

function Remove-PfsenseFirewallNATPortForward {
    <#
.PARAMETER id
Specify the rule ID to delete

.PARAMETER APPLY
Specify whether or not you would like this port forward deletion to be applied immediately, or simply written to the configuration to be applied later. Typically, if you are deleting multiple port forwards at once it Is best to set this to false and apply the changes afterwards using the /api/v1/firewall/apply endpoint. Otherwise, If you are only deleting a single port forward, you may set this true to apply it immediately. Defaults to false. (optional)

#>


    [CmdletBinding()]
    param (
        [Parameter()]
        $id,

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
        invoke-restmethod "$($pfsenseconnection.server)api/v1/firewall/nat/port_forward"  -Headers $pfsenseconnection.headers -body $jsonpayload -method "DELETE"

    }


}

function update-PfsenseFirewallNATPortForward {
    <#
.PARAMETER Id
Specify the ID of the port forward rule to update.


.PARAMETER interface
Update the interface the rule will apply to. You may specify either the interface's descriptive name, the pfSense ID (wan, lan, optx), or the physical interface id (e.g. igb0). Floating rules are not supported. (optional)


.PARAMETER protocol
Update which transfer protocol the rule will apply to. If tcp, udp, tcp/udp, you must define a source and destination port. (optional)


.PARAMETER src
Update the source address of the firewall rule. This may be a single IP, network CIDR, alias name, or interface. When specifying an interface, you may use the physical interface ID, the descriptive interface name, or the pfSense ID. To use only interface address, add ip to the end of the interface
name otherwise the entire interface's subnet is implied. To negate the context of the source address, you may prepend the address with ! (optional)


.PARAMETER dst
Update the destination address of the firewall rule. This may be a single IP, network CIDR, alias name, or interface. When specifying an interface, you may use the physical interface ID, the descriptive interface name, or the pfSense ID. To only use interface address, add ip to the end of the interface name otherwise the entire interface's subnet is implied. To negate the context of the source address, you may prepend the address with ! (optional)


.PARAMETER srcport
Update the TCP and/or UDP source port of the firewall rule. This is only necessary if you have specified the protocol to tcp, udp, tcp/udp (optional)


.PARAMETER dstport
Update the TCP and/or UDP destination port of the firewall rule. This is only necessary if you have specified the protocol to tcp, udp, tcp/udp (optional)


.PARAMETER target
Update the IP to forward traffic to (optional)


.PARAMETER local_port
Update the TCP and/or UDP port to forward traffic to. This is only necessary if you have specified the protocol to tcp, udp, tcp/udp. Port ranges may be specified using colon or hyphen. (optional)


.PARAMETER natreflection
Update the NAT reflection mode explicitly (optional)


.PARAMETER descr
Update a description for the rule (optional)


.PARAMETER disabled
Enable or disable the rule upon creation. True to disable, false to enable (optional)


.PARAMETER top
Move this port forward rule to top of access control list (optional)


.PARAMETER apply
Specify whether or not you would like this port forward update to be applied immediately, or simply written to the configuration to be applied later. Typically, if you are updating multiple port forwards at once it Is best to set this to false and apply the changes afterwards using the /api/v1/firewall/apply endpoint. Otherwise, If you are only updating a single port forward, you may set this true to apply it immediately. Defaults to false. (optional)

#>
    [CmdletBinding()]
    param (

        [Parameter()]
        $Id,


        [Parameter()]
        $interface,


        [Parameter()]
        $protocol,


        [Parameter()]
        $src,


        [Parameter()]
        $dst,


        [Parameter()]
        $srcport,


        [Parameter()]
        $dstport,


        [Parameter()]
        $target,


        [Parameter()]
        $local_port,


        [Parameter()]
        $natreflection,


        [Parameter()]
        $descr,


        [Parameter()]
        $disabled,


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
            write-host $param
            $payload.add($param.Key, $param.Value)
        }      
    }
    end {
        $jsonpayload = $payload |  ConvertTo-Json

        # Be aware that "local-port" uses "-" instead of "_"

        write-verbose $jsonpayload
        invoke-restmethod "$($pfsenseconnection.server)api/v1/firewall/nat/port_forward"  -Headers $pfsenseconnection.headers -body $jsonpayload -method "PUT"
    }


}

function Get-PfsenseFirewallNATPortForward {

    [CmdletBinding()]
    param (
        
    )
    
    begin {
        
    }
    
    process {
        $data = invoke-restmethod "$($pfsenseconnection.server)api/v1/firewall/nat/port_forward"  -Headers $pfsenseconnection.headers -method "GET"
        $data.data
    }
    
    end {
        
    }
}