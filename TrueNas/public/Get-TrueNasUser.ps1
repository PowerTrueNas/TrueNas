function Get-TrueNasUser
{
    [CmdletBinding()]
    Param( )
    begin
    {
        $uri = "api/v2.0/user"

    }
    process
    {
        $results = Invoke-TrueNasRestMethod -Uri $Uri -Method Get

        for ($i = 0; $i -lt $results.Count; $i++)
        {
            foreach ($User in $results[$i])
            {
                [PSCustomObject]@{
                    Id                = ($User.id)
                    uid               = ($User.uid)
                    Name              = ($User.username)
                    unixhash          = ($User.unixhash)
                    Smbhash           = ($User.smbhash)
                    homedir           = ($User.homedir)
                    shell             = ($User.shell)
                    full_name         = ($User.full_name)
                    buitin            = ($User.builtin)
                    smb               = ($User.smb)
                    password_disabled = ($User.password_disabled)
                    locked            = ($User.locked)
                    sudo              = ($User.sudo)
                    sudo_nopasswd     = ($User.sudo_nopasswd)
                    microsoft_account = ($User.microsoft_account)
                    attributes        = ($User.attributes)
                    email             = ($User.email)
                    group             = ($User.group)
                    groups            = ($User.groups)
                    local             = ($User.local)
                    id_type_both      = ($User.id_type_both)

                }
            }
        }
    }
    end
    { }
}
