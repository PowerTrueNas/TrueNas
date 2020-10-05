class TrueNasldap :TrueNasConfiguration
    {
        [String]$CommonName
        [String]$Uri
        [PSobject]$Params

        TrueNasldap([TrueNasConfiguration]$param):base()
    {
    }
    [object]putldap([psobject]$Body)
                    {
                                $reponse = .TrueNasRestMethod("ldap" , "PUT", $Body)
                                return $reponse
                    }
    [object]getldap()
                    {
                                $reponse = .TrueNasRestMethod("ldap" , "GET")
                                return $reponse
                    }
    [object]getldapget_state()
                    {
                                $reponse = .TrueNasRestMethod("ldap/get_state" , "GET")
                                return $reponse
                    }
    [object]getldapschema_choices()
                    {
                                $reponse = .TrueNasRestMethod("ldap/schema_choices" , "GET")
                                return $reponse
                    }
    [object]getldapssl_choices()
                    {
                                $reponse = .TrueNasRestMethod("ldap/ssl_choices" , "GET")
                                return $reponse
                    }
}
