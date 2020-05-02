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
