class TrueNaspool :TrueNasConfiguration
    {
        [String]$CommonName
        [String]$Uri
        [PSobject]$Params

        TrueNaspool([TrueNasConfiguration]$param):base()
    {
    }
    [object]postpool([psobject]$Body)
                    {
                                $reponse = .TrueNasRestMethod("pool" , "POST", $Body)
                                return $reponse
                    }
    [object]getpool()
                    {
                                $reponse = .TrueNasRestMethod("pool" , "GET")
                                return $reponse
                    }
    [object]postpoolattach([psobject]$Body)
                    {
                                $reponse = .TrueNasRestMethod("pool/attach" , "POST", $Body)
                                return $reponse
                    }
    [object]postpooldataset([psobject]$Body)
                    {
                                $reponse = .TrueNasRestMethod("pool/dataset" , "POST", $Body)
                                return $reponse
                    }
    [object]getpooldataset()
                    {
                                $reponse = .TrueNasRestMethod("pool/dataset" , "GET")
                                return $reponse
                    }
    [object]postpooldatasetchange_key([psobject]$Body)
                    {
                                $reponse = .TrueNasRestMethod("pool/dataset/change_key" , "POST", $Body)
                                return $reponse
                    }
    [object]getpooldatasetencryption_algorithm_choices()
                    {
                                $reponse = .TrueNasRestMethod("pool/dataset/encryption_algorithm_choices" , "GET")
                                return $reponse
                    }
    [object]postpooldatasetencryption_summary([psobject]$Body)
                    {
                                $reponse = .TrueNasRestMethod("pool/dataset/encryption_summary" , "POST", $Body)
                                return $reponse
                    }
    [object]getpooldatasetget_instance()
                    {
                                $reponse = .TrueNasRestMethod("pool/dataset/get_instance" , "GET")
                                return $reponse
                    }
    [object]postpooldatasetinherit_parent_encryption_properties([psobject]$Body)
                    {
                                $reponse = .TrueNasRestMethod("pool/dataset/inherit_parent_encryption_properties" , "POST", $Body)
                                return $reponse
                    }
    [object]postpooldatasetlock([psobject]$Body)
                    {
                                $reponse = .TrueNasRestMethod("pool/dataset/lock" , "POST", $Body)
                                return $reponse
                    }
    [object]postpooldatasetrecommended_zvol_blocksize([psobject]$Body)
                    {
                                $reponse = .TrueNasRestMethod("pool/dataset/recommended_zvol_blocksize" , "POST", $Body)
                                return $reponse
                    }
    [object]postpooldatasetunlock([psobject]$Body)
                    {
                                $reponse = .TrueNasRestMethod("pool/dataset/unlock" , "POST", $Body)
                                return $reponse
                    }
    [object]postpooldatasetuserprop([psobject]$Body)
                    {
                                $reponse = .TrueNasRestMethod("pool/dataset/userprop" , "POST", $Body)
                                return $reponse
                    }
    [object]getpooldatasetuserprop()
                    {
                                $reponse = .TrueNasRestMethod("pool/dataset/userprop" , "GET")
                                return $reponse
                    }
    [object]getpooldatasetuserpropget_instance()
                    {
                                $reponse = .TrueNasRestMethod("pool/dataset/userprop/get_instance" , "GET")
                                return $reponse
                    }
    [object]postpoolfilesystem_choices([psobject]$Body)
                    {
                                $reponse = .TrueNasRestMethod("pool/filesystem_choices" , "POST", $Body)
                                return $reponse
                    }
    [object]getpoolget_instance()
                    {
                                $reponse = .TrueNasRestMethod("pool/get_instance" , "GET")
                                return $reponse
                    }
    [object]postpoolimport_disk([psobject]$Body)
                    {
                                $reponse = .TrueNasRestMethod("pool/import_disk" , "POST", $Body)
                                return $reponse
                    }
    [object]postpoolimport_disk_autodetect_fs_type([psobject]$Body)
                    {
                                $reponse = .TrueNasRestMethod("pool/import_disk_autodetect_fs_type" , "POST", $Body)
                                return $reponse
                    }
    [object]getpoolimport_disk_msdosfs_locales()
                    {
                                $reponse = .TrueNasRestMethod("pool/import_disk_msdosfs_locales" , "GET")
                                return $reponse
                    }
    [object]getpoolimport_find()
                    {
                                $reponse = .TrueNasRestMethod("pool/import_find" , "GET")
                                return $reponse
                    }
    [object]postpoolimport_pool([psobject]$Body)
                    {
                                $reponse = .TrueNasRestMethod("pool/import_pool" , "POST", $Body)
                                return $reponse
                    }
    [object]putpoolresilver([psobject]$Body)
                    {
                                $reponse = .TrueNasRestMethod("pool/resilver" , "PUT", $Body)
                                return $reponse
                    }
    [object]getpoolresilver()
                    {
                                $reponse = .TrueNasRestMethod("pool/resilver" , "GET")
                                return $reponse
                    }
    [object]postpoolscrub([psobject]$Body)
                    {
                                $reponse = .TrueNasRestMethod("pool/scrub" , "POST", $Body)
                                return $reponse
                    }
    [object]getpoolscrub()
                    {
                                $reponse = .TrueNasRestMethod("pool/scrub" , "GET")
                                return $reponse
                    }
    [object]getpoolscrubget_instance()
                    {
                                $reponse = .TrueNasRestMethod("pool/scrub/get_instance" , "GET")
                                return $reponse
                    }
    [object]postpoolscrubrun([psobject]$Body)
                    {
                                $reponse = .TrueNasRestMethod("pool/scrub/run" , "POST", $Body)
                                return $reponse
                    }
    [object]postpoolsnapshottask([psobject]$Body)
                    {
                                $reponse = .TrueNasRestMethod("pool/snapshottask" , "POST", $Body)
                                return $reponse
                    }
    [object]getpoolsnapshottask()
                    {
                                $reponse = .TrueNasRestMethod("pool/snapshottask" , "GET")
                                return $reponse
                    }
    [object]getpoolsnapshottaskget_instance()
                    {
                                $reponse = .TrueNasRestMethod("pool/snapshottask/get_instance" , "GET")
                                return $reponse
                    }
    [object]postpoolunlock_services_restart_choices([psobject]$Body)
                    {
                                $reponse = .TrueNasRestMethod("pool/unlock_services_restart_choices" , "POST", $Body)
                                return $reponse
                    }
}
