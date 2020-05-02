function Invoke-FreeNasRestMethod
{

    <#
      .SYNOPSIS
      Invoke RestMethod with FreeNas connection (internal) variable

      .DESCRIPTION
      Invoke RestMethod with FreeNas connection variable (token,.)

      .EXAMPLE
      Invoke-FreeNasRestMethod -method "get" -uri "api/v1.0/storage/disk/"

      Invoke-RestMethod with FreeNas connection for get api/v1.0/storage/disk/ uri
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
            Throw "Not Connected. Connect to the FreeNas with Connect-FreeNasServer"
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
            Show-FreeNasException $_
            throw "Unable to use FreeNAS API"
        }
        $response

    }

}

function Set-FreeNasCipherSSL
{

    # Hack for allowing TLS 1.1 and TLS 1.2 (by default it is only SSL3 and TLS (1.0))
    $AllProtocols = [System.Net.SecurityProtocolType]'Ssl3,Tls,Tls11,Tls12'
    [System.Net.ServicePointManager]::SecurityProtocol = $AllProtocols

}
function Set-FreeNasUntrustedSSL
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

function Show-FreeNasException()
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
            Write-Warning "Try to use Connect-FreeNasServer -SkipCertificateCheck for connection"
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

        Write-Warning "The FreeNas  API sends an error message:"
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
function Connect-FreeNasServer
{
    [CmdletBinding()]
    [Alias()]
    [OutputType([String])]
    Param
    (
        # Description d’aide Freenas
        [Parameter(Mandatory = $true)]
        [Alias("Freenas")]
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
            #New-banner -Text "FreeNas 2.0" -Online -ErrorAction stop
        }
        Catch
        {
            #New-banner -Text "FreeNas 2.0"
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
            $Credentials = Get-Credential -Message 'Please enter administrative credentials for your FreeNas'
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
                Set-FreeNasCipherSSL
                if ($SkipCertificateCheck)
                {
                    Write-Verbose -Message "Disable SSL chain trust"

                    #Disable SSL chain trust...
                    Set-FreeNasuntrustedSSL
                }

            }
            $uri = "http://${Server}:${port}/api/v2.0/system/info"

        }

        $script:port = $port
        $script:httpOnly = $httpOnly
        $Script:ApiVersion = $ApiVersion

        try
        {
            $result = Invoke-RestMethod -Uri $uri -Method Get -SessionVariable Freenas_S -headers $headers @invokeParams
        }
        catch
        {
            Show-FreeNasException -Exception $_
            throw "Unable to connect"
        }

        if ($null -eq $result.version )
        {
            throw "Unable to get data"
        }

        Write-Host "Welcome on"$result.name"-"$result.version"-"$result.system_product""

        $Script:Session = $Freenas_S


    }
    End
    {

    }
}


