enum Action
{
    GET
    PUT
    POST
    DELETE
}
 class TrueNasServer
{
    [String] $CommonName
    [ipaddress]$ServerAddress
    [String]$Uri
    [string]$BaseUri
    [PSobject]$Params
    [String]$ConnectionType


    TrueNasServer ([String]$CommonName, [ipaddress]$ServerAddress, [String]$ConnectionType)
    {
        $This.CommonName = $CommonName
        $This.ServerAddress = $ServerAddress
        switch ($ConnectionType)
        {
            http
            {
                $This.Uri = "http://$ServerAddress/api/v2.0"
                $This.BaseUri = "http://$ServerAddress/api/v2.0"
            }
            https
            {
                $This.Uri = "https://$ServerAddress/api/v2.0"
                $This.BaseUri = "https://$ServerAddress/api/v2.0"
            }
        }
        $This.ConnectionType = $ConnectionType
    }

    SetConnection([object]$param)
    {

        $ParamConnection = [Connection]::new($param)

        $ParamConnection.ConnectTrueNas()
        $this.Params = $ParamConnection.getConnectionSession()
    }

    TrueNasRestMethod([String]$Url, [string]$Method, [psobject]$Body)
    {
        if ([enum]::GetNames("Action").Contains($Method))
        {

            switch ($This.ConnectionType)
            {
                http { $This.Uri = $This.BaseUri + "/" + "$Url" }
                https { $This.Uri = $This.BaseUri + "/" + "$Url" }
                try
                {
                    if ($body)
                    {
                        # $response = Invoke-RestMethod  $This.Uri -Method $method -body ($body | ConvertTo-Json -Compress -Depth 5) -WebSession $Script:Session -headers $Script:headers @invokeParams
                    }
                }

                catch
                {
                    #Show-TrueNasException $_
                    throw "Unable to use TrueNAS API"
                }
            }
            else {

                Write-Warning "The Method is not recognozied or available"
            }
        }
    }
    [object]TrueNasRestMethod([String]$Url, [string]$Method)
    {
        $response = $null
        if ([enum]::GetNames("Action").Contains($Method))
        {

            $This.Uri = $This.Uri + "/" + "$Url"
            $param = @{
                Uri        = $This.Uri
                Method     = $Method
                WebSession = $this.Params.Session
            }
            try
            {
                $response = Invoke-RestMethod  @param
            }
            catch
            {
                #Show-TrueNasException $_
                throw "Unable to use TrueNAS API"
            }
        }
        else
        {
            throw "The Method is not recognozied or available"
        }
        $This.Uri = $this.BaseUri
        return $response

    }

}

class Connection
{
    [String]$CommonName
    [ipaddress]$ServerAddress
    [String]$ConnectionType
    [String]$Uri
    [PSobject]$ParamC
    [TrueNasServer]$param
    [String]$ApiKey

    Connection([TrueNasServer]$param)
    {

        $This.CommonName = $param.CommonName
        $This.ServerAddress = $param.ServerAddress
        $This.ConnectionType = $param.ConnectionType
        $This.Uri = $param.Uri
    }
    ConnectTrueNas()
    {
        $Credentials = Get-Credential -Message 'Please enter administrative credentials for your TrueNas'
        $cred = $Credentials.username + ":" + $Credentials.GetNetworkCredential().Password
        $base64 = [System.Convert]::ToBase64String([System.Text.Encoding]::ASCII.GetBytes($cred))

        #headers, We need to have Content-type set to application/json...
        $headers = @{ Authorization = "Basic " + $base64; "Content-type" = "application/json" }
        $invokeParams = @{ UseBasicParsing = $true; SkipCertificateCheck = $true }

        if ($this.GetPsEdition() -eq "Desktop")
        {
            #Remove -SkipCertificateCheck from Invoke Parameter (not supported <= PS 5)
            $invokeParams.remove("SkipCertificateCheck")
        }
        switch ($This.ConnectionType)
        {
            http { $This.Uri = $This.Uri + "/system/info" }
            https
            {
                $This.Uri = $This.Uri + "/system/info"
                if ($this.GetPsEdition() -eq "Desktop")
                {

                    Write-Verbose -Message "Core Version try to Enable TLS 1.1 and 1.2"

                    $this.SetTrueNasCipherSSL()
                    #By Default
                    $this.SetTrueNasUntrustedSSL()

                }
            }
        }

        $TrueNas_S = $null
        $result = Invoke-RestMethod -Uri $This.Uri -Method Get -SessionVariable Truenas_S -headers $headers @invokeParams
        $Script:Session = $TrueNas_S
        Write-Host "Welcome on"$result.name"-"$result.version"-"$result.system_product""
        write -host $global:TrueNas_S
        $This.ParamC = New-Object -TypeName System.Collections.ArrayList
        $TrueNas_S

        $temp = New-Object -TypeName System.Object
        $temp | Add-Member -MemberType NoteProperty -Name "Session" -Value $Script:Session
        $temp | Add-Member -MemberType NoteProperty -Name "Headers" -Value $headers
        $temp | Add-Member -MemberType NoteProperty -Name "InvokeParams" -Value $invokeParams
        $This.ParamC.Add($temp) | Out-Null
        $This.Uri = $This.BaseUri
    }
    ConnectTrueNasApiKey([String]$ApiKey)
    {
        #headers, We need to have Content-type set to application/json...
        $headers = @{ Authorization = "Bearer " + $ApiKey; "Content-type" = "application/json" }
        $invokeParams = @{ UseBasicParsing = $true; SkipCertificateCheck = $true }

        if ($this.GetPsEdition() -eq "Desktop")
        {
            #Remove -SkipCertificateCheck from Invoke Parameter (not supported <= PS 5)
            $invokeParams.remove("SkipCertificateCheck")
        }
        switch ($This.ConnectionType)
        {
            http { $This.Uri = $This.Uri + "/system/info" }
            https
            {
                $This.Uri = $This.Uri + "/system/info"
                if ($this.GetPsEdition() -eq "Desktop")
                {

                    Write-Verbose -Message "Core Version try to Enable TLS 1.1 and 1.2"

                    $this.SetTrueNasCipherSSL()
                    #By Default
                    $this.SetTrueNasUntrustedSSL()

                }
            }
        }

        $TrueNas_S = $null
        $result = Invoke-RestMethod -Uri $This.Uri -Method Get -SessionVariable Truenas_S -headers $headers @invokeParams
        $Script:Session = $TrueNas_S
        Write-Host "Welcome on"$result.name"-"$result.version"-"$result.system_product""
        write -host $global:TrueNas_S
        $This.ParamC = New-Object -TypeName System.Collections.ArrayList
        $TrueNas_S

        $temp = New-Object -TypeName System.Object
        $temp | Add-Member -MemberType NoteProperty -Name "Session" -Value $Script:Session
        $temp | Add-Member -MemberType NoteProperty -Name "Headers" -Value $headers
        $temp | Add-Member -MemberType NoteProperty -Name "InvokeParams" -Value $invokeParams
        $This.ParamC.Add($temp) | Out-Null
        $This.Uri = $This.BaseUri
    }
    hidden SetTrueNasCipherSSL()
    {

        $AllProtocols = [System.Net.SecurityProtocolType]'Ssl3,Tls,Tls11,Tls12'
        [System.Net.ServicePointManager]::SecurityProtocol = $AllProtocols

    }
    hidden SetTrueNasUntrustedSSL()
    {

        # Hack for allowing untrusted SSL certs with https connections
        Add-Type -TypeDefinition @"
    using System.Net;
    using System.Security.Cryptography.X509Certificates;
    public class TrustAllCertsPolicy : ICertificatePolicy {
        public bool CheckValidationResult(
        ServicePoint srvPoint, X509Certificate certificate,
        WebRequest request, int certificateProblem) {
            return true;
        }
    }
"@
        [System.Net.ServicePointManager]::CertificatePolicy = New-Object -TypeName TrustAllCertsPolicy
    }

