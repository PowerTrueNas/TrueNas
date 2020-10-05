class TrueNasipmi :TrueNasConfiguration
    {
        [String]$CommonName
        [String]$Uri
        [PSobject]$Params

        TrueNasipmi([TrueNasConfiguration]$param):base()
    {
    }
    [object]getipmi()
                    {
                                $reponse = .TrueNasRestMethod("ipmi" , "GET")
                                return $reponse
                    }
    [object]getipmichannels()
                    {
                                $reponse = .TrueNasRestMethod("ipmi/channels" , "GET")
                                return $reponse
                    }
    [object]getipmiget_instance()
                    {
                                $reponse = .TrueNasRestMethod("ipmi/get_instance" , "GET")
                                return $reponse
                    }
    [object]postipmiidentify([psobject]$Body)
                    {
                                $reponse = .TrueNasRestMethod("ipmi/identify" , "POST", $Body)
                                return $reponse
                    }
    [object]getipmiis_loaded()
                    {
                                $reponse = .TrueNasRestMethod("ipmi/is_loaded" , "GET")
                                return $reponse
                    }
}
