function Block-TrueNasService
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