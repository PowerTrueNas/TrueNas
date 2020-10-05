class TrueNasfilesystem :TrueNasConfiguration
    {
        [String]$CommonName
        [String]$Uri
        [PSobject]$Params

        TrueNasfilesystem([TrueNasConfiguration]$param):base()
    {
    }
    [object]postfilesystemacl_is_trivial([psobject]$Body)
                    {
                                $reponse = .TrueNasRestMethod("filesystem/acl_is_trivial" , "POST", $Body)
                                return $reponse
                    }
    [object]postfilesystemchown([psobject]$Body)
                    {
                                $reponse = .TrueNasRestMethod("filesystem/chown" , "POST", $Body)
                                return $reponse
                    }
    [object]getfilesystemdefault_acl_choices()
                    {
                                $reponse = .TrueNasRestMethod("filesystem/default_acl_choices" , "GET")
                                return $reponse
                    }
    [object]postfilesystemget_default_acl([psobject]$Body)
                    {
                                $reponse = .TrueNasRestMethod("filesystem/get_default_acl" , "POST", $Body)
                                return $reponse
                    }
    [object]postfilesystemgetacl([psobject]$Body)
                    {
                                $reponse = .TrueNasRestMethod("filesystem/getacl" , "POST", $Body)
                                return $reponse
                    }
    [object]postfilesystemlistdir([psobject]$Body)
                    {
                                $reponse = .TrueNasRestMethod("filesystem/listdir" , "POST", $Body)
                                return $reponse
                    }
    [object]postfilesystemsetacl([psobject]$Body)
                    {
                                $reponse = .TrueNasRestMethod("filesystem/setacl" , "POST", $Body)
                                return $reponse
                    }
    [object]postfilesystemsetperm([psobject]$Body)
                    {
                                $reponse = .TrueNasRestMethod("filesystem/setperm" , "POST", $Body)
                                return $reponse
                    }
    [object]postfilesystemstat([psobject]$Body)
                    {
                                $reponse = .TrueNasRestMethod("filesystem/stat" , "POST", $Body)
                                return $reponse
                    }
    [object]postfilesystemstatfs([psobject]$Body)
                    {
                                $reponse = .TrueNasRestMethod("filesystem/statfs" , "POST", $Body)
                                return $reponse
                    }
}
