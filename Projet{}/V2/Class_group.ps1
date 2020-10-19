class TrueNasgroup :TrueNasConfiguration
    {
        [String]$CommonName
        [String]$Uri
        [PSobject]$Params

        TrueNasgroup([TrueNasConfiguration]$param):base()
    {
    }
    [object]postgroup([psobject]$Body)
                    {
                                $reponse = .TrueNasRestMethod("group" , "POST", $Body)
                                return $reponse
                    }
    [object]getgroup()
                    {
                                $reponse = .TrueNasRestMethod("group" , "GET")
                                return $reponse
                    }
    [object]postgroupget_group_obj([psobject]$Body)
                    {
                                $reponse = .TrueNasRestMethod("group/get_group_obj" , "POST", $Body)
                                return $reponse
                    }
    [object]getgroupget_instance()
                    {
                                $reponse = .TrueNasRestMethod("group/get_instance" , "GET")
                                return $reponse
                    }
    [object]getgroupget_next_gid()
                    {
                                $reponse = .TrueNasRestMethod("group/get_next_gid" , "GET")
                                return $reponse
                    }
}
