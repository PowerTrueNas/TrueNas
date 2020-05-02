function Connect-TrueNasServer
{
    [CmdletBinding()]
    [Alias()]
    [OutputType([String])]
    Param
    (
        # Description d’aide Truenas
        [Parameter(Mandatory = $true)]
        [Alias("Truenas")]
        $Server,
        [Parameter(Mandatory = $false)]
        [String]$Username,
        [Parameter(Mandatory = $false)]
        [SecureString]$Password,
        [Parameter(Mandatory = $false)]
        [PSCredential]$Credentials,
        [Parameter(Mandatory = $false)]
        [switch]$httpOnly = $false,
        [Parameter(Mandatory = $false)]
        [switch]$SkipCertificateCheck = $false,
        [Parameter(Mandatory = $false)]
        [ValidateRange(1, 65535)]
        [int]$port
    )

    Begin
    {
    }
    Process
    {
        $Script:SrvFreenas = $Server


        #If there is a password (and a user), create a credentials
        if ($Password)
        {
            $Credentials = New-Object -TypeName System.Management.Automation.PSCredential($Username, $securecurepassword)
        }
        #Not Credentials (and no password)
        if ($NULL -eq $Credentials)
        {
            $Credentials = Get-Credential -Message 'Please enter administrative credentials for your TrueNas'
        }
        $cred = $Credentials.username + ":" + $Credentials.GetNetworkCredential().Password
        $base64 = [System.Convert]::ToBase64String([System.Text.Encoding]::ASCII.GetBytes($cred))
        #headers, We need to have Content-type set to application/json...
        $script:headers = @{ Authorization = "Basic " + $base64; "Content-type" = "application/json" }
        $script:invokeParams = @{ UseBasicParsing = $true; SkipCertificateCheck = $SkipCertificateCheck }

        if ("Desktop" -eq $PSVersionTable.PsEdition)
        {
            #Remove -SkipCertificateCheck from Invoke Parameter (not supported <= PS 5)
            $invokeParams.remove("SkipCertificateCheck")
        }

        if ($httpOnly)
        {
            if (!$port)
            {
                $port = 80
            }

            $uri = "http://${Server}:${port}/api/v2.0/system/info"

        }
        else
        {
            if (!$port)
            {
                $port = 443
            }
            #for PowerShell (<=) 5 (Desktop), Enable TLS 1.1, 1.2 and Disable SSL chain trust
            if ("Desktop" -eq $PSVersionTable.PsEdition)
            {
                Write-Verbose -Message "Desktop Version try to Enable TLS 1.1 and 1.2"
                #Enable TLS 1.1 and 1.2
                Set-TrueNasCipherSSL
                if ($SkipCertificateCheck)
                {
                    Write-Verbose -Message "Disable SSL chain trust"

                    #Disable SSL chain trust...
                    Set-TrueNasuntrustedSSL
                }

            }
            $uri = "http://${Server}:${port}/api/v2.0/system/info"

        }

        $script:port = $port
        $script:httpOnly = $httpOnly
        $Script:ApiVersion = $ApiVersion

        try
        {
            $result = Invoke-RestMethod -Uri $uri -Method Get -SessionVariable Truenas_S -headers $headers @invokeParams
        }
        catch
        {
            Show-TrueNasException -Exception $_
            throw "Unable to connect"
        }

        if ($null -eq $result.version )
        {
            throw "Unable to get data"
        }

        Write-Host "Welcome on"$result.name"-"$result.version"-"$result.system_product""

        $Script:Session = $Truenas_S


    }
    End
    {

    }
}
