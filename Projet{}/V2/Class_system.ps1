class TrueNassystem :TrueNasConfiguration
    {
        [String]$CommonName
        [String]$Uri
        [PSobject]$Params

        TrueNassystem([TrueNasConfiguration]$param):base()
    {
    }
    [object]putsystemadvanced([psobject]$Body)
                    {
                                $reponse = .TrueNasRestMethod("system/advanced" , "PUT", $Body)
                                return $reponse
                    }
    [object]getsystemadvanced()
                    {
                                $reponse = .TrueNasRestMethod("system/advanced" , "GET")
                                return $reponse
                    }
    [object]getsystemadvancedsed_global_password()
                    {
                                $reponse = .TrueNasRestMethod("system/advanced/sed_global_password" , "GET")
                                return $reponse
                    }
    [object]getsystemadvancedserial_port_choices()
                    {
                                $reponse = .TrueNasRestMethod("system/advanced/serial_port_choices" , "GET")
                                return $reponse
                    }
    [object]getsystemboot_id()
                    {
                                $reponse = .TrueNasRestMethod("system/boot_id" , "GET")
                                return $reponse
                    }
    [object]getsystemenvironment()
                    {
                                $reponse = .TrueNasRestMethod("system/environment" , "GET")
                                return $reponse
                    }
    [object]postsystemfeature_enabled([psobject]$Body)
                    {
                                $reponse = .TrueNasRestMethod("system/feature_enabled" , "POST", $Body)
                                return $reponse
                    }
    [object]putsystemgeneral([psobject]$Body)
                    {
                                $reponse = .TrueNasRestMethod("system/general" , "PUT", $Body)
                                return $reponse
                    }
    [object]getsystemgeneral()
                    {
                                $reponse = .TrueNasRestMethod("system/general" , "GET")
                                return $reponse
                    }
    [object]getsystemgeneralcountry_choices()
                    {
                                $reponse = .TrueNasRestMethod("system/general/country_choices" , "GET")
                                return $reponse
                    }
    [object]getsystemgeneralkbdmap_choices()
                    {
                                $reponse = .TrueNasRestMethod("system/general/kbdmap_choices" , "GET")
                                return $reponse
                    }
    [object]getsystemgenerallanguage_choices()
                    {
                                $reponse = .TrueNasRestMethod("system/general/language_choices" , "GET")
                                return $reponse
                    }
    [object]getsystemgenerallocal_url()
                    {
                                $reponse = .TrueNasRestMethod("system/general/local_url" , "GET")
                                return $reponse
                    }
    [object]getsystemgeneraltimezone_choices()
                    {
                                $reponse = .TrueNasRestMethod("system/general/timezone_choices" , "GET")
                                return $reponse
                    }
    [object]getsystemgeneralui_address_choices()
                    {
                                $reponse = .TrueNasRestMethod("system/general/ui_address_choices" , "GET")
                                return $reponse
                    }
    [object]getsystemgeneralui_certificate_choices()
                    {
                                $reponse = .TrueNasRestMethod("system/general/ui_certificate_choices" , "GET")
                                return $reponse
                    }
    [object]getsystemgeneralui_httpsprotocols_choices()
                    {
                                $reponse = .TrueNasRestMethod("system/general/ui_httpsprotocols_choices" , "GET")
                                return $reponse
                    }
    [object]getsystemgeneralui_restart()
                    {
                                $reponse = .TrueNasRestMethod("system/general/ui_restart" , "GET")
                                return $reponse
                    }
    [object]getsystemgeneralui_v6address_choices()
                    {
                                $reponse = .TrueNasRestMethod("system/general/ui_v6address_choices" , "GET")
                                return $reponse
                    }
    [object]getsysteminfo()
                    {
                                $reponse = .TrueNasRestMethod("system/info" , "GET")
                                return $reponse
                    }
    [object]getsystemis_freenas()
                    {
                                $reponse = .TrueNasRestMethod("system/is_freenas" , "GET")
                                return $reponse
                    }
    [object]postsystemlicense_update([psobject]$Body)
                    {
                                $reponse = .TrueNasRestMethod("system/license_update" , "POST", $Body)
                                return $reponse
                    }
    [object]postsystemntpserver([psobject]$Body)
                    {
                                $reponse = .TrueNasRestMethod("system/ntpserver" , "POST", $Body)
                                return $reponse
                    }
    [object]getsystemntpserver()
                    {
                                $reponse = .TrueNasRestMethod("system/ntpserver" , "GET")
                                return $reponse
                    }
    [object]getsystemntpserverget_instance()
                    {
                                $reponse = .TrueNasRestMethod("system/ntpserver/get_instance" , "GET")
                                return $reponse
                    }
    [object]getsystemntpservertest_ntp_server()
                    {
                                $reponse = .TrueNasRestMethod("system/ntpserver/test_ntp_server" , "GET")
                                return $reponse
                    }
    [object]getsystemproduct_name()
                    {
                                $reponse = .TrueNasRestMethod("system/product_name" , "GET")
                                return $reponse
                    }
    [object]getsystemproduct_type()
                    {
                                $reponse = .TrueNasRestMethod("system/product_type" , "GET")
                                return $reponse
                    }
    [object]getsystemready()
                    {
                                $reponse = .TrueNasRestMethod("system/ready" , "GET")
                                return $reponse
                    }
    [object]postsystemreboot([psobject]$Body)
                    {
                                $reponse = .TrueNasRestMethod("system/reboot" , "POST", $Body)
                                return $reponse
                    }
    [object]postsystemshutdown([psobject]$Body)
                    {
                                $reponse = .TrueNasRestMethod("system/shutdown" , "POST", $Body)
                                return $reponse
                    }
    [object]getsystemstate()
                    {
                                $reponse = .TrueNasRestMethod("system/state" , "GET")
                                return $reponse
                    }
    [object]getsystemversion()
                    {
                                $reponse = .TrueNasRestMethod("system/version" , "GET")
                                return $reponse
                    }
}
