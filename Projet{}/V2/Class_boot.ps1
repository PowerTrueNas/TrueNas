class TrueNasboot :TrueNasConfiguration
    {
        [String]$CommonName
        [String]$Uri
        [PSobject]$Params

        TrueNasboot([TrueNasConfiguration]$param):base()
    {
    }
    [object]postbootattach([psobject]$Body)
                    {
                                $reponse = .TrueNasRestMethod("boot/attach" , "POST", $Body)
                                return $reponse
                    }
    [object]postbootdetach([psobject]$Body)
                    {
                                $reponse = .TrueNasRestMethod("boot/detach" , "POST", $Body)
                                return $reponse
                    }
    [object]getbootget_disks()
                    {
                                $reponse = .TrueNasRestMethod("boot/get_disks" , "GET")
                                return $reponse
                    }
    [object]getbootget_scrub_interval()
                    {
                                $reponse = .TrueNasRestMethod("boot/get_scrub_interval" , "GET")
                                return $reponse
                    }
    [object]getbootget_state()
                    {
                                $reponse = .TrueNasRestMethod("boot/get_state" , "GET")
                                return $reponse
                    }
    [object]postbootreplace([psobject]$Body)
                    {
                                $reponse = .TrueNasRestMethod("boot/replace" , "POST", $Body)
                                return $reponse
                    }
    [object]getbootscrub()
                    {
                                $reponse = .TrueNasRestMethod("boot/scrub" , "GET")
                                return $reponse
                    }
    [object]postbootset_scrub_interval([psobject]$Body)
                    {
                                $reponse = .TrueNasRestMethod("boot/set_scrub_interval" , "POST", $Body)
                                return $reponse
                    }
}
