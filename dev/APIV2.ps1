function Invoke-TrueNasRestMethod
{

    <#
      .SYNOPSIS
      Invoke RestMethod with TrueNas connection (internal) variable

      .DESCRIPTION
      Invoke RestMethod with TrueNas connection variable (token,.)

      .EXAMPLE
      Invoke-TrueNasRestMethod -method "get" -uri "api/v1.0/storage/disk/"

      Invoke-RestMethod with TrueNas connection for get api/v1.0/storage/disk/ uri
    #>

    Param(
        [Parameter(Mandatory = $true, position = 1)]
        [String]$uri,
        [Parameter(Mandatory = $false)]
        [ValidateSet("GET", "PUT", "POST", "DELETE")]
        [String]$method = "GET",
        [Parameter(Mandatory = $false)]
        [psobject]$body
    )

    Begin
    {

    }

    Process
    {

        if ($null -eq $Script:SrvFreenas)
        {
            Throw "Not Connected. Connect to the TrueNas with Connect-TrueNasServer"
        }

        $Server = $Script:SrvFreenas
        $sessionvariable = $Script:Session
        $headers = $Script:Headers
        $invokeParams = $Script:invokeParams
        $httpOnly = $Script:httpOnly
        $port = $Script:port

        if ($httpOnly)
        {
            $fullurl = "http://${Server}:${port}/${uri}"
        }
        else
        {
            $fullurl = "https://${Server}:${port}/${uri}"
        }

        try
        {
            if ($body)
            {
                $response = Invoke-RestMethod $fullurl -Method $method -body ($body | ConvertTo-Json -Compress -Depth 5) -WebSession $sessionvariable -headers $headers @invokeParams
            }
            else
            {
                $response = Invoke-RestMethod $fullurl -Method $method -WebSession $sessionvariable -headers $headers @invokeParams
            }
        }

        catch
        {
            Show-TrueNasException $_
            throw "Unable to use TrueNAS API"
        }
        $response

    }

}

function Set-TrueNasCipherSSL
{

    # Hack for allowing TLS 1.1 and TLS 1.2 (by default it is only SSL3 and TLS (1.0))
    $AllProtocols = [System.Net.SecurityProtocolType]'Ssl3,Tls,Tls11,Tls12'
    [System.Net.ServicePointManager]::SecurityProtocol = $AllProtocols

}
function Set-TrueNasUntrustedSSL
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

function Show-TrueNasException()
{
    Param(
        [parameter(Mandatory = $true)]
        $Exception
    )

    #Check if certificate is valid
    if ($Exception.Exception.InnerException)
    {
        $exceptiontype = $Exception.Exception.InnerException.GetType()
        if ("AuthenticationException" -eq $exceptiontype.name)
        {
            Write-Warning "Invalid certificat (Untrusted, wrong date, invalid name...)"
            Write-Warning "Try to use Connect-TrueNasServer -SkipCertificateCheck for connection"
            throw "Unable to connect (certificate)"
        }
    }

    If ($Exception.Exception.Response)
    {
        if ("Desktop" -eq $PSVersionTable.PSEdition)
        {
            $result = $Exception.Exception.Response.GetResponseStream()
            $reader = New-Object -TypeName System.IO.StreamReader($result)
            $responseBody = $reader.ReadToEnd()
            $responseJson = $responseBody | ConvertFrom-Json
        }

        Write-Warning "The TrueNas  API sends an error message:"
        Write-Warning "Error description (code): $($Exception.Exception.Response.StatusDescription) ($($Exception.Exception.Response.StatusCode.Value__))"
        if ($responseBody)
        {
            if ($responseJson.message)
            {
                Write-Warning "Error details: $($responseJson.message)"
            }
            else
            {
                Write-Warning "Error details: $($responseBody)"
            }
        }
        elseif ($Exception.ErrorDetails.Message)
        {
            Write-Warning "Error details: $($Exception.ErrorDetails.Message)"
        }
    }
}
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
        Try
        {
            #New-banner -Text "TrueNas 2.0" -Online -ErrorAction stop
        }
        Catch
        {
            #New-banner -Text "TrueNas 2.0"
        }

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

<#
      .SYNOPSIS
      This function return Certificate created on your TrueNas Server
      .DESCRIPTION
      This function return Certificate created on your TrueNas Server
      .EXAMPLE
       PS C:\> Get-TrueNasCertificate

        Name              : TrueNas
        Id                : 1
        CSR               :
        DN                : /C=US/ST=US/L=New York/O=JM2K69/CN=TrueNas/emailAddress=Truenas@JM2K69.it
        Certificate       : -----BEGIN CERTIFICATE-----
                          MIIDhDCCAmygAwIBAgIEAMoKjzANBgkqhkiG9w0BAQsFADBzMQswCQYDVQQGEwJV
                          UzELMAkGA1UE..........
                          -----END CERTIFICATE-----
        Chain             : False
        City              : New York
        Common            : TrueNas
        Country           : US
        Disgest Algorithm : SHA256
        Email             : Truenas@JM2K69.loc
        From              : Thu Oct 24 05:37:47 2019
        Issuer            : CAInternal
        Key Lenght        : 2048
        Lifetime          : 3650
        Organization      : JM2K69
        PrivateKey        : -----BEGIN PRIVATE KEY-----
                            MIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQCzO8EZwwvleN32
                            XO/mrAYrxfhDpjY+..........
                            -----END PRIVATE KEY-----

        Serial            : 13240975
        State             : US
        Type              : 16
        Type CSR          : False
        Type CSR existing : False
        Type Internal     : True
        Valid until       : Sun Oct 21 05:37:47 2029
        .NOTES
      This command allow to find all certificate created on your TrueNas or TrueNas server

      .FUNCTIONALITY
      Use this command when you want to enable Https on your TrueNas or TrueNas server
      #>

function Get-TrueNasCertificate
{
    [CmdletBinding()]
    [Alias()]
    Param
    ()

    Begin
    {
        $uri = "api/v2.0/certificate/"
    }
    Process
    {
        Write-Verbose $uri
        $result = Invoke-TrueNasRestMethod -Uri $Uri -Method Get

        $Certificate = New-Object -TypeName System.Collections.ArrayList

        if ($null -eq $result.count)
        {

            $temp = New-Object -TypeName System.Object
            $temp | Add-Member -MemberType NoteProperty -Name "Name" -Value "$($result.name)"
            $temp | Add-Member -MemberType NoteProperty -Name "Id" -Value "$($result.id)"
            $temp | Add-Member -MemberType NoteProperty -Name "Type" -Value "$($result.type)"
            $temp | Add-Member -MemberType NoteProperty -Name "Certificate" -Value "$($result.certificate)"
            $temp | Add-Member -MemberType NoteProperty -Name "PrivateKey" -Value "$($result.privatekey)"
            $temp | Add-Member -MemberType NoteProperty -Name "CSR" -Value "$($result.CSR)"
            $temp | Add-Member -MemberType NoteProperty -Name "Signedby" -Value "$($result.signedby)"
            $temp | Add-Member -MemberType NoteProperty -Name "Root path" -Value "$($result.root_path)"
            $temp | Add-Member -MemberType NoteProperty -Name "Certificate path" -Value "$($result.certificate_path)"
            $temp | Add-Member -MemberType NoteProperty -Name "Private key path" -Value "$($result.private_key_path)"
            $temp | Add-Member -MemberType NoteProperty -Name "Csr path" -Value "$($result.csr_path)"
            $temp | Add-Member -MemberType NoteProperty -Name "Cert type" -Value "$($result.cert_type)"
            $temp | Add-Member -MemberType NoteProperty -Name "Issuer" -Value "$($result.issuer)"
            $temp | Add-Member -MemberType NoteProperty -Name "Chain list" -Value "$($result.chain_list)"
            $temp | Add-Member -MemberType NoteProperty -Name "Country" -Value "$($result.country)"
            $temp | Add-Member -MemberType NoteProperty -Name "State" -Value "$($result.state)"
            $temp | Add-Member -MemberType NoteProperty -Name "City" -Value "$($result.city)"
            $temp | Add-Member -MemberType NoteProperty -Name "Organization" -Value "$($result.organization)"
            $temp | Add-Member -MemberType NoteProperty -Name "Organizational unit" -Value "$($result.organization_unit)"
            $temp | Add-Member -MemberType NoteProperty -Name "Common" -Value "$($result.Common)"
            $temp | Add-Member -MemberType NoteProperty -Name "San" -Value "$($result.San)"
            $temp | Add-Member -MemberType NoteProperty -Name "Email" -Value "$($result.email)"
            $temp | Add-Member -MemberType NoteProperty -Name "DN" -Value "$($result.DN)"
            $temp | Add-Member -MemberType NoteProperty -Name "Digest_algorithm" -Value "$($result.digest_algorithm)"
            $temp | Add-Member -MemberType NoteProperty -Name "Lifetime" -Value "$($result.lifetime)"
            $temp | Add-Member -MemberType NoteProperty -Name "From" -Value "$($result.from)"
            $temp | Add-Member -MemberType NoteProperty -Name "Until" -Value "$($result.until)"
            $temp | Add-Member -MemberType NoteProperty -Name "Serial" -Value "$($result.serial)"
            $temp | Add-Member -MemberType NoteProperty -Name "Chain" -Value "$($result.chain)"
            $temp | Add-Member -MemberType NoteProperty -Name "Fingerprint" -Value "$($result.fingerprint)"
            $temp | Add-Member -MemberType NoteProperty -Name "Key lenght" -Value "$($result.key_length)"
            $temp | Add-Member -MemberType NoteProperty -Name "Key Type" -Value "$($result.key_type)"
            $temp | Add-Member -MemberType NoteProperty -Name "Parsed" -Value "$($result.parsed)"
            $temp | Add-Member -MemberType NoteProperty -Name "Internal" -Value "$($result.internal)"
            $temp | Add-Member -MemberType NoteProperty -Name "CA Type Existing" -Value "$($result.CA_type_existing)"
            $temp | Add-Member -MemberType NoteProperty -Name "CA type Internal" -Value "$($result.CA_type_internal)"
            $temp | Add-Member -MemberType NoteProperty -Name "CA type Intermediate" -Value "$($result.CA_type_intermediate)"
            $temp | Add-Member -MemberType NoteProperty -Name "Cert type existing" -Value "$($result.cert_type_existing)"
            $temp | Add-Member -MemberType NoteProperty -Name "Cert type Internal" -Value "$($result.cert_type_internal)"
            $temp | Add-Member -MemberType NoteProperty -Name "CA type CSR" -Value "$($result.cert_type_CSR)"
            $Certificate.Add($temp) | Out-Null
        }
        else
        {
            for ($i = 0; $i -lt $result.Count; $i++)
            {
                $temp = New-Object -TypeName System.Object
                $temp | Add-Member -MemberType NoteProperty -Name "Name" -Value "$($result[$i].name)"
                $temp | Add-Member -MemberType NoteProperty -Name "Id" -Value "$($result[$i].id)"
                $temp | Add-Member -MemberType NoteProperty -Name "Type" -Value "$($result[$i].type)"
                $temp | Add-Member -MemberType NoteProperty -Name "Certificate" -Value "$($result[$i].certificate)"
                $temp | Add-Member -MemberType NoteProperty -Name "PrivateKey" -Value "$($result[$i].privatekey)"
                $temp | Add-Member -MemberType NoteProperty -Name "CSR" -Value "$($result[$i].CSR)"
                $temp | Add-Member -MemberType NoteProperty -Name "Signedby" -Value "$($result[$i].signedby)"
                $temp | Add-Member -MemberType NoteProperty -Name "Root path" -Value "$($result[$i].root_path)"
                $temp | Add-Member -MemberType NoteProperty -Name "Certificate path" -Value "$($result[$i].certificate_path)"
                $temp | Add-Member -MemberType NoteProperty -Name "Private key path" -Value "$($result[$i].private_key_path)"
                $temp | Add-Member -MemberType NoteProperty -Name "Csr path" -Value "$($result[$i].csr_path)"
                $temp | Add-Member -MemberType NoteProperty -Name "Cert type" -Value "$($result[$i].cert_type)"
                $temp | Add-Member -MemberType NoteProperty -Name "Issuer" -Value "$($result[$i].issuer)"
                $temp | Add-Member -MemberType NoteProperty -Name "Chain list" -Value "$($result[$i].chain_list)"
                $temp | Add-Member -MemberType NoteProperty -Name "Country" -Value "$($result[$i].country)"
                $temp | Add-Member -MemberType NoteProperty -Name "State" -Value "$($result[$i].state)"
                $temp | Add-Member -MemberType NoteProperty -Name "City" -Value "$($result[$i].city)"
                $temp | Add-Member -MemberType NoteProperty -Name "Organization" -Value "$($result[$i].organization)"
                $temp | Add-Member -MemberType NoteProperty -Name "Organizational unit" -Value "$($result[$i].organization_unit)"
                $temp | Add-Member -MemberType NoteProperty -Name "Common" -Value "$($result[$i].Common)"
                $temp | Add-Member -MemberType NoteProperty -Name "San" -Value "$($result[$i].San)"
                $temp | Add-Member -MemberType NoteProperty -Name "Email" -Value "$($result[$i].email)"
                $temp | Add-Member -MemberType NoteProperty -Name "DN" -Value "$($result[$i].DN)"
                $temp | Add-Member -MemberType NoteProperty -Name "Digest_algorithm" -Value "$($result[$i].digest_algorithm)"
                $temp | Add-Member -MemberType NoteProperty -Name "Lifetime" -Value "$($result[$i].lifetime)"
                $temp | Add-Member -MemberType NoteProperty -Name "From" -Value "$($result[$i].from)"
                $temp | Add-Member -MemberType NoteProperty -Name "Until" -Value "$($result[$i].until)"
                $temp | Add-Member -MemberType NoteProperty -Name "Serial" -Value "$($result[$i].serial)"
                $temp | Add-Member -MemberType NoteProperty -Name "Chain" -Value "$($result[$i].chain)"
                $temp | Add-Member -MemberType NoteProperty -Name "Fingerprint" -Value "$($result[$i].fingerprint)"
                $temp | Add-Member -MemberType NoteProperty -Name "Key lenght" -Value "$($result[$i].key_length)"
                $temp | Add-Member -MemberType NoteProperty -Name "Key Type" -Value "$($result[$i].key_type)"
                $temp | Add-Member -MemberType NoteProperty -Name "Parsed" -Value "$($result[$i].parsed)"
                $temp | Add-Member -MemberType NoteProperty -Name "Internal" -Value "$($result[$i].internal)"
                $temp | Add-Member -MemberType NoteProperty -Name "CA Type Existing" -Value "$($result[$i].CA_type_existing)"
                $temp | Add-Member -MemberType NoteProperty -Name "CA type Internal" -Value "$($result[$i].CA_type_internal)"
                $temp | Add-Member -MemberType NoteProperty -Name "CA type Intermediate" -Value "$($result[$i].CA_type_intermediate)"
                $temp | Add-Member -MemberType NoteProperty -Name "Cert type existing" -Value "$($result[$i].cert_type_existing)"
                $temp | Add-Member -MemberType NoteProperty -Name "Cert type Internal" -Value "$($result[$i].cert_type_internal)"
                $temp | Add-Member -MemberType NoteProperty -Name "CA type CSR" -Value "$($result[$i].cert_type_CSR)"
                $Certificate.Add($temp) | Out-Null
            }
        }
    }
    End
    {
        return $Certificate

    }
}


