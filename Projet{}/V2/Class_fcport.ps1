class TrueNasfcport :TrueNasConfiguration
    {
        [String]$CommonName
        [String]$Uri
        [PSobject]$Params

        TrueNasfcport([TrueNasConfiguration]$param):base()
    {
    }
    [object]getfcport()
                    {
                                $reponse = .TrueNasRestMethod("fcport" , "GET")
                                return $reponse
                    }
    [object]getfcportget_instance()
                    {
                                $reponse = .TrueNasRestMethod("fcport/get_instance" , "GET")
                                return $reponse
                    }
}
