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