<#
      .SYNOPSIS
      This function return all disk present  on your TrueNas Server
      .DESCRIPTION
      This function return all disk present  on your TrueNas Server
      .EXAMPLE
        PS C:\> Get-TrueNasDisk

        Name Size_GB
        ---- -------
        ada0      20
        da0       30
        da1       30
        da2       30
        da3       30
        da4       30
        da5       30
        da6       30
        .NOTES
      This command allow to find all disk available on your TrueNas or TrueNas server

      .FUNCTIONALITY
      Use this command when you want list your disk on your TrueNas or TrueNas server
      #>

function Get-TrueNasDisk
{
    [CmdletBinding()]
    Param( )
    begin
    {
        $uri = "api/v2.0/disk"

    }
    process
    {
        $results = Invoke-TrueNasRestMethod -Uri $Uri -Method Get

        foreach ($disk in $results)
        {
            $Name = ($disk.name)
            $Size_GB = ([Math]::Round($disk.size / 1024 / 1024 / 1024, 2))
            Write-Verbose -Message " Find the disk $name with the size $Size_GB"
            [PSCustomObject]@{
                Name    = ($disk.name)
                Number  = ($disk.number)
                Size_GB = ([Math]::Round($disk.size / 1024 / 1024 / 1024, 2))
                Type    = ($disk.type)
                Model   = ($disk.model)

            }
        }
    }
    end
    { }
}

function Get-TrueNasDiskUnsed
{
    [CmdletBinding()]
    Param( )

    begin
    {
        $uri = "api/v2.0/disk/get_unused"
    }
    process
    {
        $results = Invoke-TrueNasRestMethod -Uri $Uri -Method POST

        foreach ($disk in $results)
        {
            $Name = ($disk.name)
            $Size_GB = ([Math]::Round($disk.size / 1024 / 1024 / 1024, 2))
            Write-Verbose -Message " Find the disk $name with the size $Size_GB"
            [PSCustomObject]@{
                Name    = ($disk.name)
                Number  = ($disk.number)
                Size_GB = ([Math]::Round($disk.size / 1024 / 1024 / 1024, 2))
                Type    = ($disk.type)
                Model   = ($disk.model)
            }
        }
    }
    end { }
}
function Get-TrueNasGlobalConfig
{
    [CmdletBinding()]
    [Alias()]
    Param
    ()


    Begin
    {
        $uri = "api/v2.0/network/configuration"
    }
    Process
    {

        $result = Invoke-TrueNasRestMethod -Uri $Uri -Method Get

    }
    End
    {
        $Global = new-Object -TypeName PSObject

        $Global | add-member -name "Id" -membertype NoteProperty -Value "$($result.id)"
        $Global | add-member -name "Domain" -membertype NoteProperty -Value "$($result.domain)"
        $Global | add-member -name "Gateway Ipv4" -membertype NoteProperty -Value "$($result.ipv4gateway)"
        $Global | add-member -name "Gateway Ipv6" -membertype NoteProperty -Value "$($result.ipv6gateway)"
        $Global | add-member -name "Hostname" -membertype NoteProperty -Value "$($result.hostname_local)"
        $Global | add-member -name "Nameserver1" -membertype NoteProperty -Value "$($result.nameserver1)"
        $Global | add-member -name "Nameserver2" -membertype NoteProperty -Value "$($result.nameserver3)"
        $Global | add-member -name "Nameserver3" -membertype NoteProperty -Value "$($result.nameserver3)"
        $Global | add-member -name "Httpproxy" -membertype NoteProperty -Value "$($result.httpproxy)"
        $Global | add-member -name "Netwait Enabled" -membertype NoteProperty -Value "$($result.netwait_enabled)"
        $Global | add-member -name "Netwait IP" -membertype NoteProperty -Value "$($result.netwait_ip)"
        $Global | add-member -name "Hosts" -membertype NoteProperty -Value "$($result.hosts)"
        return $Global
    }
}

function Get-TrueNasInterface
{
    [CmdletBinding()]
    [Alias()]

    Param
    ()


    Begin
    {
        $uri = "api/v2.0/interface"
    }
    Process
    {

        $result = Invoke-TrueNasRestMethod -Uri $Uri -Method Get

    }
    End
    {
        for ($i = 0; $i -lt $result.Count; $i++)
        {
            foreach ($item in $result[$i])
            {
                [PSCustomObject]@{
                    id                   = ($result[$i].id)
                    Name                 = ($result[$i].name)
                    Fake                 = ($result[$i].fake)
                    Type                 = ($result[$i].type)
                    Aliases              = ($result[$i].aliases)
                    "Dhcp ipv4"          = ($result[$i].ipv4_dhcp)
                    "Dhcp ipv6"          = ($result[$i].ipv6_auto)
                    Description          = ($result[$i].description)
                    Options              = ($result[$i].options)
                    "Name parent"        = ($result[$i].state.name)
                    "Origin Name"        = ($result[$i].state.description)
                    "Description parent" = ($result[$i].state.description)
                    MTU                  = ($result[$i].state.mtu)
                    Cloned               = ($result[$i].state.cloned)
                    Flags                = ($result[$i].state.nd6_flags)
                    "Link state"         = ($result[$i].state.link_state)
                    "Media type"         = ($result[$i].state.media_type)
                    "Active media type"  = ($result[$i].state.active_media_type)
                    "Supported_media"    = ($result[$i].state.supported_media)
                    "Media options"      = ($result[$i].state.media_options)
                    "Mac Address"        = ($result[$i].state.link_address)

                }
            }
        }

    }
}

function Get-TrueNasInternalCA
{
    [CmdletBinding()]
    [Alias()]
    Param
    ()


    Begin
    { }
    Process
    {
        $Uri = "api/v2.0/certificateauthority"

        $result = Invoke-TrueNasRestMethod -Uri $Uri -Method Get
        return $result
    }
    End
    {
    }
}

function Get-TrueNasIscsiConf
{
    Param
    ( )

    Begin
    {

    }
    Process
    {
        $Uri = "api/v2.0/iscsi/global"

        $result = Invoke-TrueNasRestMethod -Uri $Uri -Method Get

    }
    End
    {
        $IscsiConf = New-Object -TypeName System.Collections.ArrayList

        $temp = New-Object -TypeName PSObject
        $temp | Add-Member -MemberType NoteProperty -Name "Id" -Value $result.id
        $temp | Add-Member -MemberType NoteProperty -Name "Base Name" -Value $result.basename
        $temp | Add-Member -MemberType NoteProperty -Name "ISNS Server" -Value $result.isns_servers
        $temp | Add-Member -MemberType NoteProperty -Name "Pool available space Threshold (%)" -Value $result.pool_avail_threshold
        $temp | Add-Member -MemberType NoteProperty -Name "Alua" -Value $result.alua


        $IscsiConf.Add($temp) | Out-Null

        return $IscsiConf | fl
    }
}

