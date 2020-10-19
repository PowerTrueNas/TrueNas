class TrueNasstats :TrueNasConfiguration
    {
        [String]$CommonName
        [String]$Uri
        [PSobject]$Params

        TrueNasstats([TrueNasConfiguration]$param):base()
    {
    }
    [object]poststatsget_data([psobject]$Body)
                    {
                                $reponse = .TrueNasRestMethod("stats/get_data" , "POST", $Body)
                                return $reponse
                    }
    [object]poststatsget_dataset_info([psobject]$Body)
                    {
                                $reponse = .TrueNasRestMethod("stats/get_dataset_info" , "POST", $Body)
                                return $reponse
                    }
    [object]getstatsget_sources()
                    {
                                $reponse = .TrueNasRestMethod("stats/get_sources" , "GET")
                                return $reponse
                    }
}
