function Set-TrueNasUpdateTrain
{
    [CmdletBinding()]
    Param
    (
        [Parameter (Mandatory = $true )]
        [ValidateSet("TrueNAS-13.0-STABLE", "TrueNAS-SCALE-Angelfish", "TrueNAS-SCALE-Bluefin")]
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