function Get-TrueNasIscsiExtent
{

    Param
    ()


    Begin
    {

    }
    Process
    {
        $Uri = "api/v2.0/iscsi/extent"
        $result = Invoke-TrueNasRestMethod -Uri $Uri -Method Get

        $Extent = New-Object -TypeName System.Collections.ArrayList
        $temp = New-Object -TypeName System.Object

        if ($null -eq $result.Count)
        {

            $temp | Add-Member -MemberType NoteProperty -Name "Id" -Value  "$($result.id)"
            $temp | Add-Member -MemberType NoteProperty -Name "Extent Type" -Value "$($result.type)"
            $temp | Add-Member -MemberType NoteProperty -Name "Extent Name" -Value  "$($result.name)"
            $temp | Add-Member -MemberType NoteProperty -Name "Extent path" -Value  "$($result.path)"
            $temp | Add-Member -MemberType NoteProperty -Name "Extent Block Size" -Value  "$($result.blocksize)"
            $temp | Add-Member -MemberType NoteProperty -Name "Extent Speed Type" -Value "$($result.rpm)"
            $temp | Add-Member -MemberType NoteProperty -Name "Extent Naa" -Value "$($result.naa)"
            $temp | Add-Member -MemberType NoteProperty -Name "Extent enabled" -Value "$($result.enabled)"
            $temp | Add-Member -MemberType NoteProperty -Name "Extent disk" -Value "$($result.disk)"
            $temp | Add-Member -MemberType NoteProperty -Name "Extent Xen" -Value "$($result.xen)"

            $Extent.Add($temp) | Out-Null

        }
        else
        {
            for ($i = 0; $i -lt $result.Count; $i++)
            {
                $temp = New-Object -TypeName System.Object
                $temp | Add-Member -MemberType NoteProperty -Name "Id" -Value  "$($result[$i].id)"
                $temp | Add-Member -MemberType NoteProperty -Name "Extent Type" -Value "$($result[$i].type)"
                $temp | Add-Member -MemberType NoteProperty -Name "Extent Name" -Value  "$($result[$i].name)"
                $temp | Add-Member -MemberType NoteProperty -Name "Extent path" -Value  "$($result[$i].path)"
                $temp | Add-Member -MemberType NoteProperty -Name "Extent Block Size" -Value  "$($result[$i].blocksize)"
                $temp | Add-Member -MemberType NoteProperty -Name "Extent Speed Type" -Value "$($result[$i].rpm)"
                $temp | Add-Member -MemberType NoteProperty -Name "Extent Naa" -Value "$($result[$i].naa)"
                $temp | Add-Member -MemberType NoteProperty -Name "Extent enabled" -Value "$($result[$i].enabled)"
                $temp | Add-Member -MemberType NoteProperty -Name "Extent disk" -Value "$($result[$i].disk)"
                $temp | Add-Member -MemberType NoteProperty -Name "Extent Xen" -Value "$($result[$i].xen)"
                $Extent.Add($temp) | Out-Null
            }

        }

        return $Extent


    }
    End
    { }
}

function Get-TrueNasIscsiInitiator
{
    Param
    ( )


    Begin
    {

    }
    Process
    {
        $Uri = "api/v2.0/iscsi/initiator"
        $result = Invoke-TrueNasRestMethod -Uri $Uri -Method Get

        $initiator = New-Object -TypeName System.Collections.ArrayList
        $temp = New-Object -TypeName System.Object

        if ($null -eq $result.Count)
        {
            $temp | Add-Member -MemberType NoteProperty -Name "Id" -Value $result.id
            $temp | Add-Member -MemberType NoteProperty -Name "Tag" -Value $result.tag
            $temp | Add-Member -MemberType NoteProperty -Name "Initiator" -Value $result.initiators
            $temp | Add-Member -MemberType NoteProperty -Name "Auth Network" -Value $result.auth_network
            $temp | Add-Member -MemberType NoteProperty -Name "Comments" -Value $result.comment
            $initiator.Add($temp) | Out-Null

        }
        else
        {
            for ($i = 0; $i -lt $result.Count; $i++)
            {
                $temp = New-Object -TypeName System.Object
                $temp | Add-Member -MemberType NoteProperty -Name "Id" -Value "$($result[$i].id)"
                $temp | Add-Member -MemberType NoteProperty -Name "Tag" -Value "$($result[$i].tag)"
                $temp | Add-Member -MemberType NoteProperty -Name "Initiator" -Value "$($result[$i].initiators)"
                $temp | Add-Member -MemberType NoteProperty -Name "Auth Network" -Value "$($result[$i].auth_network)"
                $temp | Add-Member -MemberType NoteProperty -Name "Comments" -Value "$($result[$i].comment)"
                $initiator.Add($temp) | Out-Null
            }

        }

        return $initiator


    }
    End
    { }
}

function Get-TrueNasIscsiPortal
{
    Param
    ( )


    Begin
    {

    }
    Process
    {
        $Uri = "api/v2.0/iscsi/portal"

        $result = Invoke-TrueNasRestMethod -Uri $Uri -Method Get

        $Obj = New-Object -TypeName System.Collections.ArrayList
        $temp = New-Object -TypeName System.Object

        if ($null -eq $result.Count)
        {
            $temp | Add-Member -MemberType NoteProperty -Name "Id" -Value $result.id
            $temp | Add-Member -MemberType NoteProperty -Name "Tag" -Value $result.tag
            $temp | Add-Member -MemberType NoteProperty -Name "Listen" -Value $result.listen.ip
            $temp | Add-Member -MemberType NoteProperty -Name "Port" -Value $result.listen.port
            $temp | Add-Member -MemberType NoteProperty -Name "Discovery authmethod" -Value $result.discovery_authmethod
            $temp | Add-Member -MemberType NoteProperty -Name "Discovery authgroup" -Value $result.discovery_authgroup
            $Obj.Add($temp) | Out-Null

        }
        else
        {
            for ($i = 0; $i -lt $result.Count; $i++)
            {
                $temp = New-Object -TypeName System.Object
                $temp | Add-Member -MemberType NoteProperty -Name "Id" -Value "$($result[$i].id)"
                $temp | Add-Member -MemberType NoteProperty -Name "Tag" -Value "$($result[$i].tag)"
                $temp | Add-Member -MemberType NoteProperty -Name "Listen" -Value "$($result[$i].listen.ip)"
                $temp | Add-Member -MemberType NoteProperty -Name "Port" -Value "$($result[$i].listen.port)"
                $temp | Add-Member -MemberType NoteProperty -Name "Discovery authmethod" -Value "$($result[$i].discovery_authmethod)"
                $temp | Add-Member -MemberType NoteProperty -Name "Discovery authgroup" -Value "$($result[$i].discovery_authgroup)"
                $Obj.Add($temp) | Out-Null
            }

        }
        return $Obj
    }
    End
    { }
}

function Get-TrueNasIscsiTarget
{
    Param
    ( )


    Begin
    {

    }
    Process
    {
        $Uri = "api/v2.0/iscsi/target"

        $result = Invoke-TrueNasRestMethod -Uri $Uri -Method Get
        $TruenasIscsiTarget = New-Object -TypeName System.Collections.ArrayList

        if ($null -eq $result.Count)
        {

            $temp = New-Object -TypeName System.Object
            $temp | Add-Member -MemberType NoteProperty -Name "Id" -Value "$($result.id)"
            $temp | Add-Member -MemberType NoteProperty -Name "Target alias" -Value "$($result.alias)"
            $temp | Add-Member -MemberType NoteProperty -Name "Target name" -Value "$($result.name)"
            $temp | Add-Member -MemberType NoteProperty -Name "Target mode" -Value "$($result.mode)"
            $temp | Add-Member -MemberType NoteProperty -Name "Groups portal" -Value "$($result.groups.portal)"
            $temp | Add-Member -MemberType NoteProperty -Name "Groups initiator" -Value "$($result.groups.initiator)"
            $temp | Add-Member -MemberType NoteProperty -Name "Groups authentification" -Value "$($result.groups.auth)"
            $temp | Add-Member -MemberType NoteProperty -Name "Groups authen-method" -Value "$($result.groups.authmethod)"
            $TruenasIscsiTarget.Add($temp) | Out-Null
        }
        else
        {
            for ($i = 0; $i -lt $result.Count; $i++)
            {
                $temp = New-Object -TypeName System.Object
                $temp | Add-Member -MemberType NoteProperty -Name "Id" -Value "$($result[$i].id)"
                $temp | Add-Member -MemberType NoteProperty -Name "Target alias" -Value "$($result[$i].alias)"
                $temp | Add-Member -MemberType NoteProperty -Name "Target name" -Value "$($result[$i].name)"
                $temp | Add-Member -MemberType NoteProperty -Name "Target mode" -Value "$($result[$i].mode)"
                $temp | Add-Member -MemberType NoteProperty -Name "Groups portal" -Value "$($result[$i].groups.portal)"
                $temp | Add-Member -MemberType NoteProperty -Name "Groups initiator" -Value "$($result[$i].groups.initiator)"
                $temp | Add-Member -MemberType NoteProperty -Name "Groups authentification" -Value "$($result[$i].groups.auth)"
                $temp | Add-Member -MemberType NoteProperty -Name "Groups authen-method" -Value "$($result[$i].groups.authmethod)"

                $TruenasIscsiTarget.Add($temp) | Out-Null
            }
        }

        return $TruenasIscsiTarget
    }
    End
    { }
}

function Get-TrueNasIscsiAssociat2Extent
{
    [CmdletBinding()]
    [Alias()]
    [OutputType([int])]
    Param
    (
        [ValidateSet("Id", "Name")]
        [string]$Output = "Id"

    )


    Begin
    {

    }
    Process
    {
        $Uri = "api/v2.0/iscsi/targetextent"

        $result = Invoke-TrueNasRestMethod -Uri $Uri -Method Get

        switch ($Output)
        {
            'Id'
            {
                $TruenasIscsiAssociat2Extent = New-Object -TypeName System.Collections.ArrayList
                if ($null -eq $result.count)
                {
                    $temp = New-Object -TypeName System.Object
                    $temp | Add-Member -MemberType NoteProperty -Name "Id" -Value "$($result.id)"
                    $temp | Add-Member -MemberType NoteProperty -Name "Iscsi Extent Id" -Value "$($result.extent)"
                    $temp | Add-Member -MemberType NoteProperty -Name "Iscsi Lun Id" -Value "$($result.lunid)"
                    $temp | Add-Member -MemberType NoteProperty -Name "Iscsi Target Id" -Value "$($result.target)"
                    $TruenasIscsiAssociat2Extent.Add($temp) | Out-Null
                }

                for ($i = 0; $i -lt $result.Count; $i++)
                {
                    $temp = New-Object -TypeName System.Object
                    $temp | Add-Member -MemberType NoteProperty -Name "Id" -Value "$($result[$i].id)"
                    $temp | Add-Member -MemberType NoteProperty -Name "Iscsi Extent Id" -Value "$($result[$i].extent)"
                    $temp | Add-Member -MemberType NoteProperty -Name "Iscsi Lun Id" -Value "$($result[$i].lunid)"
                    $temp | Add-Member -MemberType NoteProperty -Name "Iscsi Target Id" -Value "$($result[$i].target)"

                    $TruenasIscsiAssociat2Extent.Add($temp) | Out-Null
                }
            }
            'Name'
            {
                $TruenasIscsiAssociat2Extent = New-Object -TypeName System.Collections.ArrayList

                if ($null -eq $result.Count)
                {
                    $value = $result.extent
                    $value2 = $result.target
                    $TargetName = Get-TruenasIscsiTarget
                    $IscsiExtend = Get-TruenasIscsiExtent

                    foreach ($item in $TargetName)
                    {
                        if ( $Item.Id -eq $value2 )
                        {
                            $TargetNameF = $item.'Target name'
                        }

                    }

                    foreach ($item in $IscsiExtend)
                    {
                        if ( $Item.Id -eq $value )
                        {
                            $IscsiExtendF = $item.'Extent Name'
                        }
                    }
                    $temp = New-Object -TypeName System.Object
                    $temp | Add-Member -MemberType NoteProperty -Name "Id" -Value "$($result.Id)"
                    $temp | Add-Member -MemberType NoteProperty -Name "Iscsi_Extent_Name" -Value $IscsiExtendF
                    $temp | Add-Member -MemberType NoteProperty -Name "LUN Id" -Value "$($result.lunid)"
                    $temp | Add-Member -MemberType NoteProperty -Name "Target_Name" -Value $TargetNameF

                    $TruenasIscsiAssociat2Extent.Add($temp) | Out-Null


                }


                for ($i = 0; $i -lt $result.Count; $i++)
                {
                    $value = $result[$i].extent
                    $value2 = $result[$i].target
                    $TargetName = Get-TruenasIscsiTarget
                    $IscsiExtend = Get-TruenasIscsiExtent


                    foreach ($item in $TargetName)
                    {
                        if ( $Item.Id -eq $value2 )
                        {
                            $TargetNameF = $item.'Target name'
                        }

                    }

                    foreach ($item in $IscsiExtend)
                    {
                        if ( $Item.Id -eq $value )
                        {
                            $IscsiExtendF = $item.'Extent Name'
                        }
                    }


                    $temp = New-Object -TypeName System.Object
                    $temp | Add-Member -MemberType NoteProperty -Name "Id" -Value "$($result[$i].Id)"
                    $temp | Add-Member -MemberType NoteProperty -Name "Iscsi_Extent_Name" -Value $IscsiExtendF
                    $temp | Add-Member -MemberType NoteProperty -Name "LUN Id" -Value "$($result[$i].lunid)"
                    $temp | Add-Member -MemberType NoteProperty -Name "Target_Name" -Value $TargetNameF

                    $TruenasIscsiAssociat2Extent.Add($temp) | Out-Null
                }

            }

        }

        return $TruenasIscsiAssociat2Extent
    }
    End
    { }
}

