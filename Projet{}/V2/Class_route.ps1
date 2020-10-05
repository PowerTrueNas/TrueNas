class TrueNasroute :TrueNasConfiguration
    {
        [String]$CommonName
        [String]$Uri
        [PSobject]$Params

        TrueNasroute([TrueNasConfiguration]$param):base()
    {
    }
    [object]postrouteipv4gw_reachable([psobject]$Body)
                    {
                                $reponse = .TrueNasRestMethod("route/ipv4gw_reachable" , "POST", $Body)
                                return $reponse
                    }
    [object]getroutesystem_routes()
                    {
                                $reponse = .TrueNasRestMethod("route/system_routes" , "GET")
                                return $reponse
                    }
}
