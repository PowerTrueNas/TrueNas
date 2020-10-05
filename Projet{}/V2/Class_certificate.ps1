class TrueNascertificate :TrueNasConfiguration
    {
        [String]$CommonName
        [String]$Uri
        [PSobject]$Params

        TrueNascertificate([TrueNasConfiguration]$param):base()
    {
    }
    [object]postcertificate([psobject]$Body)
                    {
                                $reponse = .TrueNasRestMethod("certificate" , "POST", $Body)
                                return $reponse
                    }
    [object]getcertificate()
                    {
                                $reponse = .TrueNasRestMethod("certificate" , "GET")
                                return $reponse
                    }
    [object]getcertificateacme_server_choices()
                    {
                                $reponse = .TrueNasRestMethod("certificate/acme_server_choices" , "GET")
                                return $reponse
                    }
    [object]getcertificatecountry_choices()
                    {
                                $reponse = .TrueNasRestMethod("certificate/country_choices" , "GET")
                                return $reponse
                    }
    [object]getcertificateec_curve_choices()
                    {
                                $reponse = .TrueNasRestMethod("certificate/ec_curve_choices" , "GET")
                                return $reponse
                    }
    [object]getcertificateextended_key_usage_choices()
                    {
                                $reponse = .TrueNasRestMethod("certificate/extended_key_usage_choices" , "GET")
                                return $reponse
                    }
    [object]getcertificateget_instance()
                    {
                                $reponse = .TrueNasRestMethod("certificate/get_instance" , "GET")
                                return $reponse
                    }
    [object]getcertificatekey_type_choices()
                    {
                                $reponse = .TrueNasRestMethod("certificate/key_type_choices" , "GET")
                                return $reponse
                    }
    [object]getcertificateprofiles()
                    {
                                $reponse = .TrueNasRestMethod("certificate/profiles" , "GET")
                                return $reponse
                    }
}