function Get-TrueNasServices
{
    Param
    ( )

    Begin
    {

    }
    Process
    {
        $Uri = "api/v2.0/service"

        $result = Invoke-TrueNasRestMethod -Uri $Uri -Method Get

    }
    End
    {
        $result
    }
}

function Get-TrueNasSetting
{
    [CmdletBinding()]
    [Alias()]
    Param
    ()


    Begin
    { }
    Process
    {
        $Uri = "api/v2.0/system/general"

        $result = Invoke-TrueNasRestMethod -Uri $Uri -Method Get
    }
    End
    {
        $Global = new-Object -TypeName PSObject

        $Global | add-member -name "Id" -membertype NoteProperty -Value "$($result.id)"
        $Global | add-member -name "Language" -membertype NoteProperty -Value "$($result.language)"
        $Global | add-member -name "Keyboard map" -membertype NoteProperty -Value "$($result.kbdmap)"
        $Global | add-member -name "Time zone" -membertype NoteProperty -Value "$($result.timezone)"
        $Global | add-member -name "SysLog Level" -membertype NoteProperty -Value "$($result.sysloglevel)"
        $Global | add-member -name "Syslog server" -membertype NoteProperty -Value "$($result.syslogserver)"
        $Global | add-member -name "Crash reporting" -membertype NoteProperty -Value "$($result.crash_reporting )"
        $Global | add-member -name "WizardShonw" -membertype NoteProperty -Value "$($result.wizardshown)"
        $Global | add-member -name "Usage collection" -membertype NoteProperty -Value "$($result.usage_collection)"
        $Global | add-member -name "Ui certificate" -membertype NoteProperty -Value "$($result.ui_certificate)"
        $Global | add-member -name "Ui address" -membertype NoteProperty -Value "$($result.ui_address)"
        $Global | add-member -name "Ui v6address" -membertype NoteProperty -Value "$($result.ui_v6address)"
        $Global | add-member -name "Ui port" -membertype NoteProperty -Value "$($result.ui_port)"
        $Global | add-member -name "Ui https port" -membertype NoteProperty -Value "$($result.ui_httpsport)"
        $Global | add-member -name "Ui https redirect" -membertype NoteProperty -Value "$($result.ui_httpsredirect)"
        $Global | add-member -name "Crash reporting is set" -membertype NoteProperty -Value "$($result.crash_reporting_is_set)"
        $Global | add-member -name "usage collection is set" -membertype NoteProperty -Value "$($result.usage_collection_is_set)"

        return $Global
    }
}

function Get-TrueNasSystemAdvanced
{
    Param( )

    $Uri = "api/v2.0/system/advanced"

    $results = Invoke-TrueNasRestMethod -Uri $Uri -Method Get

    foreach ($Info in $results)
    {
        [PSCustomObject]@{
            Id               = ($Info.id)
            'Legacy UI'      = ($Info.legacy_ui)
            Consolemenu      = ($Info.consolemenu)
            'Serial console' = ($Info.serialconsole)
            'Serial port'    = ($Info.serialport)
            'Serial speed'   = ($Info.serialspeed)
            'Power daemon'   = ($Info.powerdaemon)
            'Swap on drive'  = ($Info.swapondrive)
            'Console msg'    = ($Info.consolemsg)
            'Trace back'     = ($Info.traceback)
            'Advanced mode'  = ($Info.advancedmode)
            'Autotune'       = ($Info.autotune)
            'Debug kernel'   = ($Info.debugkernel)
            'Upload crash'   = ($Info.uploadcrash)
            'MOTD'           = ($Info.motd)
            'Anonstats'      = ($Info.anonstats)
            'Boot scrub'     = ($Info.boot_scrub)
            'FQDN syslog'    = ($Info.fqdn_syslog)
            'Sed user'       = ($Info.sed_user)
            'Sed password'   = ($Info.sed_passwd)

        }
    }
}

function Get-TrueNasSystemAlert
{
    Param( )

    $Uri = "api/v2.0/alertservice"

    $results = Invoke-TrueNasRestMethod -Uri $Uri -Method Get

    foreach ($Alert in $results)
    {
        [PSCustomObject]@{
            Id           = ($Alert.id)
            Name         = ($Alert.name)
            Type         = ($Alert.type)
            Attributes   = ($Alert.attributes)
            Level        = ($Alert.level)
            Enabled      = ($Alert.enabled)
            'Type title' = ($Alert.type__title)
        }
    }
}

function Get-TrueNasSystemNTP
{
    [Alias()]
    Param
    ()

    Begin
    {

    }
    Process
    {
        $Uri = "api/v2.0/system/ntpserver"

        $results = Invoke-TrueNasRestMethod -Uri $Uri -Method Get

        foreach ($NTP in $results)
        {
            [PSCustomObject]@{
                Id      = ($NTP.id)
                Address = ($NTP.address)
                Burst   = ($NTP.burst)
                iburst  = ($NTP.iburst)
                prefer  = ($NTP.prefer)
                Minpoll = ($NTP.minpoll)
                Maxpoll = ($NTP.maxpoll)
            }
        }

    }
    End { }
}

function Get-TrueNasSystemUpdate
{
    Param( )

    $Uri = "api/v2.0/update/get_trains"

    $results = Invoke-TrueNasRestMethod -Uri $Uri -Method Get
    return $results.trains
}
function Get-TrueNasSystemVersion
{
    Param( )

    $Uri = "api/v2.0/system/info"

    $results = Invoke-TrueNasRestMethod -Uri $Uri -Method Get


    [PSCustomObject]@{
        Version               = ($results.version)
        'Build time'          = ($results.buildtime)
        'Physical Memory'     = ($results.physmem)
        Model                 = ($results.model)
        Cores                 = ($results.cores)
        'Load Average'        = ($results.loadavg)
        Uptime                = ($results.uptime)
        'Uptime seconds'      = ($results.uptime_seconds)
        'System serial'       = ($results.system_serial)
        'System product'      = ($results.system_product)
        license               = ($results.license)
        'boot time'           = ($results.boottime)
        'Date time'           = ($results.datetime)
        Timezone              = ($results.timezone)
        'System manufacturer' = ($results.system_manufacturer)

    }

}

function Get-TrueNasVolume
{
    [CmdletBinding()]
    Param
    (
        [Parameter (Mandatory = $true)]
        [ValidateSet("VOLUME", "FILESYSTEM")]
        $Type

    )

    Begin
    {

    }
    Process
    {
        $Uri = "api/v2.0/pool/dataset"
        $result = Invoke-TrueNasRestMethod -Uri $Uri -Method Get

        switch ($Type)
        {
            'VOLUME' { $result = $result | Where-Object { $_.type -eq "VOLUME" } }
            'FILESYSTEM' { $result = $result | Where-Object { $_.type -eq "FILESYSTEM" } }
            Default { }
        }
    }
    End
    {
        $TruenasVolume = New-Object -TypeName System.Collections.ArrayList

        if ($null -eq $result.count)
        {
            $temp = New-Object -TypeName System.Object
            $temp | Add-Member -MemberType NoteProperty -Name "Name" -Value "$($result.name)"
            $temp | Add-Member -MemberType NoteProperty -Name "Id" -Value "$($result.id)"
            $temp | Add-Member -MemberType NoteProperty -Name "Children" -Value "$($result.children)"
            $temp | Add-Member -MemberType NoteProperty -Name "Type" -Value "$($result.type)"
            $temp | Add-Member -MemberType NoteProperty -Name "Deduplication" -Value "$($result.deduplication.value)"
            $temp | Add-Member -MemberType NoteProperty -Name "Sync" -Value "$($result.sync.value)"
            $temp | Add-Member -MemberType NoteProperty -Name "Compression" -Value "$($result.compression.value)"
            $temp | Add-Member -MemberType NoteProperty -Name "Compression ratio" -Value "$($result.compressratio.value)"
            $temp | Add-Member -MemberType NoteProperty -Name "Ref reservation" -Value "$($result.refreservation.value)"
            $temp | Add-Member -MemberType NoteProperty -Name "Readonly" -Value "$($result.readonly.value)"
            $temp | Add-Member -MemberType NoteProperty -Name "Volume size" -Value "$($result.volsize.value)"
            $temp | Add-Member -MemberType NoteProperty -Name "Volume block size" -Value "$($result.volblocksize.value)"
            $TruenasVolume.Add($temp) | Out-Null

        }
        else
        {
            for ($i = 0; $i -lt $result.Count; $i++)
            {
                $temp = New-Object -TypeName System.Object
                $temp | Add-Member -MemberType NoteProperty -Name "Name" -Value "$($result[$i].name)"
                $temp | Add-Member -MemberType NoteProperty -Name "Id" -Value "$($result[$i].id)"
                $temp | Add-Member -MemberType NoteProperty -Name "Children" -Value "$($result[$i].children)"
                $temp | Add-Member -MemberType NoteProperty -Name "Type" -Value "$($result[$i].type)"
                $temp | Add-Member -MemberType NoteProperty -Name "Deduplication" -Value "$($result[$i].deduplication.value)"
                $temp | Add-Member -MemberType NoteProperty -Name "Sync" -Value "$($result[$i].sync.value)"
                $temp | Add-Member -MemberType NoteProperty -Name "Compression" -Value "$($result[$i].compression.value)"
                $temp | Add-Member -MemberType NoteProperty -Name "Compression ratio" -Value "$($result[$i].compressratio.value)"
                $temp | Add-Member -MemberType NoteProperty -Name "Ref reservation" -Value "$($result[$i].refreservation.value)"
                $temp | Add-Member -MemberType NoteProperty -Name "Readonly" -Value "$($result[$i].readonly.value)"
                $temp | Add-Member -MemberType NoteProperty -Name "Volume size" -Value "$($result[$i].volsize.value)"
                $temp | Add-Member -MemberType NoteProperty -Name "Volume block size" -Value "$($result[$i].volblocksize.value)"
                $TruenasVolume.Add($temp) | Out-Null
            }

        }


        return $TruenasVolume



    }
}

