class TrueNasfailover :TrueNasConfiguration
    {
        [String]$CommonName
        [String]$Uri
        [PSobject]$Params

        TrueNasfailover([TrueNasConfiguration]$param):base()
    {
    }
    [object]putfailover([psobject]$Body)
                    {
                                $reponse = .TrueNasRestMethod("failover" , "PUT", $Body)
                                return $reponse
                    }
    [object]getfailover()
                    {
                                $reponse = .TrueNasRestMethod("failover" , "GET")
                                return $reponse
                    }
    [object]postfailovercall_remote([psobject]$Body)
                    {
                                $reponse = .TrueNasRestMethod("failover/call_remote" , "POST", $Body)
                                return $reponse
                    }
    [object]postfailovercontrol([psobject]$Body)
                    {
                                $reponse = .TrueNasRestMethod("failover/control" , "POST", $Body)
                                return $reponse
                    }
    [object]getfailoverforce_master()
                    {
                                $reponse = .TrueNasRestMethod("failover/force_master" , "GET")
                                return $reponse
                    }
    [object]getfailoverhardware()
                    {
                                $reponse = .TrueNasRestMethod("failover/hardware" , "GET")
                                return $reponse
                    }
    [object]getfailoverin_progress()
                    {
                                $reponse = .TrueNasRestMethod("failover/in_progress" , "GET")
                                return $reponse
                    }
    [object]getfailoverlicensed()
                    {
                                $reponse = .TrueNasRestMethod("failover/licensed" , "GET")
                                return $reponse
                    }
    [object]getfailovernode()
                    {
                                $reponse = .TrueNasRestMethod("failover/node" , "GET")
                                return $reponse
                    }
    [object]getfailoversync_from_peer()
                    {
                                $reponse = .TrueNasRestMethod("failover/sync_from_peer" , "GET")
                                return $reponse
                    }
    [object]postfailoversync_to_peer([psobject]$Body)
                    {
                                $reponse = .TrueNasRestMethod("failover/sync_to_peer" , "POST", $Body)
                                return $reponse
                    }
    [object]postfailoverunlock([psobject]$Body)
                    {
                                $reponse = .TrueNasRestMethod("failover/unlock" , "POST", $Body)
                                return $reponse
                    }
    [object]postfailoverupgrade([psobject]$Body)
                    {
                                $reponse = .TrueNasRestMethod("failover/upgrade" , "POST", $Body)
                                return $reponse
                    }
    [object]getfailoverupgrade_finish()
                    {
                                $reponse = .TrueNasRestMethod("failover/upgrade_finish" , "GET")
                                return $reponse
                    }
    [object]getfailoverupgrade_pending()
                    {
                                $reponse = .TrueNasRestMethod("failover/upgrade_pending" , "GET")
                                return $reponse
                    }
}
