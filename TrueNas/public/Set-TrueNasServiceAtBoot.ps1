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
