class TrueNassensor :TrueNasConfiguration
    {
        [String]$CommonName
        [String]$Uri
        [PSobject]$Params

        TrueNassensor([TrueNasConfiguration]$param):base()
    {
    }
    [object]getsensorquery()
                    {
                                $reponse = .TrueNasRestMethod("sensor/query" , "GET")
                                return $reponse
                    }
}
