
function connect-pfsense {
    <#
        .NAME
    connect-pfsense
.SYNOPSIS
    Receive a temporary access token using your pfSense local database credentials (JTW)

.PARAMETER Credentials
 Specify the client’s pfSense username / password

.PARAMETER SkipCertificateCheck
 remove SSL check - requires PS core (powershell 6/ 7)


    #>
 
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, position = 1)]
        [String]$Server,
        [Parameter(Mandatory = $true)]
        [PSCredential]$Credentials,
        [Parameter(Mandatory = $false)]
        [switch]$SkipCertificateCheck = $false
    )

    begin {
    }
    
    process {
        
        $connection = @{server = ""; session = ""; invokeParams = "" }

        $postParams = @{
            'client-id'  = $Credentials.username
            'client-token' = $Credentials.GetNetworkCredential().Password
        }

        $postParams = $postParams |  ConvertTo-Json

        $invokeParams = @{DisableKeepAlive = $false; UseBasicParsing = $true; SkipCertificateCheck = $SkipCertificateCheck}


        if ("Desktop" -eq $PSVersionTable.PsEdition) {
            #Remove -SkipCertificateCheck from Invoke Parameter (not supported <= Windows powershell 5)
            $invokeParams.remove("SkipCertificateCheck")
        }
        else {
            #Core Edition
            #Remove -UseBasicParsing (Enable by default with PowerShell 7 /Core)
            $invokeParams.remove("UseBasicParsing")
        }

         $url = "https://${Server}/"
         $url

        $AuthResponse = Invoke-RestMethod -Uri "https://$server/api/v1/access_token" -Method "POST"  -Body $postParams @invokeParams
        
        $Headers = @{
            'Authorization' = "Bearer $($AuthResponse.data.token)"
        }

        $connection.server = $url
        $connection.headers = $headers
        $connection.invokeParams = $invokeParams


        set-variable -name pfsenseconnection -value $connection -scope Global
        Write-host "This PowerShell module is to be used with this rest API: https://github.com/jaredhendrickson13/pfsense-api" -ForegroundColor Green
    }
    
    end {
        
    }
}

