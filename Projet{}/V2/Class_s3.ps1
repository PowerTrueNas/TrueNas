class TrueNass3 :TrueNasConfiguration
    {
        [String]$CommonName
        [String]$Uri
        [PSobject]$Params

        TrueNass3([TrueNasConfiguration]$param):base()
    {
    }
    [object]puts3([psobject]$Body)
                    {
                                $reponse = .TrueNasRestMethod("s3" , "PUT", $Body)
                                return $reponse
                    }
    [object]gets3()
                    {
                                $reponse = .TrueNasRestMethod("s3" , "GET")
                                return $reponse
                    }
    [object]gets3bindip_choices()
                    {
                                $reponse = .TrueNasRestMethod("s3/bindip_choices" , "GET")
                                return $reponse
                    }
}
