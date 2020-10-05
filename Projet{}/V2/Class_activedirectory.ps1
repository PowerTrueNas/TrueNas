class TrueNasactivedirectory :TrueNasConfiguration
    {
        [String]$CommonName
        [String]$Uri
        [PSobject]$Params

        TrueNasactivedirectory([TrueNasConfiguration]$param):base()
    {
    }
    [object]putactivedirectory([psobject]$Body)
                    {
                                $reponse = .TrueNasRestMethod("activedirectory" , "PUT", $Body)
                                return $reponse
                    }
    [object]getactivedirectory()
                    {
                                $reponse = .TrueNasRestMethod("activedirectory" , "GET")
                                return $reponse
                    }
    [object]getactivedirectorychange_trust_account_pw()
                    {
                                $reponse = .TrueNasRestMethod("activedirectory/change_trust_account_pw" , "GET")
                                return $reponse
                    }
    [object]getactivedirectorydomain_info()
                    {
                                $reponse = .TrueNasRestMethod("activedirectory/domain_info" , "GET")
                                return $reponse
                    }
    [object]getactivedirectoryget_spn_list()
                    {
                                $reponse = .TrueNasRestMethod("activedirectory/get_spn_list" , "GET")
                                return $reponse
                    }
    [object]getactivedirectoryget_state()
                    {
                                $reponse = .TrueNasRestMethod("activedirectory/get_state" , "GET")
                                return $reponse
                    }
    [object]postactivedirectoryleave([psobject]$Body)
                    {
                                $reponse = .TrueNasRestMethod("activedirectory/leave" , "POST", $Body)
                                return $reponse
                    }
    [object]getactivedirectorynss_info_choices()
                    {
                                $reponse = .TrueNasRestMethod("activedirectory/nss_info_choices" , "GET")
                                return $reponse
                    }
    [object]getactivedirectorysasl_wrapping_choices()
                    {
                                $reponse = .TrueNasRestMethod("activedirectory/sasl_wrapping_choices" , "GET")
                                return $reponse
                    }
    [object]getactivedirectoryssl_choices()
                    {
                                $reponse = .TrueNasRestMethod("activedirectory/ssl_choices" , "GET")
                                return $reponse
                    }
    [object]getactivedirectorystarted()
                    {
                                $reponse = .TrueNasRestMethod("activedirectory/started" , "GET")
                                return $reponse
                    }
}
