class TrueNastruenas :TrueNasConfiguration
    {
        [String]$CommonName
        [String]$Uri
        [PSobject]$Params

        TrueNastruenas([TrueNasConfiguration]$param):base()
    {
    }
    [object]gettruenasaccept_eula()
                    {
                                $reponse = .TrueNasRestMethod("truenas/accept_eula" , "GET")
                                return $reponse
                    }
    [object]gettruenasget_chassis_hardware()
                    {
                                $reponse = .TrueNasRestMethod("truenas/get_chassis_hardware" , "GET")
                                return $reponse
                    }
    [object]gettruenasget_customer_information()
                    {
                                $reponse = .TrueNasRestMethod("truenas/get_customer_information" , "GET")
                                return $reponse
                    }
    [object]gettruenasget_eula()
                    {
                                $reponse = .TrueNasRestMethod("truenas/get_eula" , "GET")
                                return $reponse
                    }
    [object]gettruenasis_eula_accepted()
                    {
                                $reponse = .TrueNasRestMethod("truenas/is_eula_accepted" , "GET")
                                return $reponse
                    }
    [object]gettruenasis_production()
                    {
                                $reponse = .TrueNasRestMethod("truenas/is_production" , "GET")
                                return $reponse
                    }
    [object]posttruenasset_production([psobject]$Body)
                    {
                                $reponse = .TrueNasRestMethod("truenas/set_production" , "POST", $Body)
                                return $reponse
                    }
    [object]posttruenasupdate_customer_information([psobject]$Body)
                    {
                                $reponse = .TrueNasRestMethod("truenas/update_customer_information" , "POST", $Body)
                                return $reponse
                    }
}
