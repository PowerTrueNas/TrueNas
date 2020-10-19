class TrueNasiscsi :TrueNasConfiguration
    {
        [String]$CommonName
        [String]$Uri
        [PSobject]$Params

        TrueNasiscsi([TrueNasConfiguration]$param):base()
    {
    }
    [object]postiscsiauth([psobject]$Body)
                    {
                                $reponse = .TrueNasRestMethod("iscsi/auth" , "POST", $Body)
                                return $reponse
                    }
    [object]getiscsiauth()
                    {
                                $reponse = .TrueNasRestMethod("iscsi/auth" , "GET")
                                return $reponse
                    }
    [object]getiscsiauthget_instance()
                    {
                                $reponse = .TrueNasRestMethod("iscsi/auth/get_instance" , "GET")
                                return $reponse
                    }
    [object]postiscsiextent([psobject]$Body)
                    {
                                $reponse = .TrueNasRestMethod("iscsi/extent" , "POST", $Body)
                                return $reponse
                    }
    [object]getiscsiextent()
                    {
                                $reponse = .TrueNasRestMethod("iscsi/extent" , "GET")
                                return $reponse
                    }
    [object]postiscsiextentdisk_choices([psobject]$Body)
                    {
                                $reponse = .TrueNasRestMethod("iscsi/extent/disk_choices" , "POST", $Body)
                                return $reponse
                    }
    [object]getiscsiextentget_instance()
                    {
                                $reponse = .TrueNasRestMethod("iscsi/extent/get_instance" , "GET")
                                return $reponse
                    }
    [object]putiscsiglobal([psobject]$Body)
                    {
                                $reponse = .TrueNasRestMethod("iscsi/global" , "PUT", $Body)
                                return $reponse
                    }
    [object]getiscsiglobal()
                    {
                                $reponse = .TrueNasRestMethod("iscsi/global" , "GET")
                                return $reponse
                    }
    [object]getiscsiglobalalua_enabled()
                    {
                                $reponse = .TrueNasRestMethod("iscsi/global/alua_enabled" , "GET")
                                return $reponse
                    }
    [object]getiscsiglobalsessions()
                    {
                                $reponse = .TrueNasRestMethod("iscsi/global/sessions" , "GET")
                                return $reponse
                    }
    [object]postiscsiinitiator([psobject]$Body)
                    {
                                $reponse = .TrueNasRestMethod("iscsi/initiator" , "POST", $Body)
                                return $reponse
                    }
    [object]getiscsiinitiator()
                    {
                                $reponse = .TrueNasRestMethod("iscsi/initiator" , "GET")
                                return $reponse
                    }
    [object]getiscsiinitiatorget_instance()
                    {
                                $reponse = .TrueNasRestMethod("iscsi/initiator/get_instance" , "GET")
                                return $reponse
                    }
    [object]postiscsiportal([psobject]$Body)
                    {
                                $reponse = .TrueNasRestMethod("iscsi/portal" , "POST", $Body)
                                return $reponse
                    }
    [object]getiscsiportal()
                    {
                                $reponse = .TrueNasRestMethod("iscsi/portal" , "GET")
                                return $reponse
                    }
    [object]getiscsiportalget_instance()
                    {
                                $reponse = .TrueNasRestMethod("iscsi/portal/get_instance" , "GET")
                                return $reponse
                    }
    [object]getiscsiportallisten_ip_choices()
                    {
                                $reponse = .TrueNasRestMethod("iscsi/portal/listen_ip_choices" , "GET")
                                return $reponse
                    }
    [object]postiscsitarget([psobject]$Body)
                    {
                                $reponse = .TrueNasRestMethod("iscsi/target" , "POST", $Body)
                                return $reponse
                    }
    [object]getiscsitarget()
                    {
                                $reponse = .TrueNasRestMethod("iscsi/target" , "GET")
                                return $reponse
                    }
    [object]getiscsitargetget_instance()
                    {
                                $reponse = .TrueNasRestMethod("iscsi/target/get_instance" , "GET")
                                return $reponse
                    }
    [object]postiscsitargetextent([psobject]$Body)
                    {
                                $reponse = .TrueNasRestMethod("iscsi/targetextent" , "POST", $Body)
                                return $reponse
                    }
    [object]getiscsitargetextent()
                    {
                                $reponse = .TrueNasRestMethod("iscsi/targetextent" , "GET")
                                return $reponse
                    }
    [object]getiscsitargetextentget_instance()
                    {
                                $reponse = .TrueNasRestMethod("iscsi/targetextent/get_instance" , "GET")
                                return $reponse
                    }
}