function Get-TrueNasPool
{
    Param

    ( )

    Begin
    {

    }
    Process
    {
        $Uri = "api/v2.0/pool"
        $result = Invoke-TrueNasRestMethod -Uri $Uri -Method Get

    }
    End
    {
        $TruenasVolume = New-Object -TypeName System.Collections.ArrayList

        if ($null -eq $result.count)
        {
            $temp = New-Object -TypeName System.Object
            $temp | Add-Member -MemberType NoteProperty -Name "Name" -Value "$($result.name)"
            $temp | Add-Member -MemberType NoteProperty -Name "Id" -Value "$($result.id)"
            $temp | Add-Member -MemberType NoteProperty -Name "Guid" -Value "$($result.guid)"
            $temp | Add-Member -MemberType NoteProperty -Name "Encrypt" -Value "$($result.encrypt)"
            $temp | Add-Member -MemberType NoteProperty -Name "Encrypt key" -Value "$($result.encryptkey)"
            $temp | Add-Member -MemberType NoteProperty -Name "Path" -Value "$($result.path)"
            $temp | Add-Member -MemberType NoteProperty -Name "Status" -Value "$($result.status)"
            $temp | Add-Member -MemberType NoteProperty -Name "Healthy" -Value "$($result.healthy)"
            $temp | Add-Member -MemberType NoteProperty -Name "Is decrypted" -Value "$($result.is_decrypted)"
            #$result.topology.data.children Topology
            $TruenasVolume.Add($temp) | Out-Null

        }
        else
        {
            for ($i = 0; $i -lt $result.Count; $i++)
            {
                $temp = New-Object -TypeName System.Object
                $temp | Add-Member -MemberType NoteProperty -Name "Name" -Value "$($result[$i].name)"
                $temp | Add-Member -MemberType NoteProperty -Name "Id" -Value "$($result[$i].id)"
                $temp | Add-Member -MemberType NoteProperty -Name "Guid" -Value "$($result[$i].guid)"
                $temp | Add-Member -MemberType NoteProperty -Name "Encrypt" -Value "$($result[$i].encrypt)"
                $temp | Add-Member -MemberType NoteProperty -Name "Encrypt key" -Value "$($result[$i].encryptkey)"
                $temp | Add-Member -MemberType NoteProperty -Name "Path" -Value "$($result[$i].path)"
                $temp | Add-Member -MemberType NoteProperty -Name "Status" -Value "$($result[$i].status)"
                $temp | Add-Member -MemberType NoteProperty -Name "Healthy" -Value "$($result[$i].healthy)"
                $temp | Add-Member -MemberType NoteProperty -Name "Is decrypted" -Value "$($result[$i].is_decrypted)"
                $TruenasVolume.Add($temp) | Out-Null
            }

        }


        return $TruenasVolume



    }
}

function New-TrueNasZvol
{

    [CmdletBinding()]
    [Alias()]
    [OutputType([int])]
    Param
    (

        [Parameter (Mandatory = $true)]
        [string]$Name,

        [Parameter (Mandatory = $true)]
        [string]$ZvolName,

        [Parameter (Mandatory = $true)]
        [Int]$Volsize,

        [Parameter (Mandatory = $true)]
        [ValidateSet("VOLUME", "FILESYSTEM")]
        [String]$Type = "VOLUME",

        [Parameter (Mandatory = $true)]
        [ValidateSet( "MiB", "GiB", "TiB")]
        [String]$Unit = "GiB",


        [Parameter (Mandatory = $False)]
        [ValidateSet("OFF", "LZ4", "GZIP", "GZIP-1", "GZIP-9", "ZLE", "LZJB")]
        [String]$Compression = "lz4",

        [Parameter (Mandatory = $False)]
        [bool]$Sparse,

        [Parameter (Mandatory = $False)]
        [bool]$Forcesize,

        [Parameter (Mandatory = $False)]
        [ValidateSet("4K", "8K", "16K" , "32K", "64K", "128K")]
        [String]$BlokSize = "4K",

        [Parameter (Mandatory = $False)]
        [String]$Comment
    )


    Begin
    {

    }

    Process
    {

        $Uri = "api/v2.0/pool/dataset"


        $Zvolc = new-Object -TypeName PSObject


        if ( $PsBoundParameters.ContainsKey('ZvolName') )
        {
            $Zvolc | add-member -name "name" -membertype NoteProperty -Value $ZvolName/$Name
        }
        if ( $PsBoundParameters.ContainsKey('Type') )
        {
            $Zvolc | add-member -name "type" -membertype NoteProperty -Value $Type
        }

        if ( $PsBoundParameters.ContainsKey('Volsize') -and $PsBoundParameters.ContainsKey('Unit') )
        {
            switch ($Unit)
            {
                'MiB' { $size = ($Volsize * 1024 * 1024) }
                'GiB' { $size = ($Volsize * 1024 * 1024 * 1024) }
                'TiB' { $size = ($Volsize * 1024 * 1024 * 1024 * 1024) }
                Default { }
            }
            $Zvolc | add-member -name "volsize" -membertype NoteProperty -Value $Size
        }
        if ( $PsBoundParameters.ContainsKey('Sparse') )
        {
            $Zvolc | add-member -name "sparse" -membertype NoteProperty -Value $Sparse
        }
        if ( $PsBoundParameters.ContainsKey('Forcesize') )
        {
            $Zvolc | add-member -name "force_size" -membertype NoteProperty -Value $Forcesize
        }
        if ( $PsBoundParameters.ContainsKey('Compression') )
        {
            $Zvolc | add-member -name "compression" -membertype NoteProperty -Value $Compression
        }
        if ( $PsBoundParameters.ContainsKey('Comment') )
        {
            $Zvolc | add-member -name "comments" -membertype NoteProperty -Value $Comment
        }
        if ( $PsBoundParameters.ContainsKey('BlokSize') )
        {
            $Zvolc | add-member -name "blocksize" -membertype NoteProperty -Value $BlokSize
        }

        $response = Invoke-TrueNasRestMethod -method Post -body $Zvolc -Uri $Uri

    }

    End
    {
    }
}

