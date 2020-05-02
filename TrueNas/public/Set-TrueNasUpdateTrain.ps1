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
