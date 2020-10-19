class TrueNasreporting :TrueNasConfiguration
    {
        [String]$CommonName
        [String]$Uri
        [PSobject]$Params

        TrueNasreporting([TrueNasConfiguration]$param):base()
    {
    }
    [object]putreporting([psobject]$Body)
                    {
                                $reponse = .TrueNasRestMethod("reporting" , "PUT", $Body)
                                return $reponse
                    }
    [object]getreporting()
                    {
                                $reponse = .TrueNasRestMethod("reporting" , "GET")
                                return $reponse
                    }
    [object]postreportingget_data([psobject]$Body)
                    {
                                $reponse = .TrueNasRestMethod("reporting/get_data" , "POST", $Body)
                                return $reponse
                    }
    [object]getreportinggraphs()
                    {
                                $reponse = .TrueNasRestMethod("reporting/graphs" , "GET")
                                return $reponse
                    }
}
