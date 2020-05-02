function Get-TrueNasGlobalConfig
{
    [CmdletBinding()]
    [Alias()]
    Param
    ()


    Begin
    {
        $uri = "api/v2.0/network/configuration"
    }
    Process
    {

        $result = Invoke-TrueNasRestMethod -Uri $Uri -Method Get

    }
    End
    {
        $Global = new-Object -TypeName PSObject

        $Global | add-member -name "Id" -membertype NoteProperty -Value "$($result.id)"
        $Global | add-member -name "Domain" -membertype NoteProperty -Value "$($result.domain)"
        $Global | add-member -name "Gateway Ipv4" -membertype NoteProperty -Value "$($result.ipv4gateway)"
        $Global | add-member -name "Gateway Ipv6" -membertype NoteProperty -Value "$($result.ipv6gateway)"
        $Global | add-member -name "Hostname" -membertype NoteProperty -Value "$($result.hostname_local)"
        $Global | add-member -name "Nameserver1" -membertype NoteProperty -Value "$($result.nameserver1)"
        $Global | add-member -name "Nameserver2" -membertype NoteProperty -Value "$($result.nameserver3)"
        $Global | add-member -name "Nameserver3" -membertype NoteProperty -Value "$($result.nameserver3)"
        $Global | add-member -name "Httpproxy" -membertype NoteProperty -Value "$($result.httpproxy)"
        $Global | add-member -name "Netwait Enabled" -membertype NoteProperty -Value "$($result.netwait_enabled)"
        $Global | add-member -name "Netwait IP" -membertype NoteProperty -Value "$($result.netwait_ip)"
        $Global | add-member -name "Hosts" -membertype NoteProperty -Value "$($result.hosts)"
        return $Global
    }
}
