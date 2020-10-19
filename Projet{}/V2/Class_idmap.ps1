class TrueNasidmap :TrueNasConfiguration
    {
        [String]$CommonName
        [String]$Uri
        [PSobject]$Params

        TrueNasidmap([TrueNasConfiguration]$param):base()
    {
    }
    [object]postidmap([psobject]$Body)
                    {
                                $reponse = .TrueNasRestMethod("idmap" , "POST", $Body)
                                return $reponse
                    }
    [object]getidmap()
                    {
                                $reponse = .TrueNasRestMethod("idmap" , "GET")
                                return $reponse
                    }
    [object]getidmapbackend_choices()
                    {
                                $reponse = .TrueNasRestMethod("idmap/backend_choices" , "GET")
                                return $reponse
                    }
    [object]getidmapbackend_options()
                    {
                                $reponse = .TrueNasRestMethod("idmap/backend_options" , "GET")
                                return $reponse
                    }
    [object]getidmapclear_idmap_cache()
                    {
                                $reponse = .TrueNasRestMethod("idmap/clear_idmap_cache" , "GET")
                                return $reponse
                    }
    [object]getidmapget_instance()
                    {
                                $reponse = .TrueNasRestMethod("idmap/get_instance" , "GET")
                                return $reponse
                    }
    [object]postidmapoptions_choices([psobject]$Body)
                    {
                                $reponse = .TrueNasRestMethod("idmap/options_choices" , "POST", $Body)
                                return $reponse
                    }
}
