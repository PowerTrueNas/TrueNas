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