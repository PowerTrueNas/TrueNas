class TrueNasmultipath :TrueNasConfiguration
    {
        [String]$CommonName
        [String]$Uri
        [PSobject]$Params

        TrueNasmultipath([TrueNasConfiguration]$param):base()
    {
    }
    [object]getmultipath()
                    {
                                $reponse = .TrueNasRestMethod("multipath" , "GET")
                                return $reponse
                    }
    [object]getmultipathget_instance()
                    {
                                $reponse = .TrueNasRestMethod("multipath/get_instance" , "GET")
                                return $reponse
                    }
}
