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
