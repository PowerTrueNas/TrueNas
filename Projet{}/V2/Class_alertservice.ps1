class TrueNasalertservice :TrueNasConfiguration
    {
        [String]$CommonName
        [String]$Uri
        [PSobject]$Params

        TrueNasalertservice([TrueNasConfiguration]$param):base()
    {
    }
    [object]postalertservice([psobject]$Body)
                    {
                                $reponse = .TrueNasRestMethod("alertservice" , "POST", $Body)
                                return $reponse
                    }
    [object]getalertservice()
                    {
                                $reponse = .TrueNasRestMethod("alertservice" , "GET")
                                return $reponse
                    }
    [object]getalertserviceget_instance()
                    {
                                $reponse = .TrueNasRestMethod("alertservice/get_instance" , "GET")
                                return $reponse
                    }
    [object]getalertservicelist_types()
                    {
                                $reponse = .TrueNasRestMethod("alertservice/list_types" , "GET")
                                return $reponse
                    }
    [object]postalertservicetest([psobject]$Body)
                    {
                                $reponse = .TrueNasRestMethod("alertservice/test" , "POST", $Body)
                                return $reponse
                    }
}
