class TrueNasinitshutdownscript :TrueNasConfiguration
    {
        [String]$CommonName
        [String]$Uri
        [PSobject]$Params

        TrueNasinitshutdownscript([TrueNasConfiguration]$param):base()
    {
    }
    [object]postinitshutdownscript([psobject]$Body)
                    {
                                $reponse = .TrueNasRestMethod("initshutdownscript" , "POST", $Body)
                                return $reponse
                    }
    [object]getinitshutdownscript()
                    {
                                $reponse = .TrueNasRestMethod("initshutdownscript" , "GET")
                                return $reponse
                    }
    [object]getinitshutdownscriptget_instance()
                    {
                                $reponse = .TrueNasRestMethod("initshutdownscript/get_instance" , "GET")
                                return $reponse
                    }
}
