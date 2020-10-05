class TrueNasdirectoryservices :TrueNasConfiguration
    {
        [String]$CommonName
        [String]$Uri
        [PSobject]$Params

        TrueNasdirectoryservices([TrueNasConfiguration]$param):base()
    {
    }
    [object]getdirectoryservicescache_refresh()
                    {
                                $reponse = .TrueNasRestMethod("directoryservices/cache_refresh" , "GET")
                                return $reponse
                    }
    [object]getdirectoryservicesget_state()
                    {
                                $reponse = .TrueNasRestMethod("directoryservices/get_state" , "GET")
                                return $reponse
                    }
}
