class TrueNasstaticroute :TrueNasConfiguration
    {
        [String]$CommonName
        [String]$Uri
        [PSobject]$Params

        TrueNasstaticroute([TrueNasConfiguration]$param):base()
    {
    }
    [object]poststaticroute([psobject]$Body)
                    {
                                $reponse = .TrueNasRestMethod("staticroute" , "POST", $Body)
                                return $reponse
                    }
    [object]getstaticroute()
                    {
                                $reponse = .TrueNasRestMethod("staticroute" , "GET")
                                return $reponse
                    }
    [object]getstaticrouteget_instance()
                    {
                                $reponse = .TrueNasRestMethod("staticroute/get_instance" , "GET")
                                return $reponse
                    }
}
