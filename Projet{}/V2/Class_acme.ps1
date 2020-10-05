class TrueNasacme :TrueNasConfiguration
    {
        [String]$CommonName
        [String]$Uri
        [PSobject]$Params

        TrueNasacme([TrueNasConfiguration]$param):base()
    {
    }
    [object]postacmednsauthenticator([psobject]$Body)
                    {
                                $reponse = .TrueNasRestMethod("acme/dns/authenticator" , "POST", $Body)
                                return $reponse
                    }
    [object]getacmednsauthenticator()
                    {
                                $reponse = .TrueNasRestMethod("acme/dns/authenticator" , "GET")
                                return $reponse
                    }
    [object]getacmednsauthenticatorauthenticator_schemas()
                    {
                                $reponse = .TrueNasRestMethod("acme/dns/authenticator/authenticator_schemas" , "GET")
                                return $reponse
                    }
    [object]getacmednsauthenticatorget_instance()
                    {
                                $reponse = .TrueNasRestMethod("acme/dns/authenticator/get_instance" , "GET")
                                return $reponse
                    }
}
