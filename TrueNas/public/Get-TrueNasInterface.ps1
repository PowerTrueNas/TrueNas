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
        $Global = new-Object -TypeName PSObject
        $Global | add-member -name "Id" -membertype NoteProperty -Value "$($result.id)"
        $Global | add-member -name "Name" -membertype NoteProperty -Value "$($result.name)"
        $Global | add-member -name "Fake" -membertype NoteProperty -Value "$($result.fake)"
        $Global | add-member -name "type" -membertype NoteProperty -Value "$($result.type)"
        $Global | add-member -name "Aliases" -membertype NoteProperty -Value "$($result.aliases)"
        $Global | add-member -name "Dhcp ipv4" -membertype NoteProperty -Value "$($result.ipv4_dhcp)"
        $Global | add-member -name "Dhcp ipv6" -membertype NoteProperty -Value "$($result.ipv6_auto)"
        $Global | add-member -name "Description" -membertype NoteProperty -Value "$($result.description)"
        $Global | add-member -name "Options" -membertype NoteProperty -Value "$($result.options)"
        $Global | add-member -name "Name parent" -membertype NoteProperty -Value "$($result.state.name)"
        $Global | add-member -name "Origin Name" -membertype NoteProperty -Value "$($result.state.orig_name)"
        $Global | add-member -name "Description parent" -membertype NoteProperty -Value "$($result.state.description)"
        $Global | add-member -name "MTU" -membertype NoteProperty -Value "$($result.state.mtu)"
        $Global | add-member -name "Cloned" -membertype NoteProperty -Value "$($result.state.cloned)"
        $Global | add-member -name "Flags" -membertype NoteProperty -Value "$($result.state.flags)"
        $Global | add-member -name "Nd6_flags" -membertype NoteProperty -Value "$($result.state.nd6_flags)"
        $Global | add-member -name "Link state" -membertype NoteProperty -Value "$($result.state.link_state)"
        $Global | add-member -name "Media type" -membertype NoteProperty -Value "$($result.state.media_type)"
        $Global | add-member -name "Media subtype" -membertype NoteProperty -Value "$($result.state.media_subtype)"
        $Global | add-member -name "Active media type" -membertype NoteProperty -Value "$($result.state.active_media_type)"
        $Global | add-member -name "Active media subtype" -membertype NoteProperty -Value "$($result.state.active_media_subtype)"
        $Global | add-member -name "Supported_media" -membertype NoteProperty -Value "$($result.state.supported_media)"
        $Global | add-member -name "Media options" -membertype NoteProperty -Value "$($result.state.media_options)"
        $Global | add-member -name "Mac Address" -membertype NoteProperty -Value "$($result.state.link_address)"


        return $Global
    }
}
