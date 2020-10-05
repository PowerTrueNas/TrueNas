class TrueNasalertclasses :TrueNasConfiguration
    {
        [String]$CommonName
        [String]$Uri
        [PSobject]$Params

        TrueNasalertclasses([TrueNasConfiguration]$param):base()
    {
    }
    [object]putalertclasses([psobject]$Body)
                    {
                                $reponse = .TrueNasRestMethod("alertclasses" , "PUT", $Body)
                                return $reponse
                    }
    [object]getalertclasses()
                    {
                                $reponse = .TrueNasRestMethod("alertclasses" , "GET")
                                return $reponse
                    }
}