    [Bool]IsPsVersionSupported()
    {
        Return ($script:PSVersionTable.PSVersion.Major -ge 5)
    }
    [String]GetPsVersion()
    {
        return ($script:PSVersionTable).PSVersion.ToString()
    }
    [string]GetPsEdition()
    {
        return ($script:PSVersionTable).PsEdition.ToString()
    }
    [PSobject]getConnectionSession()
    {
        return $This.ParamC
    }
}

class TrueNasConfiguration
{
    [String] $CommonName
    [String]$Uri
    [PSobject]$Params

    TrueNasConfiguration([TrueNasServer]$param)
    {
        $this.CommonName = $param.CommonName
        $this.Uri = $param.Uri
        $this.Params = $param.Params
    }
    TrueNasConfiguration([TrueNasConfiguration]$param)
    {
        $this.CommonName = $param.CommonName
        $this.Uri = $param.Uri
        $this.Params = $param.Params
    }
    [object]TrueNasRestMethod([String]$Url, [string]$Method)
    {
        $response = $null
        if ([enum]::GetNames("Action").Contains($Method))
        {
            $This.Uri = $This.Uri + "/" + "$Url"
            $settings = @{
                Uri                  = $This.Uri
                Method               = $Method
                WebSession           = $this.Params.Session
                SkipCertificateCheck = $true
                UseBasicParsing      = $true

            }
            try
            {
                $response = Invoke-RestMethod  @settings
            }
            catch
            {
                throw "Unable to use TrueNAS API"
            }
        }
        else
        {
            throw "The Method is not recognozied or available"
        }
        $This.Uri = $this.BaseUri
        return $response
    }
    [object]TrueNasRestMethod([String]$Url, [string]$Method, [psobject]$Body)
    {
        $response = $null
        if ([enum]::GetNames("Action").Contains($Method))
        {
            $This.Uri = $This.Uri + "/" + "$Url"
            $settings = @{
                Uri                  = $This.Uri
                Method               = $Method
                $Body                = ($Body | ConvertTo-Json -Compress -Depth 5)
                WebSession           = $this.Params.Session
                SkipCertificateCheck = $true
                UseBasicParsing      = $true

            }
            try
            {
                $response = Invoke-RestMethod  @settings
            }
            catch
            {
                #Show-TrueNasException $_
                throw "Unable to use TrueNAS API"
            }
        }
        else
        {
            throw "The Method is not recognozied or available"
        }
        $This.Uri = $this.BaseUri
        return $response
    }
}



<#
$Server = [TrueNasServer]::new("OneServer", "192.168.1.240", "http")
$Server
$Server.SetConnection($server)
$configuration = [TrueNasConfiguration]::new($Server)
$configuration
$configRéseau = [TrueNasInterface]::new($configuration)
$configRéseau
$configRéseau.getInterface()

#$server.TrueNasRestMethod("interface", "GET")
#>
