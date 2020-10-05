class TrueNaszfs :TrueNasConfiguration
    {
        [String]$CommonName
        [String]$Uri
        [PSobject]$Params

        TrueNaszfs([TrueNasConfiguration]$param):base()
    {
    }
    [object]postzfssnapshot([psobject]$Body)
                    {
                                $reponse = .TrueNasRestMethod("zfs/snapshot" , "POST", $Body)
                                return $reponse
                    }
    [object]getzfssnapshot()
                    {
                                $reponse = .TrueNasRestMethod("zfs/snapshot" , "GET")
                                return $reponse
                    }
    [object]postzfssnapshotclone([psobject]$Body)
                    {
                                $reponse = .TrueNasRestMethod("zfs/snapshot/clone" , "POST", $Body)
                                return $reponse
                    }
    [object]getzfssnapshotget_instance()
                    {
                                $reponse = .TrueNasRestMethod("zfs/snapshot/get_instance" , "GET")
                                return $reponse
                    }
    [object]postzfssnapshotremove([psobject]$Body)
                    {
                                $reponse = .TrueNasRestMethod("zfs/snapshot/remove" , "POST", $Body)
                                return $reponse
                    }
    [object]postzfssnapshotrollback([psobject]$Body)
                    {
                                $reponse = .TrueNasRestMethod("zfs/snapshot/rollback" , "POST", $Body)
                                return $reponse
                    }
}
