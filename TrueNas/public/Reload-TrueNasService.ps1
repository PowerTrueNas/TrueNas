function Restart-TrueNasService
{
    Param
    (
        [Parameter (Mandatory = $true)]
        [ValidateSet("afp", "cifs", "dynamicdns", "ftp", "iscsitarget", "nfs", "snmp", "ssh", "tftp", "ups", "rsync", "smartd", "lldp", "webdav", "s3", "openvpn_client", "openvpn_server")]
        [String]$Service
    )

    Begin
    {

    }
    Process
    {
        $Uri = "api/v2.0/service/reload"
        $Obj = [Ordered]@{

            service           = $Service
            'service-control' = @{
                ha_propagate = $true
            }
        }
        $result = Invoke-TrueNasRestMethod -Method Post -body $Obj -Uri $uri
    }
    End
    {
        $result
    }
}
