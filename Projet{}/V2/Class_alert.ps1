class TrueNasalert :TrueNasConfiguration
    {
        [String]$CommonName
        [String]$Uri
        [PSobject]$Params

        TrueNasalert([TrueNasConfiguration]$param):base()
    {
    }
    [object]postalertdismiss([psobject]$Body)
                    {
                                $reponse = .TrueNasRestMethod("alert/dismiss" , "POST", $Body)
                                return $reponse
                    }
    [object]getalertlist()
                    {
                                $reponse = .TrueNasRestMethod("alert/list" , "GET")
                                return $reponse
                    }
    [object]getalertlist_categories()
                    {
                                $reponse = .TrueNasRestMethod("alert/list_categories" , "GET")
                                return $reponse
                    }
    [object]getalertlist_policies()
                    {
                                $reponse = .TrueNasRestMethod("alert/list_policies" , "GET")
                                return $reponse
                    }
    [object]postalertrestore([psobject]$Body)
                    {
                                $reponse = .TrueNasRestMethod("alert/restore" , "POST", $Body)
                                return $reponse
                    }
}
