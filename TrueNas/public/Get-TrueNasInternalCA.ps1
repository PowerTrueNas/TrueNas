function Get-TrueNasInternalCA
{
    [CmdletBinding()]
    [Alias()]
    Param
    ()


    Begin
    { }
    Process
    {
        $Uri = "api/v2.0/certificateauthority"

        $result = Invoke-TrueNasRestMethod -Uri $Uri -Method Get
        return $result
    }
    End
    {
    }
}
