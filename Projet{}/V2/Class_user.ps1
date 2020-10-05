class TrueNasuser :TrueNasConfiguration
    {
        [String]$CommonName
        [String]$Uri
        [PSobject]$Params

        TrueNasuser([TrueNasConfiguration]$param):base()
    {
    }
    [object]postuser([psobject]$Body)
                    {
                                $reponse = .TrueNasRestMethod("user" , "POST", $Body)
                                return $reponse
                    }
    [object]getuser()
                    {
                                $reponse = .TrueNasRestMethod("user" , "GET")
                                return $reponse
                    }
    [object]getuserget_instance()
                    {
                                $reponse = .TrueNasRestMethod("user/get_instance" , "GET")
                                return $reponse
                    }
    [object]getuserget_next_uid()
                    {
                                $reponse = .TrueNasRestMethod("user/get_next_uid" , "GET")
                                return $reponse
                    }
    [object]postuserget_user_obj([psobject]$Body)
                    {
                                $reponse = .TrueNasRestMethod("user/get_user_obj" , "POST", $Body)
                                return $reponse
                    }
    [object]getuserhas_root_password()
                    {
                                $reponse = .TrueNasRestMethod("user/has_root_password" , "GET")
                                return $reponse
                    }
    [object]postusershell_choices([psobject]$Body)
                    {
                                $reponse = .TrueNasRestMethod("user/shell_choices" , "POST", $Body)
                                return $reponse
                    }
}
