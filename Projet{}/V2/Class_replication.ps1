class TrueNasreplication :TrueNasConfiguration
    {
        [String]$CommonName
        [String]$Uri
        [PSobject]$Params

        TrueNasreplication([TrueNasConfiguration]$param):base()
    {
    }
    [object]postreplication([psobject]$Body)
                    {
                                $reponse = .TrueNasRestMethod("replication" , "POST", $Body)
                                return $reponse
                    }
    [object]getreplication()
                    {
                                $reponse = .TrueNasRestMethod("replication" , "GET")
                                return $reponse
                    }
    [object]postreplicationcount_eligible_manual_snapshots([psobject]$Body)
                    {
                                $reponse = .TrueNasRestMethod("replication/count_eligible_manual_snapshots" , "POST", $Body)
                                return $reponse
                    }
    [object]postreplicationcreate_dataset([psobject]$Body)
                    {
                                $reponse = .TrueNasRestMethod("replication/create_dataset" , "POST", $Body)
                                return $reponse
                    }
    [object]getreplicationget_instance()
                    {
                                $reponse = .TrueNasRestMethod("replication/get_instance" , "GET")
                                return $reponse
                    }
    [object]postreplicationlist_datasets([psobject]$Body)
                    {
                                $reponse = .TrueNasRestMethod("replication/list_datasets" , "POST", $Body)
                                return $reponse
                    }
    [object]getreplicationlist_naming_schemas()
                    {
                                $reponse = .TrueNasRestMethod("replication/list_naming_schemas" , "GET")
                                return $reponse
                    }
    [object]postreplicationtarget_unmatched_snapshots([psobject]$Body)
                    {
                                $reponse = .TrueNasRestMethod("replication/target_unmatched_snapshots" , "POST", $Body)
                                return $reponse
                    }
}