function New-TrueNasPool
{

    [CmdletBinding()]
    [Alias()]
    [OutputType([int])]
    Param
    (

        [Parameter (Mandatory = $true)]
        [string]$PoolName,
        [Parameter (Mandatory = $true)]
        [Bool]$Encryption,
        [Parameter (Mandatory = $true)]
        [ValidateSet("ON", "VERIFY", "OFF")]
        $Deduplication,
        [Parameter (Mandatory = $true)]
        [ValidateSet("Data", "DataCache", "DataCacheLog", "DataCacheLogSpare", "DataCacheSpare", "DataLogSpare")]
        [String]$PoolDesign,
        [Parameter (Mandatory = $true)]
        [ValidateSet("STRIPE", "MIRROR", "RAIDZ1", "RAIDZ2", "RAIDZ3")]
        [String]$DataVdevType,
        [Parameter (Mandatory = $False)]
        [ValidateSet("STRIPE", "MIRROR", "RAIDZ1", "RAIDZ2", "RAIDZ3")]
        [String]$CacheVdevType,
        [Parameter (Mandatory = $False)]
        [ValidateSet("STRIPE", "MIRROR", "RAIDZ1", "RAIDZ2", "RAIDZ3")]
        [String]$LogVdevType,
        [Parameter (Mandatory = $false)]
        [ValidateSet("yes")]
        $force,
        [Parameter (Mandatory = $false)]
        [String]$DiskNamebase = "da",
        [Parameter (Mandatory = $true)]
        [Int]$NbDataDisks,
        [Parameter (Mandatory = $false)]
        [Int]$NbCacheDisks,
        [Parameter (Mandatory = $false)]
        [Int]$NbLogDisks,
        [Parameter (Mandatory = $false)]
        [Int]$NbSpareDisks,
        [Parameter (Mandatory = $false)]
        [Int]$StartDataDisksNB = 1,
        [Parameter (Mandatory = $false)]
        [Int]$StartCacheDisksNB = 1,
        [Parameter (Mandatory = $false)]
        [Int]$StartLogDisksNB = 1,
        [Parameter (Mandatory = $false)]
        [Int]$StartSpareDisksNB = 1
    )
    Begin
    {
        $Uri = "api/v2.0/pool"
    }
    Process
    {
        $TruenasDataVolume = @()
        $StartDataDisksNB..$($StartDataDisksNB + $NbDataDisks - 1) | Foreach-Object { $TruenasDataVolume += "$DiskNamebase$_" }

        switch ($PoolDesign)
        {
            'Data'
            {
                $Obj = [Ordered]@{
                    name          = $PoolName
                    encryption    = $Encryption
                    deduplication = $Deduplication
                    topology      = [Ordered]@{
                        data = @(@{
                                type  = $DataVdevType
                                disks = $TruenasDataVolume
                            })
                    }
                }

            }
            'DataCache'
            {
                $TruenasCacheVolume = @()
                $StartCacheDisksNB..$($StartCacheDisksNB + $NbCacheDisks - 1) | Foreach-Object { $TruenasCacheVolume += "$DiskNamebase$_" }


                $Obj = [Ordered]@{
                    name          = $PoolName
                    encryption    = $Encryption
                    deduplication = $Deduplication
                    topology      = [Ordered]@{
                        data  = @(@{
                                type  = $DataVdevType
                                disks = $TruenasDataVolume
                            })
                        cache = @(@{
                                type  = $CacheVdevType
                                disks = @( $TruenasCacheVolume)
                            })
                    }
                }

            }
            'DataCacheLog'
            {
                $TruenasCacheVolume = @()
                $StartCacheDisksNB..$($StartCacheDisksNB + $NbCacheDisks - 1) | Foreach-Object { $TruenasCacheVolume += "$DiskNamebase$_" }

                $TruenasLogVolume = @()
                $StartLogDisksNB..$($StartLogDisksNB + $NbLogDisks - 1) | Foreach-Object { $TruenasLogVolume += "$DiskNamebase$_" }

                $Obj = [Ordered]@{
                    name          = $PoolName
                    encryption    = $Encryption
                    deduplication = $Deduplication
                    topology      = [Ordered]@{
                        data  = @(@{
                                type  = $DataVdevType
                                disks = $TruenasDataVolume
                            })
                        cache = @(@{
                                type  = $CacheVdevType
                                disks = @( $TruenasCacheVolume)
                            })
                        log   = @(@{
                                type  = $LogVdevType
                                disks = @( $TruenasLogVolume)
                            })
                    }
                }

            }
            'DataCacheLogSpare'
            {
                $TruenasCacheVolume = @()
                $StartCacheDisksNB..$($StartCacheDisksNB + $NbCacheDisks - 1) | Foreach-Object { $TruenasCacheVolume += "$DiskNamebase$_" }

                $TruenasLogVolume = @()
                $StartLogDisksNB..$($StartLogDisksNB + $NbLogDisks - 1) | Foreach-Object { $TruenasLogVolume += "$DiskNamebase$_" }

                $TruenasSpareVolume = @()
                $StartSpareDisksNB..$($StartSpareDisksNB + $NbSpareDisks - 1) | Foreach-Object { $TruenasSpareVolume += "$DiskNamebase$_" }

                $Obj = [Ordered]@{
                    name          = $PoolName
                    encryption    = $Encryption
                    deduplication = $Deduplication
                    topology      = [Ordered]@{
                        data   = @(@{
                                type  = $DataVdevType
                                disks = $TruenasDataVolume
                            })
                        cache  = @(@{
                                type  = $CacheVdevType
                                disks = @( $TruenasCacheVolume)
                            })
                        log    = @(@{
                                type  = $LogVdevType
                                disks = @( $TruenasLogVolume)
                            })
                        spares = @($TruenasSpareVolume)
                    }
                }

            }
            'DataCacheSpare'
            {

                $TruenasCacheVolume = @()
                $StartCacheDisksNB..$($StartCacheDisksNB + $NbCacheDisks - 1) | Foreach-Object { $TruenasCacheVolume += "$DiskNamebase$_" }

                $TruenasSpareVolume = @()
                $StartSpareDisksNB..$($StartSpareDisksNB + $NbSpareDisks - 1) | Foreach-Object { $TruenasSpareVolume += "$DiskNamebase$_" }

                $Obj = [Ordered]@{
                    name          = $PoolName
                    encryption    = $Encryption
                    deduplication = $Deduplication
                    topology      = [Ordered]@{
                        data   = @(@{
                                type  = $DataVdevType
                                disks = $TruenasDataVolume
                            })
                        cache  = @(@{
                                type  = $CacheVdevType
                                disks = @( $TruenasCacheVolume)
                            })
                        spares = @($TruenasSpareVolume)
                    }
                }


            }
            'DataLogSpare'
            {

                $TruenasLogVolume = @()
                $StartLogDisksNB..$($StartLogDisksNB + $NbLogDisks - 1) | Foreach-Object { $TruenasLogVolume += "$DiskNamebase$_" }

                $TruenasSpareVolume = @()
                $StartSpareDisksNB..$($StartSpareDisksNB + $NbSpareDisks - 1) | Foreach-Object { $TruenasSpareVolume += "$DiskNamebase$_" }

                $Obj = [Ordered]@{
                    name          = $PoolName
                    encryption    = $Encryption
                    deduplication = $Deduplication
                    topology      = [Ordered]@{
                        data   = @(@{
                                type  = $DataVdevType
                                disks = $TruenasDataVolume
                            })
                        log    = @(@{
                                type  = $LogVdevType
                                disks = @( $TruenasLogVolume)
                            })
                        spares = @($TruenasSpareVolume)
                    }
                }


            }

        }
    }

    End
    {
        $response = Invoke-TrueNasRestMethod -Method Post -body $Obj -Uri $uri
        Write-host "PROGESS : " -ForegroundColor Green -NoNewline
        do
        {
            $Value = $((Get-TrueNasJob -Id $response).Progress).Substring(10, 2)
            $Test = $Value -match ".*\d+.*"
            if ($Test -eq "True")
            {
                Write-host "$value%" -ForegroundColor Yellow -NoNewline
                Write-Host "..." -NoNewline
            }
            else
            { }
        }
        While ((Get-TrueNasJob -Id $response).State -eq "RUNNING")

        if ((Get-TrueNasJob -Id $response).State -eq "SUCCESS" )
        {
            Write-host " "
            Write-Output "The creation for the  $PoolName is finished "
            return $Obj
        }
        else
        {
            Write-Warning -Message "The opperation finish with some error"
            Get-TrueNasJob -Id $response
        }

    }
}
function Get-TrueNasJob
{
    [CmdletBinding()]

    Param(
        [Parameter (Mandatory = $false)]
        [Int]$Id,
        [ValidateSet("First", "Last", "FiveLast")]
        $Property
    )

    Begin
    {

    }
    Process
    {
        $Uri = "api/v2.0/core/get_jobs"
        $result = Invoke-TrueNasRestMethod -Uri $Uri -Method Get

    }
    End
    {
        $TrueNasJobs = New-Object -TypeName System.Collections.ArrayList

        if ( $PsBoundParameters.ContainsKey('Id'))
        {
            $result = $result | Where-Object { $_.id -eq "$id" }
            $temp = New-Object -TypeName System.Object
            $temp | Add-Member -MemberType NoteProperty -Name "Id" -Value "$($result.id)"
            $temp | Add-Member -MemberType NoteProperty -Name "Method" -Value "$($result.method)"
            $temp | Add-Member -MemberType NoteProperty -Name "Arguments" -Value "$($result.arguments)"
            $temp | Add-Member -MemberType NoteProperty -Name "Logs path" -Value "$($result.logs_path)"
            $temp | Add-Member -MemberType NoteProperty -Name "logs excerpt" -Value "$($result.logs_excerpt)"
            $temp | Add-Member -MemberType NoteProperty -Name "Progress" -Value "$($result.progress)"
            $temp | Add-Member -MemberType NoteProperty -Name "Result" -Value "$($result.result)"
            $temp | Add-Member -MemberType NoteProperty -Name "Error" -Value "$($result.error)"
            $temp | Add-Member -MemberType NoteProperty -Name "Exception" -Value "$($result.exception)"
            $temp | Add-Member -MemberType NoteProperty -Name "Exc info" -Value "$($result.exc_info)"
            $temp | Add-Member -MemberType NoteProperty -Name "State" -Value "$($result.state)"
            $TrueNasJobs.Add($temp) | Out-Null

        }
        elseif ( $PsBoundParameters.ContainsKey('Property'))
        {
            switch ($Property)
            {

                'First'
                {
                    $result = $result | Select-Object -First 1
                    $temp = New-Object -TypeName System.Object
                    $temp | Add-Member -MemberType NoteProperty -Name "Id" -Value "$($result.id)"
                    $temp | Add-Member -MemberType NoteProperty -Name "Method" -Value "$($result.method)"
                    $temp | Add-Member -MemberType NoteProperty -Name "Arguments" -Value "$($result.arguments)"
                    $temp | Add-Member -MemberType NoteProperty -Name "Logs path" -Value "$($result.logs_path)"
                    $temp | Add-Member -MemberType NoteProperty -Name "logs excerpt" -Value "$($result.logs_excerpt)"
                    $temp | Add-Member -MemberType NoteProperty -Name "Progress" -Value "$($result.progress)"
                    $temp | Add-Member -MemberType NoteProperty -Name "Result" -Value "$($result.result)"
                    $temp | Add-Member -MemberType NoteProperty -Name "Error" -Value "$($result.error)"
                    $temp | Add-Member -MemberType NoteProperty -Name "Exception" -Value "$($result.exception)"
                    $temp | Add-Member -MemberType NoteProperty -Name "Exc info" -Value "$($result.exc_info)"
                    $temp | Add-Member -MemberType NoteProperty -Name "State" -Value "$($result.state)"
                    $TrueNasJobs.Add($temp) | Out-Null
                }
                'Last'
                {
                    $result = $result | Select-Object -Last 1
                    $temp = New-Object -TypeName System.Object
                    $temp | Add-Member -MemberType NoteProperty -Name "Id" -Value "$($result.id)"
                    $temp | Add-Member -MemberType NoteProperty -Name "Method" -Value "$($result.method)"
                    $temp | Add-Member -MemberType NoteProperty -Name "Arguments" -Value "$($result.arguments)"
                    $temp | Add-Member -MemberType NoteProperty -Name "Logs path" -Value "$($result.logs_path)"
                    $temp | Add-Member -MemberType NoteProperty -Name "logs excerpt" -Value "$($result.logs_excerpt)"
                    $temp | Add-Member -MemberType NoteProperty -Name "Progress" -Value "$($result.progress)"
                    $temp | Add-Member -MemberType NoteProperty -Name "Result" -Value "$($result.result)"
                    $temp | Add-Member -MemberType NoteProperty -Name "Error" -Value "$($result.error)"
                    $temp | Add-Member -MemberType NoteProperty -Name "Exception" -Value "$($result.exception)"
                    $temp | Add-Member -MemberType NoteProperty -Name "Exc info" -Value "$($result.exc_info)"
                    $temp | Add-Member -MemberType NoteProperty -Name "State" -Value "$($result.state)"
                    $TrueNasJobs.Add($temp) | Out-Null

                }
                'fiveLast'
                {
                    $result = $result | Select-Object -Last 5
                    for ($i = 0; $i -lt $result.Count; $i++)
                    {
                        $temp = New-Object -TypeName System.Object
                        $temp | Add-Member -MemberType NoteProperty -Name "Id" -Value "$($result[$i].id)"
                        $temp | Add-Member -MemberType NoteProperty -Name "Method" -Value "$($result[$i].method)"
                        $temp | Add-Member -MemberType NoteProperty -Name "Arguments" -Value "$($result[$i].arguments)"
                        $temp | Add-Member -MemberType NoteProperty -Name "Logs path" -Value "$($result[$i].logs_path)"
                        $temp | Add-Member -MemberType NoteProperty -Name "logs excerpt" -Value "$($result[$i].logs_excerpt)"
                        $temp | Add-Member -MemberType NoteProperty -Name "Progress" -Value "$($result[$i].progress)"
                        $temp | Add-Member -MemberType NoteProperty -Name "Result" -Value "$($result[$i].result)"
                        $temp | Add-Member -MemberType NoteProperty -Name "Error" -Value "$($result[$i].error)"
                        $temp | Add-Member -MemberType NoteProperty -Name "Exception" -Value "$($result[$i].exception)"
                        $temp | Add-Member -MemberType NoteProperty -Name "Exc info" -Value "$($result[$i].exc_info)"
                        $temp | Add-Member -MemberType NoteProperty -Name "State" -Value "$($result[$i].state)"
                        $TrueNasJobs.Add($temp) | Out-Null
                    }
                }
            }
        }
        else
        {

            if ($null -eq $result.count)
            {
                $temp = New-Object -TypeName System.Object
                $temp | Add-Member -MemberType NoteProperty -Name "Id" -Value "$($result.id)"
                $temp | Add-Member -MemberType NoteProperty -Name "Method" -Value "$($result.method)"
                $temp | Add-Member -MemberType NoteProperty -Name "Arguments" -Value "$($result.arguments)"
                $temp | Add-Member -MemberType NoteProperty -Name "Logs path" -Value "$($result.logs_path)"
                $temp | Add-Member -MemberType NoteProperty -Name "logs excerpt" -Value "$($result.logs_excerpt)"
                $temp | Add-Member -MemberType NoteProperty -Name "Progress" -Value "$($result.progress)"
                $temp | Add-Member -MemberType NoteProperty -Name "Result" -Value "$($result.result)"
                $temp | Add-Member -MemberType NoteProperty -Name "Error" -Value "$($result.error)"
                $temp | Add-Member -MemberType NoteProperty -Name "Exception" -Value "$($result.exception)"
                $temp | Add-Member -MemberType NoteProperty -Name "Exc info" -Value "$($result.exc_info)"
                $temp | Add-Member -MemberType NoteProperty -Name "State" -Value "$($result.state)"
                $TrueNasJobs.Add($temp) | Out-Null

            }
            else
            {
                for ($i = 0; $i -lt $result.Count; $i++)
                {
                    $temp = New-Object -TypeName System.Object
                    $temp | Add-Member -MemberType NoteProperty -Name "Id" -Value "$($result[$i].id)"
                    $temp | Add-Member -MemberType NoteProperty -Name "Method" -Value "$($result[$i].method)"
                    $temp | Add-Member -MemberType NoteProperty -Name "Arguments" -Value "$($result[$i].arguments)"
                    $temp | Add-Member -MemberType NoteProperty -Name "Logs path" -Value "$($result[$i].logs_path)"
                    $temp | Add-Member -MemberType NoteProperty -Name "logs excerpt" -Value "$($result[$i].logs_excerpt)"
                    $temp | Add-Member -MemberType NoteProperty -Name "Progress" -Value "$($result[$i].progress)"
                    $temp | Add-Member -MemberType NoteProperty -Name "Result" -Value "$($result[$i].result)"
                    $temp | Add-Member -MemberType NoteProperty -Name "Error" -Value "$($result[$i].error)"
                    $temp | Add-Member -MemberType NoteProperty -Name "Exception" -Value "$($result[$i].exception)"
                    $temp | Add-Member -MemberType NoteProperty -Name "Exc info" -Value "$($result[$i].exc_info)"
                    $temp | Add-Member -MemberType NoteProperty -Name "State" -Value "$($result[$i].state)"
                    $TrueNasJobs.Add($temp) | Out-Null
                }

            }

        }

        return $TrueNasJobs
    }
}

function Get-TrueNasUpdateTrain
{
    Param
    ( )

    Begin
    {

    }
    Process
    {
        $Uri = "api/v2.0/update/get_trains"

        $result = Invoke-TrueNasRestMethod -Uri $Uri -Method Get

        $results = $result | foreach-object { $_.trains.psobject.properties }
    }
    End
    {
        $Available = New-Object -TypeName System.Collections.ArrayList

        $temp = New-Object -TypeName PSObject
        $temp | Add-Member -MemberType NoteProperty -Name "Current profile" -Value $result.current
        $temp | Add-Member -MemberType NoteProperty -Name "Current selected" -Value $result.selected
        for ($i = 0; $i -lt $results.Count; $i++)
        {

            $temp | Add-Member -MemberType NoteProperty -Name "Profile Available $i" -Value $results[$i].Name
            $temp | Add-Member -MemberType NoteProperty -Name "Profile $i description" -Value $results[$i].Value.description

        }
        $Available.Add($temp) | Out-Null

        return $Available
    }
}

