class TrueNasauth :TrueNasConfiguration
    {
        [String]$CommonName
        [String]$Uri
        [PSobject]$Params

        TrueNasauth([TrueNasConfiguration]$param):base()
    {
    }
    [object]postauthcheck_user([psobject]$Body)
                    {
                                $reponse = .TrueNasRestMethod("auth/check_user" , "POST", $Body)
                                return $reponse
                    }
    [object]postauthgenerate_token([psobject]$Body)
                    {
                                $reponse = .TrueNasRestMethod("auth/generate_token" , "POST", $Body)
                                return $reponse
                    }
    [object]getauthsessions()
                    {
                                $reponse = .TrueNasRestMethod("auth/sessions" , "GET")
                                return $reponse
                    }
    [object]getauthtwo_factor_auth()
                    {
                                $reponse = .TrueNasRestMethod("auth/two_factor_auth" , "GET")
                                return $reponse
                    }
    [object]putauthtwofactor([psobject]$Body)
                    {
                                $reponse = .TrueNasRestMethod("auth/twofactor" , "PUT", $Body)
                                return $reponse
                    }
    [object]getauthtwofactor()
                    {
                                $reponse = .TrueNasRestMethod("auth/twofactor" , "GET")
                                return $reponse
                    }
    [object]getauthtwofactorprovisioning_uri()
                    {
                                $reponse = .TrueNasRestMethod("auth/twofactor/provisioning_uri" , "GET")
                                return $reponse
                    }
    [object]getauthtwofactorrenew_secret()
                    {
                                $reponse = .TrueNasRestMethod("auth/twofactor/renew_secret" , "GET")
                                return $reponse
                    }
    [object]postauthtwofactorverify([psobject]$Body)
                    {
                                $reponse = .TrueNasRestMethod("auth/twofactor/verify" , "POST", $Body)
                                return $reponse
                    }
}
