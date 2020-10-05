class TrueNascloudsync :TrueNasConfiguration
    {
        [String]$CommonName
        [String]$Uri
        [PSobject]$Params

        TrueNascloudsync([TrueNasConfiguration]$param):base()
    {
    }
    [object]postcloudsync([psobject]$Body)
                    {
                                $reponse = .TrueNasRestMethod("cloudsync" , "POST", $Body)
                                return $reponse
                    }
    [object]getcloudsync()
                    {
                                $reponse = .TrueNasRestMethod("cloudsync" , "GET")
                                return $reponse
                    }
    [object]getcloudsynccommon_task_schema()
                    {
                                $reponse = .TrueNasRestMethod("cloudsync/common_task_schema" , "GET")
                                return $reponse
                    }
    [object]postcloudsynccredentials([psobject]$Body)
                    {
                                $reponse = .TrueNasRestMethod("cloudsync/credentials" , "POST", $Body)
                                return $reponse
                    }
    [object]getcloudsynccredentials()
                    {
                                $reponse = .TrueNasRestMethod("cloudsync/credentials" , "GET")
                                return $reponse
                    }
    [object]getcloudsynccredentialsget_instance()
                    {
                                $reponse = .TrueNasRestMethod("cloudsync/credentials/get_instance" , "GET")
                                return $reponse
                    }
    [object]postcloudsynccredentialsverify([psobject]$Body)
                    {
                                $reponse = .TrueNasRestMethod("cloudsync/credentials/verify" , "POST", $Body)
                                return $reponse
                    }
    [object]getcloudsyncget_instance()
                    {
                                $reponse = .TrueNasRestMethod("cloudsync/get_instance" , "GET")
                                return $reponse
                    }
    [object]postcloudsynclist_buckets([psobject]$Body)
                    {
                                $reponse = .TrueNasRestMethod("cloudsync/list_buckets" , "POST", $Body)
                                return $reponse
                    }
    [object]postcloudsynclist_directory([psobject]$Body)
                    {
                                $reponse = .TrueNasRestMethod("cloudsync/list_directory" , "POST", $Body)
                                return $reponse
                    }
    [object]postcloudsynconedrive_list_drives([psobject]$Body)
                    {
                                $reponse = .TrueNasRestMethod("cloudsync/onedrive_list_drives" , "POST", $Body)
                                return $reponse
                    }
    [object]getcloudsyncproviders()
                    {
                                $reponse = .TrueNasRestMethod("cloudsync/providers" , "GET")
                                return $reponse
                    }
    [object]postcloudsyncsync_onetime([psobject]$Body)
                    {
                                $reponse = .TrueNasRestMethod("cloudsync/sync_onetime" , "POST", $Body)
                                return $reponse
                    }
}
