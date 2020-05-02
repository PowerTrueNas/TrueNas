function Get-TrueNasService
{
    Param
    ( )

    Begin
    {

    }
    Process
    {
        $Uri = "api/v2.0/service"

        $result = Invoke-TrueNasRestMethod -Uri $Uri -Method Get

    }
    End
    {
        $result
    }
}
