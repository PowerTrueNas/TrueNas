function Get-TrueNasInterface
{
    [CmdletBinding()]
    [Alias()]

    Param
    ()


    Begin
    {
        $uri = "api/v2.0/interface"
    }
    Process
    {

        $result = Invoke-TrueNasRestMethod -Uri $Uri -Method Get

    }
    End
    {
        for ($i = 0; $i -lt $result.Count; $i++)
        {
            foreach ($item in $result[$i])
            {
                [PSCustomObject]@{
                    id                   = ($result[$i].id)
                    Name                 = ($result[$i].name)
                    Fake                 = ($result[$i].fake)
                    Type                 = ($result[$i].type)
                    Aliases              = ($result[$i].aliases)
                    "Dhcp ipv4"          = ($result[$i].ipv4_dhcp)
                    "Dhcp ipv6"          = ($result[$i].ipv6_auto)
                    Description          = ($result[$i].description)
                    Options              = ($result[$i].options)
                    "Name parent"        = ($result[$i].state.name)
                    "Origin Name"        = ($result[$i].state.description)
                    "Description parent" = ($result[$i].state.description)
                    MTU                  = ($result[$i].state.mtu)
                    Cloned               = ($result[$i].state.cloned)
                    Flags                = ($result[$i].state.nd6_flags)
                    "Link state"         = ($result[$i].state.link_state)
                    "Media type"         = ($result[$i].state.media_type)
                    "Active media type"  = ($result[$i].state.active_media_type)
                    "Supported_media"    = ($result[$i].state.supported_media)
                    "Media options"      = ($result[$i].state.media_options)
                    "Mac Address"        = ($result[$i].state.link_address)

                }
            }
        }

    }
}