function Set-TrueNasUpdateTrain
{
    [CmdletBinding()]
    Param
    (
        [Parameter (Mandatory = $true )]
        [ValidateSet("FreeNAS-11.3-STABLE", "FreeNAS-11.3-RC", "reeNAS-11.2-STABLE", "FreeNAS-11-STABLE", "FreeNAS-11-Nightlies-SDK", "FreeNAS-11-Nightlies", "FreeNAS-9.10-STABLE")]
        [String]$Train
    )

    Begin
    {

    }
    Process
    {
        $Uri = "api/v2.0/update/set_train"
        $Obj = $Train
        $obj = $Obj | ConvertTo-Json -Depth 5
        $obj
        #$result = Invoke-TrueNasRestMethod -Method Post -body $Obj -Uri $uri

    }
    End
    {
    }
}

function New-TrueNasIscsiPortal
{
    [CmdletBinding()]
    [Alias()]
    [OutputType([int])]
    Param
    (
        [Parameter (Mandatory = $true)]
        $IpPortal,

        [Parameter (Mandatory = $false)]
        [string]$Port = 3260 ,

        [Parameter (Mandatory = $false)]
        [string]$Comment
    )



    Begin
    {

    }
    Process
    {
        $Uri = "api/v2.0/iscsi/portal"

        $Obj = [Ordered]@{
            listen  = @(@{
                    ip   = $IpPortal
                    port = $Port
                })
            comment = $Comment
        }


        $response = Invoke-TrueNasRestMethod -method Post -body $Obj -Uri $Uri

    }
    End
    { }
}

function New-TrueNasIscsiInitiator
{
    [CmdletBinding()]
    [Alias()]
    [OutputType([int])]
    Param
    (

        [Parameter (Mandatory = $False)]
        [ValidateSet("ALL")]
        [string]$AuthInitiators = "ALL",

        [Parameter (Mandatory = $False)]
        [ValidateSet("ALL")]
        [String]$AuthNetwork = "ALL",
        [Parameter (Mandatory = $False)]
        [String]$comment

    )


    Begin
    {
        if ( $AuthInitiators -eq "ALL")
        {
            $AuthInitiator = ""
        }
        else { $AuthInitiators = $AuthInitiator }

        if ( $AuthNetwork -eq "ALL")
        {
            $AuthNetworks = ""
        }
        else { $AuthNetwork = $AuthNetworks }
    }
    Process
    {
        $Uri = "api/v2.0/iscsi/initiator"

        $Obj = [Ordered]@{

            initiators   = @($AuthInitiator)
            auth_network = @($AuthNetworks)
            comment      = $comment
        }


        $result = Invoke-TrueNasRestMethod -Method Post -body $Obj -Uri $uri


    }
    End
    { }
}

function New-TrueNasIscsiTarget
{
    [CmdletBinding()]
    [Alias()]
    [OutputType([int])]
    Param
    (
        [Parameter (Mandatory = $true)]
        [string]$TargetName,

        [Parameter (Mandatory = $true)]
        [string]$TargetAlias,

        [Parameter (Mandatory = $true)]
        [Int]$GroupsPortalId,

        [Parameter (Mandatory = $true)]
        [Int]$GroupsInitiatorId,

        [Parameter (Mandatory = $false)]
        [int]$Auth,

        [Parameter (Mandatory = $false)]
        [string]$Authmethod = "NONE",

        [Parameter (Mandatory = $false)]
        [string]$TargetMode = "ISCSI"


    )
    Begin
    {

    }
    Process
    {
        $Uri = "api/v2.0/iscsi/target"

        $Obj = new-Object -TypeName PSObject

        $Obj = [Ordered]@{

            name   = $TargetName.ToLower()
            alias  = $TargetAlias.ToLower()
            mode   = $TargetMode.ToUpper()
            groups = @([Ordered]@{
                    portal     = $GroupsPortalId
                    initiator  = $GroupsInitiatorId
                    auth       = $Auth
                    authmethod = $Authmethod
                })
        }

        $response = Invoke-TrueNasRestMethod -method Post -body $Obj -Uri $Uri


    }
    End
    { }
}

function New-TrueNasIscsiExtent
{

    [CmdletBinding()]
    [Alias()]
    [OutputType([int])]
    Param
    (

        [Parameter (Mandatory = $true)]
        [string]$ExtentName,

        [Parameter (Mandatory = $true)]
        [ValidateSet("DISK", "Zvol", "File")]
        [String]$ExtenType,

        [Parameter (Mandatory = $false)]
        [String]$TrueNasPoolName,

        [Parameter (Mandatory = $false)]
        [String]$TrueNasZvolName,


        [Parameter (Mandatory = $true)]
        [ValidateSet("Unknown", "SSD", "5400", "7200", "10000", "15000")]
        $ExtentSpeed,

        [Parameter (Mandatory = $false)]
        [string]$ExtendComment,

        [Parameter (Mandatory = $false)]
        [String]$ExtenDiskPath

    )


    Begin
    {

    }

    Process
    {
        $Uri = "api/v2.0/iscsi/extent"

        switch ($ExtenType)
        {
            Zvol
            {
                $ExtenType = "DISK"
                $ExtenDiskPath = 'zvol/' + $TrueNasPoolName + '/' + $TrueNasZvolName
                $Obj = [Ordered]@{
                    name         = $ExtentName
                    type         = $ExtenType
                    disk         = $ExtenDiskPath
                    comment      = $ExtendComment
                    insecure_tpc = $true
                    xen          = $true
                    rpm          = $ExtentSpeed
                    ro           = $true
                    enabled      = $true
                }

            }
            DISK
            {
                $Obj = [Ordered]@{
                    name         = $ExtentName
                    type         = $ExtenType
                    disk         = $ExtenDiskPath
                    comment      = $ExtendComment
                    insecure_tpc = $true
                    xen          = $true
                    rpm          = $ExtentSpeed
                    ro           = $true
                    enabled      = $true
                }
            }
            File { Write-Warning "Not implemented yet..." }
            Default { }
        }
        Invoke-TrueNasRestMethod -method Post -body $Obj -Uri $Uri

    }
    End
    { }

}

function New-TrueNasIscsiAssociat2Extent
{

    [CmdletBinding()]
    [Alias()]
    [OutputType([int])]
    Param
    (

        [Parameter (Mandatory = $true)]
        [INT]$TargetId,

        [Parameter (Mandatory = $true)]
        [INT]$ExtentId

    )


    Begin
    {

    }

    Process
    {
        $Uri = "api/v2.0/iscsi/targetextent"

        $Obj = [Ordered]@{
            target = $TargetId
            extent = $ExtentId
            lunid  = 0

        }

        $result = Invoke-TrueNasRestMethod -method Post -body $Obj -Uri $Uri

    }

    End
    { }
}


function Get-TrueNasAlertsList
{

    [CmdletBinding()]
    [Alias()]
    [OutputType([int])]
    Param
    ( )


    Begin
    {

    }

    Process
    {
        $Uri = "api/v2.0/alert/list"

        $result = Invoke-TrueNasRestMethod -method GET -Uri $Uri
        $result
    }

    End
    { }
}

function Get-TrueNasPlugin
{

    [CmdletBinding()]
    [Alias()]
    Param
    ( )


    Begin
    {

    }

    Process
    {
        $Uri = "api/v2.0/plugin/official_repositories"

        $result = Invoke-TrueNasRestMethod -method GET -Uri $Uri

        foreach ($item in $result.IXSYSTEMS)
        {
            $IXSYSTEMS = New-Object -TypeName PSObject
            $IXSYSTEMS | Add-Member -MemberType NoteProperty -Name "Name" -Value $item.name
            $IXSYSTEMS | Add-Member -MemberType NoteProperty -Name "Git repository" -Value $item.git_repository
        }

        foreach ($item in $result.COMMUNITY)
        {
            $COMMUNITY = New-Object -TypeName PSObject
            $COMMUNITY | Add-Member -MemberType NoteProperty -Name "Name" -Value $item.name
            $COMMUNITY | Add-Member -MemberType NoteProperty -Name "Git repository" -Value $item.git_repository
        }

    }

    End
    {
        return $IXSYSTEMS, $COMMUNITY
    }
}

function Remove-TrueNasIscsiExtent
{
    [CmdletBinding(SupportsShouldProcess)]
    [Alias()]
    Param
    (
        [Parameter (Mandatory = $true)]
        [Int]$Id
    )


    Begin
    {

    }
    Process
    {

        $Uri = "api/v2.0/iscsi/extent/id/$Id"

        if ($PSCmdlet.ShouldProcess("will be remove" , "The Association to Exent with the id $Id"))
        {
            $response = Invoke-TrueNasRestMethod -method Delete -body $post -Uri $Uri
        }

    }
    End
    {

    }
}

function Remove-TrueNasIscsiAssociat2Extent
{
    [CmdletBinding(SupportsShouldProcess)]
    [Alias()]
    Param
    (
        [Parameter (Mandatory = $true)]
        [Int]$Id
    )


    Begin
    {

    }
    Process
    {

        $Uri = "api/v2.0/iscsi/targetextent/id/$Id"

        if ($PSCmdlet.ShouldProcess("will be remove" , "The Association to Exent with the id $Id"))
        {
            $response = Invoke-TrueNasRestMethod -method Delete -body $post -Uri $Uri
        }

    }
    End
    {

    }
}

function Start-TrueNasService
{
    Param
    (
        [Parameter (Mandatory = $true)]
        [ValidateSet("afp", "cifs", "dynamicdns", "ftp", "iscsitarget", "nfs", "snmp", "ssh", "tftp", "ups", "rsync", "smartd", "lldp", "webdav", "s3", "openvpn_client", "openvpn_server")]
        [String]$Service
    )

    Begin
    {

    }
    Process
    {
        $Uri = "api/v2.0/service/start"
        $Obj = [Ordered]@{

            service           = $Service
            'service-control' = @{
                ha_propagate = $true
            }
        }
        $result = Invoke-TrueNasRestMethod -Method Post -body $Obj -Uri $uri
    }
    End
    {
        $result
    }
}

function Stop-TrueNasService
{
    Param
    (
        [Parameter (Mandatory = $true)]
        [ValidateSet("afp", "cifs", "dynamicdns", "ftp", "iscsitarget", "nfs", "snmp", "ssh", "tftp", "ups", "rsync", "smartd", "lldp", "webdav", "s3", "openvpn_client", "openvpn_server")]
        [String]$Service
    )

    Begin
    {

    }
    Process
    {
        $Uri = "api/v2.0/service/stop"
        $Obj = [Ordered]@{

            service           = $Service
            'service-control' = @{
                ha_propagate = $true
            }
        }
        $result = Invoke-TrueNasRestMethod -Method Post -body $Obj -Uri $uri
    }
    End
    {
        $result
    }
}

