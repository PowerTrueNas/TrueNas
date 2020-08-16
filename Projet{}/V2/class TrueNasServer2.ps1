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
    [string]$BaseUri
    [PSobject]$Params
    [String]$ConnectionType


    TrueNasConfiguration([TrueNasServer]$param)
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
                Uri        = $This.Uri
                Method     = $Method
                WebSession = $this.Params.Session
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


    [object]getconfignetwork()
    {
        $reponse = $this.TrueNasRestMethod("interface" , "GET")
        return $reponse

    }
    [object]getconfigStorage()
    {
        $reponse = $this.TrueNasRestMethod("interface" , "GET")
        return $reponse

    }
    getconfigIscsi() {}

    getconfigCert() {}

    getconfigFull()
    {
        getconfignetwork
        getconfigStorage
        getconfigIscsi
        getconfigCert
    }
}

$Server = [TrueNasServer]::new("OneServer", "192.168.1.64", "http")
$Server
$Server.SetConnection($server)
$configuration = [TrueNasConfiguration]::new($Server)
$configuration.getconfignetwork()
#$server.TrueNasRestMethod("interface", "GET")

Invoke-WebRequest -Uri http://192.168.1.64/api/v2.0 -OutFile .\description.json
$tt = Get-Content .\description.json | ConvertFrom-Json -Depth 8
function ConvertTo-Hashtable
{
    [CmdletBinding()]
    [OutputType('hashtable')]
    param (
        [Parameter(ValueFromPipeline)]
        $InputObject
    )

    process
    {
        ## Return null if the input is null. This can happen when calling the function
        ## recursively and a property is null
        if ($null -eq $InputObject)
        {
            return $null
        }

        ## Check if the input is an array or collection. If so, we also need to convert
        ## those types into hash tables as well. This function will convert all child
        ## objects into hash tables (if applicable)
        if ($InputObject -is [System.Collections.IEnumerable] -and $InputObject -isnot [string])
        {
            $collection = @(
                foreach ($object in $InputObject)
                {
                    ConvertTo-Hashtable -InputObject $object
                }
            )

            ## Return the array but don't enumerate it because the object may be pretty complex
            Write-Output -NoEnumerate $collection
        }
        elseif ($InputObject -is [psobject])
        {
            ## If the object has properties that need enumeration
            ## Convert it to its own hash table and return it
            $hash = @{}
            foreach ($property in $InputObject.PSObject.Properties)
            {
                $hash[$property.Name] = ConvertTo-Hashtable -InputObject $property.Value
            }
            $hash
        }
        else
        {
            ## If the object isn't an array, collection, or other object, it's already a hash table
            ## So just return it.
            $InputObject
        }
    }
}
$ta = $tt | ConvertTo-Hashtable
$ta
$Tableau = $ta.paths.GetEnumerator() | Sort-Object -Property Key | Foreach-Object {
    $Methods = $_.value
    $Path = $_.Key
    $ListMethods = @()

    $Methods.GetEnumerator() | Foreach-Object {
        $rr = $_.value
        $zz = $_.Key
        $ListMethods += $ListMethods + $zz
    }

    $Domains_values = New-Object PSObject
    $Domains_values = $Domains_values | Add-Member NoteProperty Path $Path -passthru
    $Domains_values = $Domains_values | Add-Member NoteProperty Methods $ListMethods -passthru
    $Domains_values = $Domains_values | Add-Member NoteProperty Category $Path.Split("/")[1] -passthru
    return $Domains_values


}
$Tableau[0]