function New-FreeNasPool
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
        [ValidateSet("STRIPE", "MIRROR", "RAIDZ1", "RAIDZ2", "RAIDZ3")]
        [String]$DataVdevType,
        [Parameter (Mandatory = $False)]
        [ValidateSet("STRIPE", "MIRROR", "RAIDZ1", "RAIDZ2", "RAIDZ3")]
        [String]$CacheVdevType,
        [Parameter (Mandatory = $False)]
        [ValidateSet("STRIPE", "MIRROR", "RAIDZ1", "RAIDZ2", "RAIDZ3")]
        [String]$LogVdevType,
        [Parameter (Mandatory = $false)]
        [AllowNull()]
        $force,
        [Parameter (Mandatory = $false)]
        [ValidateSet("Yes")]
        $CacheVdev,
        [Parameter (Mandatory = $false)]
        [ValidateSet("Yes")]
        $LogVdev,
        [Parameter (Mandatory = $false)]
        [ValidateSet("Yes")]
        $Spare,
        [Parameter (Mandatory = $true)]
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

        $FreenasDataVolume = @()
        $StartDataDisksNB..$($StartDataDisksNB + $NbDataDisks - 1) | Foreach-Object { $FreenasDataVolume += "$DiskNamebase$_" }


        if ( $PsBoundParameters.ContainsKey('CacheVdev') -and $PsBoundParameters.ContainsKey('LogVdev') -and $PsBoundParameters.ContainsKey('Spare'))
        {
            $FreenasCacheVolume = @()
            $StartCacheDisksNB..$($StartCacheDisksNB + $NbCacheDisks - 1) | Foreach-Object { $FreenasCacheVolume += "$DiskNamebase$_" }

            $FreenasLogVolume = @()
            $StartLogDisksNB..$($StartLogDisksNB + $NbLogDisks - 1) | Foreach-Object { $FreenasLogVolume += "$DiskNamebase$_" }

            $FreenasSpareVolume = @()
            $StartSpareDisksNB..$($StartSpareDisksNB + $NbSpareDisks - 1) | Foreach-Object { $FreenasSpareVolume += "$DiskNamebase$_" }

            $Obj = [Ordered]@{
                name          = $PoolName
                encryption    = $Encryption
                deduplication = $Deduplication
                topology      = [Ordered]@{
                    data   = @(@{
                            type  = $DataVdevType
                            disks = $FreenasDataVolume
                        })
                    cache  = @(@{
                            type  = $CacheVdevType
                            disks = @( $FreenasCacheVolume)
                        })
                    log    = @(@{
                            type  = $LogVdevType
                            disks = @( $FreenasLogVolume)
                        })
                    spares = @($FreenasSpareVolume)
                }
            }

        }
        else
        {

            $Obj = [Ordered]@{
                name          = $PoolName
                encryption    = $Encryption
                deduplication = $Deduplication
                topology      = [Ordered]@{
                    data = @(@{
                            type  = $DataVdevType
                            disks = $FreenasDataVolume
                        })
                }
            }
        }

    }

    End
    {
        $response = Invoke-FreeNasRestMethod -Method Post -body $Obj -Uri $uri
        Write-host "PROGESS : " -ForegroundColor Green -NoNewline
        do
        {
            $Value = $((Get-FreeNasJob -Id $response).Progress).Substring(10, 2)
            $Test = $Value -match ".*\d+.*"
            if ($Test -eq "True")
            {
                Write-host "$value%" -ForegroundColor Yellow -NoNewline
                Write-Host "..." -NoNewline
            }
            else
            { }
        }
        While ((Get-FreeNasJob -Id $response).State -eq "RUNNING")

        if ((Get-FreeNasJob -Id $response).State -eq "SUCCESS" )
        {
            Write-host " "
            Write-Output "The creation for the  $PoolName is finished "
        }
        else
        {
            Write-Warning -Message "The opperation finish with some error"
            Get-FreeNasJob -Id $response
        }

    }
}
function Get-FreeNasJob
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
        $result = Invoke-FreeNasRestMethod -Uri $Uri -Method Get

    }
    End
    {
        $FreeNasJobs = New-Object -TypeName System.Collections.ArrayList

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
            $FreeNasJobs.Add($temp) | Out-Null

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
                    $FreeNasJobs.Add($temp) | Out-Null
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
                    $FreeNasJobs.Add($temp) | Out-Null

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
                        $FreeNasJobs.Add($temp) | Out-Null
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
                $FreeNasJobs.Add($temp) | Out-Null

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
                    $FreeNasJobs.Add($temp) | Out-Null
                }

            }

        }

        return $FreeNasJobs
    }
}

function New-FreeNasIscsiPortal
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
            listen     = @(@{
                            ip  = $IpPortal
                            port = $Port
                        })
            comment = $Comment
        }


    $response = Invoke-FreeNasRestMethod -method Post -body $Obj -Uri $Uri

    }
    End
    { }
}

function New-FreeNasIscsiInitiator
{
    [CmdletBinding()]
    [Alias()]
    [OutputType([int])]
    Param
    (

        [Parameter (Mandatory = $False)]
        [ValidateSet("ALL")]
        [string]$AuthInitiators ="ALL",

        [Parameter (Mandatory = $False)]
        [ValidateSet("ALL")]
        [String]$AuthNetwork="ALL",
        [Parameter (Mandatory = $False)]
        [String]$comment

    )


    Begin
    {
        if ( $AuthInitiators -eq "ALL")
        {
            $AuthInitiator = ""        
        }
        else{ $AuthInitiators = $AuthInitiator }

        if ( $AuthNetwork -eq "ALL")
        {
            $AuthNetworks = ""        
        }
        else{ $AuthNetwork = $AuthNetworks }
    }
    Process
    {
        $Uri = "api/v2.0/iscsi/initiator"

        $Obj = [Ordered]@{
        
            initiators   = @($AuthInitiator)
            auth_network = $AuthNetworks
            comment = $comment
        }


        $result = Invoke-FreeNasRestMethod -Method Post -body $Obj -Uri $uri


    }
    End
    { }
}


Connect-FreeNasServer -Server 192.168.0.23  -httpOnly
New-FreeNasIscsiInitiator -AuthInitiators ALL -AuthNetwork ALL -comment test