function Restart-TrueNasService
{
    Param
    (
        [Parameter (Mandatory = $true)]
        [ValidateSet("afp", "cifs", "dynamicdns", "ftp", "iscsitarget", "nfs", "snmp", "ssh", "tftp", "ups", "rsync", "smartd", "lldp", "webdav", "s3", "openvpn_client", "openvpn_server")]
        [String]$Service
    )

    Begin
    {

    }
    Process
    {
        $Uri = "api/v2.0/service/restart"
        $Obj = [Ordered]@{

            service           = $Service
            'service-control' = @{
                ha_propagate = $true
            }
        }
        $result = Invoke-TrueNasRestMethod -Method Post -body $Obj -Uri $uri
    }
    End
    {
        $result
    }
}
function Reload-TrueNasService
{
    Param
    (
        [Parameter (Mandatory = $true)]
        [ValidateSet("afp", "cifs", "dynamicdns", "ftp", "iscsitarget", "nfs", "snmp", "ssh", "tftp", "ups", "rsync", "smartd", "lldp", "webdav", "s3", "openvpn_client", "openvpn_server")]
        [String]$Service
    )

    Begin
    {

    }
    Process
    {
        $Uri = "api/v2.0/service/reload"
        $Obj = [Ordered]@{

            service           = $Service
            'service-control' = @{
                ha_propagate = $true
            }
        }
        $result = Invoke-TrueNasRestMethod -Method Post -body $Obj -Uri $uri
    }
    End
    {
        $result
    }
}

function Kill-TrueNasService
{
    Param
    (
        [Parameter (Mandatory = $true)]
        [Int]$PidService,
        [Parameter (Mandatory = $false)]
        [Int]$TimeoutSecond = 0

    )

    Begin
    {
        if ( $PsBoundParameters.ContainsKey('TimeoutSecond') )
        {
            $TimeoutSecond = $TimeoutSecond
            Write-Verbose "The timeout is set to $TimeoutSecond seconds"

        }
        else
        {
            $TimeoutSecond = 0
            Write-Verbose "By default the timeout is set to 0 second"
        }
    }
    Process
    {
        $Uri = "api/v2.0/service/terminate_process"
        $Obj = [Ordered]@{

            pid     = $PidService
            timeout = $TimeoutSecond
        }
        $result = Invoke-TrueNasRestMethod -Method Post -body $Obj -Uri $uri
    }
    End
    {
        $result
    }
}

function Set-TrueNasServiceAtBoot
{
    Param
    (
        [Parameter (Mandatory = $true)]
        [Int]$PidService,
        [Parameter (Mandatory = $true)]
        [bool]$Enable
    )

    Process
    {
        $Uri = "api/v2.0/service/id/$PidService "
        $Obj = [Ordered]@{

            enable = $Enable
        }
        $result = Invoke-TrueNasRestMethod -Method PUT -body $Obj -Uri $uri
    }
    End
    {
        Write-Output "==> The Service with the PID $PidService is set to $Enable StartAtBoot"
    }
}

function Get-TrueNasCertificateById
{
    [CmdletBinding()]
    [Alias()]
    Param
    (
        [Parameter (Mandatory = $true)]
        [Int]$Id,
        [Parameter (Mandatory = $false)]
        [switch]$ExportCert,
        [Parameter (Mandatory = $false)]
        [switch]$PrivateKey

    )

    Begin
    {
        $uri = "api/v2.0/certificate/id/$Id"
    }
    Process
    {
        Write-Verbose $uri
        $result = Invoke-TrueNasRestMethod -Uri $Uri -Method Get

        $Certificate = New-Object -TypeName System.Collections.ArrayList

        $temp = New-Object -TypeName System.Object
        $temp | Add-Member -MemberType NoteProperty -Name "Name" -Value "$($result.name)"
        $temp | Add-Member -MemberType NoteProperty -Name "Id" -Value "$($result.id)"
        $temp | Add-Member -MemberType NoteProperty -Name "Type" -Value "$($result.type)"
        $temp | Add-Member -MemberType NoteProperty -Name "Certificate" -Value "$($result.certificate)"
        $temp | Add-Member -MemberType NoteProperty -Name "PrivateKey" -Value "$($result.privatekey)"
        $temp | Add-Member -MemberType NoteProperty -Name "CSR" -Value "$($result.CSR)"
        $temp | Add-Member -MemberType NoteProperty -Name "Signedby" -Value "$($result.signedby)"
        $temp | Add-Member -MemberType NoteProperty -Name "Root path" -Value "$($result.root_path)"
        $temp | Add-Member -MemberType NoteProperty -Name "Certificate path" -Value "$($result.certificate_path)"
        $temp | Add-Member -MemberType NoteProperty -Name "Private key path" -Value "$($result.private_key_path)"
        $temp | Add-Member -MemberType NoteProperty -Name "Csr path" -Value "$($result.csr_path)"
        $temp | Add-Member -MemberType NoteProperty -Name "Cert type" -Value "$($result.cert_type)"
        $temp | Add-Member -MemberType NoteProperty -Name "Issuer" -Value "$($result.issuer)"
        $temp | Add-Member -MemberType NoteProperty -Name "Chain list" -Value "$($result.chain_list)"
        $temp | Add-Member -MemberType NoteProperty -Name "Country" -Value "$($result.country)"
        $temp | Add-Member -MemberType NoteProperty -Name "State" -Value "$($result.state)"
        $temp | Add-Member -MemberType NoteProperty -Name "City" -Value "$($result.city)"
        $temp | Add-Member -MemberType NoteProperty -Name "Organization" -Value "$($result.organization)"
        $temp | Add-Member -MemberType NoteProperty -Name "Organizational unit" -Value "$($result.organization_unit)"
        $temp | Add-Member -MemberType NoteProperty -Name "Common" -Value "$($result.Common)"
        $temp | Add-Member -MemberType NoteProperty -Name "San" -Value "$($result.San)"
        $temp | Add-Member -MemberType NoteProperty -Name "Email" -Value "$($result.email)"
        $temp | Add-Member -MemberType NoteProperty -Name "DN" -Value "$($result.DN)"
        $temp | Add-Member -MemberType NoteProperty -Name "Digest_algorithm" -Value "$($result.digest_algorithm)"
        $temp | Add-Member -MemberType NoteProperty -Name "Lifetime" -Value "$($result.lifetime)"
        $temp | Add-Member -MemberType NoteProperty -Name "From" -Value "$($result.from)"
        $temp | Add-Member -MemberType NoteProperty -Name "Until" -Value "$($result.until)"
        $temp | Add-Member -MemberType NoteProperty -Name "Serial" -Value "$($result.serial)"
        $temp | Add-Member -MemberType NoteProperty -Name "Chain" -Value "$($result.chain)"
        $temp | Add-Member -MemberType NoteProperty -Name "Fingerprint" -Value "$($result.fingerprint)"
        $temp | Add-Member -MemberType NoteProperty -Name "Key lenght" -Value "$($result.key_length)"
        $temp | Add-Member -MemberType NoteProperty -Name "Key Type" -Value "$($result.key_type)"
        $temp | Add-Member -MemberType NoteProperty -Name "Parsed" -Value "$($result.parsed)"
        $temp | Add-Member -MemberType NoteProperty -Name "Internal" -Value "$($result.internal)"
        $temp | Add-Member -MemberType NoteProperty -Name "CA Type Existing" -Value "$($result.CA_type_existing)"
        $temp | Add-Member -MemberType NoteProperty -Name "CA type Internal" -Value "$($result.CA_type_internal)"
        $temp | Add-Member -MemberType NoteProperty -Name "CA type Intermediate" -Value "$($result.CA_type_intermediate)"
        $temp | Add-Member -MemberType NoteProperty -Name "Cert type existing" -Value "$($result.cert_type_existing)"
        $temp | Add-Member -MemberType NoteProperty -Name "Cert type Internal" -Value "$($result.cert_type_internal)"
        $temp | Add-Member -MemberType NoteProperty -Name "CA type CSR" -Value "$($result.cert_type_CSR)"
        $Certificate.Add($temp) | Out-Null

    }
    End
    {
        if ( $PsBoundParameters.ContainsKey('ExportCert') )
        {
            Write-Verbose "We are trying to export the Cerificate file  $($result.name).crt"
            $crtFile = $($result.certificate)
            $crtFile | Out-File -FilePath "$($result.name).crt"
            Write-Output "The certificate is exported to $($result.name).crt"

        }
        if ( $PsBoundParameters.ContainsKey('PrivateKey') )
        {
            Write-Verbose "We are trying to export the private Key   $($result.name).key"
            $KeyFile = $($result.privatekey)
            $KeyFile | Out-File -FilePath "$($result.name).key"
            Write-Output "The private is exported to $($result.name).key"
        }
        return $Certificate
    }
}

function Get-TrueNasCertificateCountryChoices
{
    [CmdletBinding()]
    [Alias()]
    Param
    ()

    Begin
    {
        $uri = "api/v2.0/certificate/country_choices"
    }
    Process
    {
        Write-Verbose $uri
        $result = Invoke-TrueNasRestMethod -Uri $Uri -Method Get

    }
    End
    {
        return $result
    }
}

function Get-TrueNasCertificateAcmeServer
{
    [CmdletBinding()]
    [Alias()]
    Param
    ()

    Begin
    {
        $uri = "api/v2.0/certificate/acme_server_choices"
    }
    Process
    {
        Write-Verbose $uri
        $result = Invoke-TrueNasRestMethod -Uri $Uri -Method Get

    }
    End
    {
        return $result
    }
}

function Get-TrueNasCertificateProfiles
{
    [CmdletBinding()]
    [Alias()]
    Param
    ()

    Begin
    {
        $uri = "api/v2.0/certificate/profiles"
    }
    Process
    {
        Write-Verbose $uri
        $result = Invoke-TrueNasRestMethod -Uri $Uri -Method Get
    }
    End
    {
        return $result
    }
}

function Get-TrueNasDnsServer
{
    [CmdletBinding()]
    [Alias()]
    Param
    ()

    Begin
    {
        $uri = "api/v2.0/dns/query"
    }
    Process
    {
        Write-Verbose $uri
        $result = Invoke-TrueNasRestMethod -Uri $Uri -Method Get
    }
    End
    {
        return $result
    }
}



$Uri = "api/v2.0/interface"
$result = Invoke-TrueNasRestMethod -Uri $Uri -Method Get

$result = Invoke-TrueNasRestMethod -Method Post -body $Obj -Uri $uri




###########TEST#######################################################
Connect-TrueNasServer -Server 192.168.0.24 -httpOnly
Get-TrueNasCertificate -Verbose
Get-TrueNasDisk -Verbose
Get-TrueNasDiskUnsed -Verbose
Get-TrueNasGlobalConfig
Get-TrueNasInterface
Get-TrueNasIscsiConf
Get-TrueNasIscsiExtent
Get-TrueNasIscsiInitiator
Get-TrueNasIscsiPortal
Get-TrueNasIscsiTarget
Get-TrueNasIscsiAssociat2Extent -Output Name
Get-TrueNasService
Get-TrueNasSetting
Get-TrueNasSystemAdvanced
Get-TrueNasSystemAlert
Get-TrueNasSystemNTP
Get-TrueNasSystemVersion
Get-TrueNasVolume
Get-TrueNasPool
New-TrueNasZvol -Name Zvol1 -ZvolName Data -Type VOLUME -Volsize 1 -Unit GiB -Sparse $true -Comment "demo" -Compression LZ4
New-TrueNasPool -PoolName Data -Encryption $false -Deduplication OFF -PoolDesign DataCacheLog -DataVdevType MIRROR -NbDataDisks 4 -StartDataDisksNB 4 -CacheVdevType STRIPE  -StartCacheDisksNB 7 -StartLogDisksNB 10 -NbLogDisks 1 -LogVdevType STRIPE
Get-TrueNasUpdateProfile
New-TrueNasIscsiTarget -TargetName LUN4 -TargetAlias lun4 -GroupsPortalId 1 -GroupsInitiatorId 1
New-TrueNasIscsiExtent -ExtentName test -ExtenType Zvol -ExtentSpeed SSD -ExtendComment "essai" -TrueNasPoolName Data -TrueNasZvolName Zvol1
New-TrueNasIscsiExtent -ExtentName test1 -ExtenType DISK -ExtentSpeed SSD -ExtendComment "essa1" -ExtenDiskPath da6
Get-TrueNasAlertsList
Get-TrueNasPlugin
Get-TrueNasUpdateTrain


