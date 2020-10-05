class TrueNasvm :TrueNasConfiguration
    {
        [String]$CommonName
        [String]$Uri
        [PSobject]$Params

        TrueNasvm([TrueNasConfiguration]$param):base()
    {
    }
    [object]postvm([psobject]$Body)
                    {
                                $reponse = .TrueNasRestMethod("vm" , "POST", $Body)
                                return $reponse
                    }
    [object]getvm()
                    {
                                $reponse = .TrueNasRestMethod("vm" , "GET")
                                return $reponse
                    }
    [object]postvmdevice([psobject]$Body)
                    {
                                $reponse = .TrueNasRestMethod("vm/device" , "POST", $Body)
                                return $reponse
                    }
    [object]getvmdevice()
                    {
                                $reponse = .TrueNasRestMethod("vm/device" , "GET")
                                return $reponse
                    }
    [object]getvmdeviceget_instance()
                    {
                                $reponse = .TrueNasRestMethod("vm/device/get_instance" , "GET")
                                return $reponse
                    }
    [object]getvmdevicenic_attach_choices()
                    {
                                $reponse = .TrueNasRestMethod("vm/device/nic_attach_choices" , "GET")
                                return $reponse
                    }
    [object]getvmdevicepptdev_choices()
                    {
                                $reponse = .TrueNasRestMethod("vm/device/pptdev_choices" , "GET")
                                return $reponse
                    }
    [object]getvmdevicevnc_bind_choices()
                    {
                                $reponse = .TrueNasRestMethod("vm/device/vnc_bind_choices" , "GET")
                                return $reponse
                    }
    [object]getvmflags()
                    {
                                $reponse = .TrueNasRestMethod("vm/flags" , "GET")
                                return $reponse
                    }
    [object]postvmget_attached_iface([psobject]$Body)
                    {
                                $reponse = .TrueNasRestMethod("vm/get_attached_iface" , "POST", $Body)
                                return $reponse
                    }
    [object]postvmget_available_memory([psobject]$Body)
                    {
                                $reponse = .TrueNasRestMethod("vm/get_available_memory" , "POST", $Body)
                                return $reponse
                    }
    [object]postvmget_console([psobject]$Body)
                    {
                                $reponse = .TrueNasRestMethod("vm/get_console" , "POST", $Body)
                                return $reponse
                    }
    [object]getvmget_instance()
                    {
                                $reponse = .TrueNasRestMethod("vm/get_instance" , "GET")
                                return $reponse
                    }
    [object]getvmget_vmemory_in_use()
                    {
                                $reponse = .TrueNasRestMethod("vm/get_vmemory_in_use" , "GET")
                                return $reponse
                    }
    [object]postvmget_vnc([psobject]$Body)
                    {
                                $reponse = .TrueNasRestMethod("vm/get_vnc" , "POST", $Body)
                                return $reponse
                    }
    [object]getvmget_vnc_ipv4()
                    {
                                $reponse = .TrueNasRestMethod("vm/get_vnc_ipv4" , "GET")
                                return $reponse
                    }
    [object]getvmidentify_hypervisor()
                    {
                                $reponse = .TrueNasRestMethod("vm/identify_hypervisor" , "GET")
                                return $reponse
                    }
    [object]getvmrandom_mac()
                    {
                                $reponse = .TrueNasRestMethod("vm/random_mac" , "GET")
                                return $reponse
                    }
    [object]getvmvnc_port_wizard()
                    {
                                $reponse = .TrueNasRestMethod("vm/vnc_port_wizard" , "GET")
                                return $reponse
                    }
}
