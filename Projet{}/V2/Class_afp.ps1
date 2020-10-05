class TrueNasafp :TrueNasConfiguration
    {
        [String]$CommonName
        [String]$Uri
        [PSobject]$Params

        TrueNasafp([TrueNasConfiguration]$param):base()
    {
    }
    [object]putafp([psobject]$Body)
                    {
                                $reponse = .TrueNasRestMethod("afp" , "PUT", $Body)
                                return $reponse
                    }
    [object]getafp()
                    {
                                $reponse = .TrueNasRestMethod("afp" , "GET")
                                return $reponse
                    }
    [object]getafpbindip_choices()
                    {
                                $reponse = .TrueNasRestMethod("afp/bindip_choices" , "GET")
                                return $reponse
                    }
}
