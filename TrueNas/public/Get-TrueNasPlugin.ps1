function Get-TrueNasPlugin
{

    [CmdletBinding()]
    [Alias()]
    Param
    ( )


    Begin
    {

    }

    Process
    {
        $Uri = "api/v2.0/plugin/official_repositories"

        $result = Invoke-TrueNasRestMethod -method GET -Uri $Uri

        foreach ($item in $result.IXSYSTEMS)
        {
            $IXSYSTEMS = New-Object -TypeName PSObject
            $IXSYSTEMS | Add-Member -MemberType NoteProperty -Name "Name" -Value $item.name
            $IXSYSTEMS | Add-Member -MemberType NoteProperty -Name "Git repository" -Value $item.git_repository
        }

        foreach ($item in $result.COMMUNITY)
        {
            $COMMUNITY = New-Object -TypeName PSObject
            $COMMUNITY | Add-Member -MemberType NoteProperty -Name "Name" -Value $item.name
            $COMMUNITY | Add-Member -MemberType NoteProperty -Name "Git repository" -Value $item.git_repository
        }

    }

    End
    {
        return $IXSYSTEMS, $COMMUNITY
    }
}
