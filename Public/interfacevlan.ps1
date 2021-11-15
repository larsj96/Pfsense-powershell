function New-PfsenseInterfaceVlan {
    <#

.PARAMETER if
Set the parent interface to add the new VLAN to


.PARAMETER tag
Set the VLAN tag to add to the parent interface


.PARAMETER pcp
Set a 802.1Q VLAN priority. Must be an integer value between 0 and 7 (optional)


.PARAMETER descr
Set a description for the new VLAN interface

#>
    [CmdletBinding()]
    param (
        
        [Parameter()]
        $if,


        [Parameter()]
        $tag,


        [Parameter()]
        $pcp,


        [Parameter()]
        $descr
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
        invoke-restmethod "$($pfsenseconnection.server)api/v1/interface/vlan" -Headers $pfsenseconnection.headers -body $jsonpayload -method "POST"


    }


}
function Get-PfsenseInterfaceVlan {
    $data = invoke-restmethod "$($pfsenseconnection.server)api/v1/interface/vlan"  -Headers $pfsenseconnection.headers  -method "get"
    $data.data
}
function Update-PfsenseInterfaceVlan {
    <#

    .PARAMETER vlanif
Select VLAN to modify by full interface ID (e.g.�em0.2)


.PARAMETER id
Select VLAN to modify by pfSense ID. Required if�vlanif�was not specified previously. If�vlanif�is specified, this value will be overwritten.


.PARAMETER if
Set the parent interface to add the new VLAN to


.PARAMETER tag
Set the VLAN tag to add to the parent interface


.PARAMETER pcp
Set a 802.1Q VLAN priority. Must be an integer value between 0 and 7 (optional)

.PARAMETER descr
Set a description for the new VLAN interface

    #>

    
    [CmdletBinding()]
    param (
        [Parameter()]
        $vlanif,
      
        [Parameter()]
        $id,
      
        [Parameter()]
        $if,
      
        [Parameter()]
        $tag,
      
        [Parameter()]
        $pcp,
      
        [Parameter()]
        $descr
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
        invoke-restmethod "$($pfsenseconnection.server)api/v1/interface/vlan" -Headers $pfsenseconnection.headers -body $jsonpayload -method "PUT"
    }

}

function Remove-PfsenseInterfaceVlan {
    <#
.PARAMETER if
Delete VLAN by full interface name (e.g. em0.2).

#>
    [CmdletBinding()]
    param (
        [Parameter()]
        $vlanif
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
        invoke-restmethod "$($pfsenseconnection.server)api/v1/interface/vlan"  -Headers $pfsenseconnection.headers -body $jsonpayload -method "DELETE"
    }
}