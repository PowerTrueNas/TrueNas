class TrueNasplugin :TrueNasConfiguration
    {
        [String]$CommonName
        [String]$Uri
        [PSobject]$Params

        TrueNasplugin([TrueNasConfiguration]$param):base()
    {
    }
    [object]postplugin([psobject]$Body)
                    {
                                $reponse = .TrueNasRestMethod("plugin" , "POST", $Body)
                                return $reponse
                    }
    [object]getplugin()
                    {
                                $reponse = .TrueNasRestMethod("plugin" , "GET")
                                return $reponse
                    }
    [object]postpluginavailable([psobject]$Body)
                    {
                                $reponse = .TrueNasRestMethod("plugin/available" , "POST", $Body)
                                return $reponse
                    }
    [object]postpluginbranches_choices([psobject]$Body)
                    {
                                $reponse = .TrueNasRestMethod("plugin/branches_choices" , "POST", $Body)
                                return $reponse
                    }
    [object]postplugindefaults([psobject]$Body)
                    {
                                $reponse = .TrueNasRestMethod("plugin/defaults" , "POST", $Body)
                                return $reponse
                    }
    [object]getpluginget_instance()
                    {
                                $reponse = .TrueNasRestMethod("plugin/get_instance" , "GET")
                                return $reponse
                    }
    [object]getpluginofficial_repositories()
                    {
                                $reponse = .TrueNasRestMethod("plugin/official_repositories" , "GET")
                                return $reponse
                    }
    [object]getpluginretrieve_versions_for_repos()
                    {
                                $reponse = .TrueNasRestMethod("plugin/retrieve_versions_for_repos" , "GET")
                                return $reponse
                    }
}
