class TrueNasapi_key :TrueNasConfiguration
    {
        [String]$CommonName
        [String]$Uri
        [PSobject]$Params

        TrueNasapi_key([TrueNasConfiguration]$param):base()
    {
    }
    [object]postapi_key([psobject]$Body)
                    {
                                $reponse = .TrueNasRestMethod("api_key" , "POST", $Body)
                                return $reponse
                    }
    [object]getapi_key()
                    {
                                $reponse = .TrueNasRestMethod("api_key" , "GET")
                                return $reponse
                    }
    [object]getapi_keyget_instance()
                    {
                                $reponse = .TrueNasRestMethod("api_key/get_instance" , "GET")
                                return $reponse
                    }
}
