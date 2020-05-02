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
