class TrueNassupport :TrueNasConfiguration
    {
        [String]$CommonName
        [String]$Uri
        [PSobject]$Params

        TrueNassupport([TrueNasConfiguration]$param):base()
    {
    }
    [object]putsupport([psobject]$Body)
                    {
                                $reponse = .TrueNasRestMethod("support" , "PUT", $Body)
                                return $reponse
                    }
    [object]getsupport()
                    {
                                $reponse = .TrueNasRestMethod("support" , "GET")
                                return $reponse
                    }
    [object]postsupportfetch_categories([psobject]$Body)
                    {
                                $reponse = .TrueNasRestMethod("support/fetch_categories" , "POST", $Body)
                                return $reponse
                    }
    [object]getsupportfields()
                    {
                                $reponse = .TrueNasRestMethod("support/fields" , "GET")
                                return $reponse
                    }
    [object]getsupportis_available()
                    {
                                $reponse = .TrueNasRestMethod("support/is_available" , "GET")
                                return $reponse
                    }
    [object]getsupportis_available_and_enabled()
                    {
                                $reponse = .TrueNasRestMethod("support/is_available_and_enabled" , "GET")
                                return $reponse
                    }
    [object]postsupportnew_ticket([psobject]$Body)
                    {
                                $reponse = .TrueNasRestMethod("support/new_ticket" , "POST", $Body)
                                return $reponse
                    }
}
