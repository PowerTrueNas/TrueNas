class TrueNasconfig :TrueNasConfiguration
    {
        [String]$CommonName
        [String]$Uri
        [PSobject]$Params

        TrueNasconfig([TrueNasConfiguration]$param):base()
    {
    }
    [object]postconfigreset([psobject]$Body)
                    {
                                $reponse = .TrueNasRestMethod("config/reset" , "POST", $Body)
                                return $reponse
                    }
}
