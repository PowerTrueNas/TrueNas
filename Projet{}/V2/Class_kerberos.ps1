class TrueNaskerberos :TrueNasConfiguration
    {
        [String]$CommonName
        [String]$Uri
        [PSobject]$Params

        TrueNaskerberos([TrueNasConfiguration]$param):base()
    {
    }
    [object]putkerberos([psobject]$Body)
                    {
                                $reponse = .TrueNasRestMethod("kerberos" , "PUT", $Body)
                                return $reponse
                    }
    [object]getkerberos()
                    {
                                $reponse = .TrueNasRestMethod("kerberos" , "GET")
                                return $reponse
                    }
    [object]postkerberoskeytab([psobject]$Body)
                    {
                                $reponse = .TrueNasRestMethod("kerberos/keytab" , "POST", $Body)
                                return $reponse
                    }
    [object]getkerberoskeytab()
                    {
                                $reponse = .TrueNasRestMethod("kerberos/keytab" , "GET")
                                return $reponse
                    }
    [object]getkerberoskeytabget_instance()
                    {
                                $reponse = .TrueNasRestMethod("kerberos/keytab/get_instance" , "GET")
                                return $reponse
                    }
    [object]getkerberoskeytabsystem_keytab_list()
                    {
                                $reponse = .TrueNasRestMethod("kerberos/keytab/system_keytab_list" , "GET")
                                return $reponse
                    }
    [object]postkerberosrealm([psobject]$Body)
                    {
                                $reponse = .TrueNasRestMethod("kerberos/realm" , "POST", $Body)
                                return $reponse
                    }
    [object]getkerberosrealm()
                    {
                                $reponse = .TrueNasRestMethod("kerberos/realm" , "GET")
                                return $reponse
                    }
    [object]getkerberosrealmget_instance()
                    {
                                $reponse = .TrueNasRestMethod("kerberos/realm/get_instance" , "GET")
                                return $reponse
                    }
}
