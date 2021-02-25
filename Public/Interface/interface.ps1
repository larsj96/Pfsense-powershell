function Add-PfsenseInterface {
    <#
.PARAMETER if
Specify the physical interface to configure


.PARAMETER descr
Set a descriptive name for the new interface

.PARAMETER enable
Enable the interface upon creation. Do not specify this value to leave disabled.


.PARAMETER spoofmac
Set a custom MAC address to the interface (optional)


.PARAMETER mtu
Set a custom MTU for this interface (optional)


.PARAMETER mss
Set a custom MSS for the this interface (optional)


.PARAMETER media
Set a custom speed/duplex setting for this interface (optional)


.PARAMETER type
Set the interface IPv4 configuration type (optional)


.PARAMETER type6
Set the interface IPv6 configuration type (optional)


.PARAMETER ipaddr
Set the interface’s static IPv4 address (required if type is set to staticv4)


.PARAMETER subnet
Set the interface’s static IPv4 address’s subnet bitmask (required if type is set to staticv4)


.PARAMETER gateway
Set the interface network’s upstream gateway. This is only necessary on WAN/UPLINK interfaces (optional)


.PARAMETER ipaddrv6
Set the interface’s static IPv6 address (required if type6 is set to staticv6)


.PARAMETER subnetv6
Set the interface’s static IPv6 address’s subnet bitmask (required if type6 is set to staticv6)


.PARAMETER gatewayv6
Set the interface network’s upstream IPv6 gateway. This is only necessary on WAN/UPLINK interfaces (optional)


.PARAMETER ipv6usev4iface
Allow IPv6 to use IPv4 uplink connection (optional)


.PARAMETER dhcphostname
Set the IPv4 DHCP hostname. Only available when type is set to dhcp (optional)


.PARAMETER dhcprejectfrom
Set the IPv4 DHCP rejected servers. You may pass values in as array or as comma seperated string. Only available when type is set to dhcp (optional)


.PARAMETER aliasaddress
Set the IPv4 DHCP address alias. The value in this field is used as a fixed alias IPv4 address by the DHCP client (optional)


.PARAMETER aliassubnet
Set the IPv4 DHCP address aliases subnet (optional)


.PARAMETER advdhcppttimeout
Set the IPv4 DHCP protocol timeout interval. Must be numeric value greater than 1 (optional)


.PARAMETER advdhcpptretry
Set the IPv4 DHCP protocol retry interval. Must be numeric value greater than 1 (optional)


.PARAMETER advdhcpptselecttimeout
Set the IPv4 DHCP protocol select timeout interval. Must be numeric value greater than 0 (optional)


.PARAMETER advdhcpptreboot
Set the IPv4 DHCP protocol reboot interval. Must be numeric value greater than 1 (optional)


.PARAMETER advdhcpptbackoffcutoff
Set the IPv4 DHCP protocol backoff cutoff interval. Must be numeric value greater than 1 (optional)


.PARAMETER advdhcpptinitialinterval
Set the IPv4 DHCP protocol initial interval. Must be numeric value greater than 1 (optional)


.PARAMETER advdhcpconfigadvanced
Enable the IPv4 DHCP advanced configuration options. This enables the DHCP options listed below (optional)


.PARAMETER advdhcpsendoptions
Set a custom IPv4 send option (optional)


.PARAMETER advdhcprequestoptions
Set a custom IPv4 request option (optional)


.PARAMETER advdhcprequestoptions
Set a custom IPv4 required option (optional)


.PARAMETER advdhcpoptionmodifiers
Set a custom IPv4 optional modifier (optional)


.PARAMETER advdhcpconfigfileoverride
Enable local DHCP configuration file override (optional)


.PARAMETER advdhcpconfigfileoverridefile
Set the custom DHCP configuration file’s absolute path. This file must exist beforehand (optional)


.PARAMETER dhcpvlanenable
Enable DHCP VLAN prioritization (optional)


.PARAMETER dhcpcvpt
Set the DHCP VLAN priority. Must be a numeric value between 1 and 7 (optional)


.PARAMETER gateway6rd
Set the 6RD interface IPv4 gateway address. Only required when type6 is set to 6rd


.PARAMETER prefix6rd
Set the 6RD IPv6 prefix assigned by the ISP. Only required when type6 is set to 6rd


.PARAMETER prefix6rdv4plen
Set the 6RD IPv4 prefix length. This is typically assigned by the ISP. Only available when type6 is set to 6rd


.PARAMETER track6interface
Set the Track6 dynamic IPv6 interface. This must be a dynamically configured IPv6 interface. You may specify either the interface’s descriptive name, the pfSense ID (wan, lan, optx), or the physical interface id (e.g. igb0). Only required with type6 is set to track6

.PARAMETER track6prefixidhex
Set the IPv6 prefix ID. The value in this field is the (Delegated) IPv6 prefix ID. This determines the configurable network ID based
on the dynamic IPv6 connection. The default value is 0. Only available when type6 is set to track6


.PARAMETER apply
Specify whether or not you would like this interface to be applied immediately, or simply written to the configuration to be applied
later. Typically, if you are creating multiple interfaces at once it Is best to set this to false and apply the changes afterwards using the /api/v1/interface/apply endpoint. Otherwise, If you are only creating a single interface, you may set this true to apply it immediately. Defaults to false. (optional)


#>
    [CmdletBinding()]
    param 
    (
        [Parameter()]
        $if,
        [Parameter()]
        $descr,
        [Parameter()]
        $enable,
        [Parameter()]
        $spoofmac,
        [Parameter()]
        $mtu,
        [Parameter()]
        $mss,
        [Parameter()]
        $media,
        [Parameter()]
        $type,
        [Parameter()]
        $type6,
        [Parameter()]
        $ipaddr,
        [Parameter()]
        $subnet,
        [Parameter()]
        $gateway,
        [Parameter()]
        $ipaddrv6,
        [Parameter()]
        $subnetv6,
        [Parameter()]
        $gatewayv6,
        [Parameter()]
        $ipv6usev4iface,
        [Parameter()]
        $dhcphostname,
        [Parameter()]
        $dhcprejectfrom,
        [Parameter()]
        $aliasaddress,
        [Parameter()]
        $aliassubnet,
        [Parameter()]
        $advdhcppttimeout,
        [Parameter()]
        $advdhcpptretry,
        [Parameter()]
        $advdhcpptselecttimeout,
        [Parameter()]
        $advdhcpptreboot,
        [Parameter()]
        $advdhcpptbackoffcutoff,
        [Parameter()]
        $advdhcpptinitialinterval,
        [Parameter()]
        $advdhcpconfigadvanced,
        [Parameter()]
        $advdhcpsendoptions,
        [Parameter()]
        $advdhcprequestoptions,
        [Parameter()]
        $advdhcpoptionmodifiers,
        [Parameter()]
        $advdhcpconfigfileoverride,
        [Parameter()]
        $advdhcpconfigfileoverridefile,
        [Parameter()]
        $dhcpvlanenable,
        [Parameter()]
        $dhcpcvpt,
        [Parameter()]
        $gateway6rd,
        [Parameter()]
        $prefix6rd,
        [Parameter()]
        $prefix6rdv4plen,
        [Parameter()]
        $track6interface,
        [Parameter()]
        $track6prefixidhex,
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
        invoke-restmethod "$($pfsenseconnection.server)api/v1/interface/"  -Headers $pfsenseconnection.headers -body $jsonpayload -method "POST"



    }
}
function update-PfsenseInterface {
    <#
.PARAMETER id
Specify the Interface to update. You may specify either the interface’s descriptive name, the pfSense ID (wan, lan, optx), or the physical interface id (e.g. igb0)


.PARAMETER if
Update the physical interface configured (optional)


.PARAMETER descr
Update the descriptive name of the interface (optional)


.PARAMETER enable
Enable or disable the Interface (optional)


.PARAMETER spoofmac
Update the MAC address of the interface (optional)


.PARAMETER mtu
Update the MTU for this interface (optional)


.PARAMETER mss
Update the MSS for the this interface (optional)


.PARAMETER media
Update the speed/duplex setting for this interface (optional)


.PARAMETER type
Update the interface IPv4 configuration type (optional)


.PARAMETER type6
Update the interface IPv6 configuration type (optional)


.PARAMETER ipaddr
Update the interface’s static IPv4 address (required if type is set to staticv4)


.PARAMETER subnet
Update the interface’s static IPv4 address’s subnet bitmask (required if type is set to staticv4)


.PARAMETER gateway
Update the interface network’s upstream gateway. This is only necessary on WAN/UPLINK interfaces (optional)


.PARAMETER ipaddrv6
Update the interface’s static IPv6 address (required if type6 is set to staticv6)


.PARAMETER subnetv6
Update the interface’s static IPv6 address’s subnet bitmask (required if type6 is set to staticv6)


.PARAMETER gatewayv6
Update the interface network’s upstream IPv6 gateway. This is only necessary on WAN/UPLINK interfaces (optional)


.PARAMETER ipv6usev4iface
Enable or disable IPv6 over IPv4 uplink connection (optional)


.PARAMETER dhcphostname
Update the IPv4 DHCP hostname. Only available when type is set to dhcp (optional)


.PARAMETER dhcprejectfrom
Update the IPv4 DHCP rejected servers. You may pass values in as array or as comma seperated string. Only available when type is set to dhcp (optional)


.PARAMETER alias-address
Update the IPv4 DHCP address alias. The value in this field is used as a fixed alias IPv4 address by the DHCP client (optional)


.PARAMETER alias-subnet
Update the IPv4 DHCP address aliases subnet (optional)


.PARAMETER adv_dhcp_pt_timeout
Update the IPv4 DHCP protocol timeout interval. Must be numeric value greater than 1 (optional)


.PARAMETER adv_dhcp_pt_retry
Update the IPv4 DHCP protocol retry interval. Must be numeric value greater than 1 (optional)


.PARAMETER adv_dhcp_pt_select_timeout
Update the IPv4 DHCP protocol select timeout interval. Must be numeric value greater than 0 (optional)


.PARAMETER adv_dhcp_pt_reboot
Update the IPv4 DHCP protocol reboot interval. Must be numeric value greater than 1 (optional)


.PARAMETER adv_dhcp_pt_backoff_cutoff
Update the IPv4 DHCP protocol backoff cutoff interval. Must be numeric value greater than 1 (optional)


.PARAMETER adv_dhcp_pt_initial_interval
Update the IPv4 DHCP protocol initial interval. Must be numeric value greater than 1 (optional)


.PARAMETER adv_dhcp_config_advanced
Enable or disable the IPv4 DHCP advanced configuration options. This enables the DHCP options listed below (optional)


.PARAMETER adv_dhcp_send_options
Update the IPv4 send option (optional)


.PARAMETER adv_dhcp_request_options
Update the IPv4 request option (optional)


.PARAMETER adv_dhcp_request_options
Update the IPv4 required option (optional)


.PARAMETER adv_dhcp_option_modifiers
Update the IPv4 optionamodifier (optional)


.PARAMETER adv_dhcp_config_file_override
Enable or disable local DHCP configuration file override (optional)


.PARAMETER adv_dhcp_config_file_override_file
Update the custom DHCP configuration file’s absolute path. This file must exist beforehand (optional)


.PARAMETER dhcpvlanenable
Enable or disable DHCP VLAN prioritization (optional)


.PARAMETER dhcpcvpt
Update the DHCP VLAN priority. Must be a numeric value between 1 and 7 (optional)


.PARAMETER gateway-6rd
Update the 6RD interface IPv4 gateway address. Only required when type6 is set to 6rd


.PARAMETER prefix-6rd
Update the 6RD IPv6 prefix assigned by the ISP. Only required when type6 is set to 6rd


.PARAMETER prefix-6rd-v4plen
Update the 6RD IPv4 prefix length. This is typically assigned by the ISP. Only available when type6 is set to 6rd


.PARAMETER track6-interface
Update the Track6 dynamic IPv6 interface. This must be a dynamically configured IPv6 interface. You may specify either the interface’s descriptive name, the pfSense ID (wan, lan, optx), or the physical interface id (e.g. igb0). Only required with type6 is set to track6


.PARAMETER track6-prefix-id-hex
Update the IPv6 prefix ID. The value in this field is the (Delegated) IPv6 prefix ID. This determines the configurable network ID based on the dynamic IPv6 connection. The default value is 0. Only available when type6 is set to track6


.PARAMETER apply
Specify whether or not you would like this interface update to be applied immediately, or simply written to the configuration to be
applied later. Typically, if you are updating multiple interfaces at once it Is best to set this to false and apply the changes afterwards using the /api/v1/interface/apply endpoint. Otherwise, If you are only updating a single interface, you may set this true to
apply it immediately. Defaults to false. (optional)
#>
    [CmdletBinding()]
    param (

        [Parameter()]
        $id,
  
  
        [Parameter()]
        $if,
  
  
        [Parameter()]
        $descr,
  
  
        [Parameter()]
        $enable,
  
  
        [Parameter()]
        $spoofmac,
  
  
        [Parameter()]
        $mtu,
  
  
        [Parameter()]
        $mss,
  
  
        [Parameter()]
        $media,
  
  
        [Parameter()]
        $type,
  
  
        [Parameter()]
        $type6,
  
  
        [Parameter()]
        $ipaddr,
  
  
        [Parameter()]
        $subnet,
  
  
        [Parameter()]
        $gateway,
  
  
        [Parameter()]
        $ipaddrv6,
  
  
        [Parameter()]
        $subnetv6,
  
  
        [Parameter()]
        $gatewayv6,
  
  
        [Parameter()]
        $ipv6usev4iface,
  
  
        [Parameter()]
        $dhcphostname,
  
  
        [Parameter()]
        $dhcprejectfrom,
  
  
        [Parameter()]
        $aliasaddress,
  
  
        [Parameter()]
        $aliassubnet,
  
  
        [Parameter()]
        $advdhcppttimeout,
  
  
        [Parameter()]
        $advdhcpptretry,
  
  
        [Parameter()]
        $advdhcpptselecttimeout,
  
  
        [Parameter()]
        $advdhcpptreboot,
  
  
        [Parameter()]
        $advdhcpptbackoffcutoff,
  
  
        [Parameter()]
        $advdhcpptinitialinterval,
  
  
        [Parameter()]
        $advdhcpconfigadvanced,
  
  
        [Parameter()]
        $advdhcpsendoptions,
  
  
        [Parameter()]
        $advdhcprequestoptions,
  
  
        [Parameter()]
        $advdhcpoptionmodifiers,
  
  
        [Parameter()]
        $advdhcpconfigfileoverride,
  
  
        [Parameter()]
        $advdhcpconfigfileoverridefile,
  
  
        [Parameter()]
        $dhcpvlanenable,
  
  
        [Parameter()]
        $dhcpcvpt,
  
  
        [Parameter()]
        $gateway6rd,
  
  
        [Parameter()]
        $prefix6rd,
  
  
        [Parameter()]
        $prefix6rdv4plen,
  
  
        [Parameter()]
        $track6interface,
  
  
        [Parameter()]
        $track6prefixidhex,
  
  
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
        invoke-restmethod "$($pfsenseconnection.server)api/v1/interface/"  -Headers $pfsenseconnection.headers -body $jsonpayload -method "PUT"


    }

}
