class TrueNasjail :TrueNasConfiguration
    {
        [String]$CommonName
        [String]$Uri
        [PSobject]$Params

        TrueNasjail([TrueNasConfiguration]$param):base()
    {
    }
    [object]postjail([psobject]$Body)
                    {
                                $reponse = .TrueNasRestMethod("jail" , "POST", $Body)
                                return $reponse
                    }
    [object]getjail()
                    {
                                $reponse = .TrueNasRestMethod("jail" , "GET")
                                return $reponse
                    }
    [object]postjailactivate([psobject]$Body)
                    {
                                $reponse = .TrueNasRestMethod("jail/activate" , "POST", $Body)
                                return $reponse
                    }
    [object]postjailclean([psobject]$Body)
                    {
                                $reponse = .TrueNasRestMethod("jail/clean" , "POST", $Body)
                                return $reponse
                    }
    [object]getjaildefault_configuration()
                    {
                                $reponse = .TrueNasRestMethod("jail/default_configuration" , "GET")
                                return $reponse
                    }
    [object]postjailexec([psobject]$Body)
                    {
                                $reponse = .TrueNasRestMethod("jail/exec" , "POST", $Body)
                                return $reponse
                    }
    [object]postjailexport([psobject]$Body)
                    {
                                $reponse = .TrueNasRestMethod("jail/export" , "POST", $Body)
                                return $reponse
                    }
    [object]postjailfetch([psobject]$Body)
                    {
                                $reponse = .TrueNasRestMethod("jail/fetch" , "POST", $Body)
                                return $reponse
                    }
    [object]postjailfstab([psobject]$Body)
                    {
                                $reponse = .TrueNasRestMethod("jail/fstab" , "POST", $Body)
                                return $reponse
                    }
    [object]getjailget_activated_pool()
                    {
                                $reponse = .TrueNasRestMethod("jail/get_activated_pool" , "GET")
                                return $reponse
                    }
    [object]getjailget_instance()
                    {
                                $reponse = .TrueNasRestMethod("jail/get_instance" , "GET")
                                return $reponse
                    }
    [object]postjailimport_image([psobject]$Body)
                    {
                                $reponse = .TrueNasRestMethod("jail/import_image" , "POST", $Body)
                                return $reponse
                    }
    [object]getjailinterface_choices()
                    {
                                $reponse = .TrueNasRestMethod("jail/interface_choices" , "GET")
                                return $reponse
                    }
    [object]postjailrc_action([psobject]$Body)
                    {
                                $reponse = .TrueNasRestMethod("jail/rc_action" , "POST", $Body)
                                return $reponse
                    }
    [object]postjailreleases_choices([psobject]$Body)
                    {
                                $reponse = .TrueNasRestMethod("jail/releases_choices" , "POST", $Body)
                                return $reponse
                    }
    [object]postjailrestart([psobject]$Body)
                    {
                                $reponse = .TrueNasRestMethod("jail/restart" , "POST", $Body)
                                return $reponse
                    }
    [object]postjailstart([psobject]$Body)
                    {
                                $reponse = .TrueNasRestMethod("jail/start" , "POST", $Body)
                                return $reponse
                    }
    [object]postjailstop([psobject]$Body)
                    {
                                $reponse = .TrueNasRestMethod("jail/stop" , "POST", $Body)
                                return $reponse
                    }
    [object]postjailupdate_defaults([psobject]$Body)
                    {
                                $reponse = .TrueNasRestMethod("jail/update_defaults" , "POST", $Body)
                                return $reponse
                    }
    [object]postjailupdate_to_latest_patch([psobject]$Body)
                    {
                                $reponse = .TrueNasRestMethod("jail/update_to_latest_patch" , "POST", $Body)
                                return $reponse
                    }
}
