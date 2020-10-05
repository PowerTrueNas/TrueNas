class TrueNasopenvpn :TrueNasConfiguration
    {
        [String]$CommonName
        [String]$Uri
        [PSobject]$Params

        TrueNasopenvpn([TrueNasConfiguration]$param):base()
    {
    }
    [object]putopenvpnclient([psobject]$Body)
                    {
                                $reponse = .TrueNasRestMethod("openvpn/client" , "PUT", $Body)
                                return $reponse
                    }
    [object]getopenvpnclient()
                    {
                                $reponse = .TrueNasRestMethod("openvpn/client" , "GET")
                                return $reponse
                    }
    [object]getopenvpnclientauthentication_algorithm_choices()
                    {
                                $reponse = .TrueNasRestMethod("openvpn/client/authentication_algorithm_choices" , "GET")
                                return $reponse
                    }
    [object]getopenvpnclientcipher_choices()
                    {
                                $reponse = .TrueNasRestMethod("openvpn/client/cipher_choices" , "GET")
                                return $reponse
                    }
    [object]putopenvpnserver([psobject]$Body)
                    {
                                $reponse = .TrueNasRestMethod("openvpn/server" , "PUT", $Body)
                                return $reponse
                    }
    [object]getopenvpnserver()
                    {
                                $reponse = .TrueNasRestMethod("openvpn/server" , "GET")
                                return $reponse
                    }
    [object]getopenvpnserverauthentication_algorithm_choices()
                    {
                                $reponse = .TrueNasRestMethod("openvpn/server/authentication_algorithm_choices" , "GET")
                                return $reponse
                    }
    [object]getopenvpnservercipher_choices()
                    {
                                $reponse = .TrueNasRestMethod("openvpn/server/cipher_choices" , "GET")
                                return $reponse
                    }
    [object]postopenvpnserverclient_configuration_generation([psobject]$Body)
                    {
                                $reponse = .TrueNasRestMethod("openvpn/server/client_configuration_generation" , "POST", $Body)
                                return $reponse
                    }
    [object]getopenvpnserverrenew_static_key()
                    {
                                $reponse = .TrueNasRestMethod("openvpn/server/renew_static_key" , "GET")
                                return $reponse
                    }
}
