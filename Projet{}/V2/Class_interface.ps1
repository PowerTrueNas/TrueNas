class TrueNasinterface :TrueNasConfiguration
    {
        [String]$CommonName
        [String]$Uri
        [PSobject]$Params

        TrueNasinterface([TrueNasConfiguration]$param):base()
    {
    }
    [object]postinterface([psobject]$Body)
                    {
                                $reponse = .TrueNasRestMethod("interface" , "POST", $Body)
                                return $reponse
                    }
    [object]getinterface()
                    {
                                $reponse = .TrueNasRestMethod("interface" , "GET")
                                return $reponse
                    }
    [object]postinterfacebridge_members_choices([psobject]$Body)
                    {
                                $reponse = .TrueNasRestMethod("interface/bridge_members_choices" , "POST", $Body)
                                return $reponse
                    }
    [object]getinterfacebridge_setup()
                    {
                                $reponse = .TrueNasRestMethod("interface/bridge_setup" , "GET")
                                return $reponse
                    }
    [object]getinterfacecheckin()
                    {
                                $reponse = .TrueNasRestMethod("interface/checkin" , "GET")
                                return $reponse
                    }
    [object]getinterfacecheckin_waiting()
                    {
                                $reponse = .TrueNasRestMethod("interface/checkin_waiting" , "GET")
                                return $reponse
                    }
    [object]postinterfacechoices([psobject]$Body)
                    {
                                $reponse = .TrueNasRestMethod("interface/choices" , "POST", $Body)
                                return $reponse
                    }
    [object]postinterfacecommit([psobject]$Body)
                    {
                                $reponse = .TrueNasRestMethod("interface/commit" , "POST", $Body)
                                return $reponse
                    }
    [object]getinterfaceget_instance()
                    {
                                $reponse = .TrueNasRestMethod("interface/get_instance" , "GET")
                                return $reponse
                    }
    [object]getinterfacehas_pending_changes()
                    {
                                $reponse = .TrueNasRestMethod("interface/has_pending_changes" , "GET")
                                return $reponse
                    }
    [object]postinterfaceip_in_use([psobject]$Body)
                    {
                                $reponse = .TrueNasRestMethod("interface/ip_in_use" , "POST", $Body)
                                return $reponse
                    }
    [object]postinterfacelag_ports_choices([psobject]$Body)
                    {
                                $reponse = .TrueNasRestMethod("interface/lag_ports_choices" , "POST", $Body)
                                return $reponse
                    }
    [object]getinterfacelag_setup()
                    {
                                $reponse = .TrueNasRestMethod("interface/lag_setup" , "GET")
                                return $reponse
                    }
    [object]getinterfacerollback()
                    {
                                $reponse = .TrueNasRestMethod("interface/rollback" , "GET")
                                return $reponse
                    }
    [object]getinterfacevlan_parent_interface_choices()
                    {
                                $reponse = .TrueNasRestMethod("interface/vlan_parent_interface_choices" , "GET")
                                return $reponse
                    }
    [object]getinterfacevlan_setup()
                    {
                                $reponse = .TrueNasRestMethod("interface/vlan_setup" , "GET")
                                return $reponse
                    }
}
