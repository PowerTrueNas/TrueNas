class TrueNassmb :TrueNasConfiguration
    {
        [String]$CommonName
        [String]$Uri
        [PSobject]$Params

        TrueNassmb([TrueNasConfiguration]$param):base()
    {
    }
    [object]putsmb([psobject]$Body)
                    {
                                $reponse = .TrueNasRestMethod("smb" , "PUT", $Body)
                                return $reponse
                    }
    [object]getsmb()
                    {
                                $reponse = .TrueNasRestMethod("smb" , "GET")
                                return $reponse
                    }
    [object]getsmbbindip_choices()
                    {
                                $reponse = .TrueNasRestMethod("smb/bindip_choices" , "GET")
                                return $reponse
                    }
    [object]getsmbdomain_choices()
                    {
                                $reponse = .TrueNasRestMethod("smb/domain_choices" , "GET")
                                return $reponse
                    }
    [object]postsmbget_remote_acl([psobject]$Body)
                    {
                                $reponse = .TrueNasRestMethod("smb/get_remote_acl" , "POST", $Body)
                                return $reponse
                    }
    [object]postsmbsharesec([psobject]$Body)
                    {
                                $reponse = .TrueNasRestMethod("smb/sharesec" , "POST", $Body)
                                return $reponse
                    }
    [object]getsmbsharesec()
                    {
                                $reponse = .TrueNasRestMethod("smb/sharesec" , "GET")
                                return $reponse
                    }
    [object]getsmbsharesecget_instance()
                    {
                                $reponse = .TrueNasRestMethod("smb/sharesec/get_instance" , "GET")
                                return $reponse
                    }
    [object]postsmbsharesecgetacl([psobject]$Body)
                    {
                                $reponse = .TrueNasRestMethod("smb/sharesec/getacl" , "POST", $Body)
                                return $reponse
                    }
    [object]getsmbsharesecsynchronize_acls()
                    {
                                $reponse = .TrueNasRestMethod("smb/sharesec/synchronize_acls" , "GET")
                                return $reponse
                    }
    [object]postsmbstatus([psobject]$Body)
                    {
                                $reponse = .TrueNasRestMethod("smb/status" , "POST", $Body)
                                return $reponse
                    }
    [object]getsmbunixcharset_choices()
                    {
                                $reponse = .TrueNasRestMethod("smb/unixcharset_choices" , "GET")
                                return $reponse
                    }
}
