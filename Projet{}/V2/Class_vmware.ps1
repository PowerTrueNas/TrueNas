class TrueNasvmware :TrueNasConfiguration
    {
        [String]$CommonName
        [String]$Uri
        [PSobject]$Params

        TrueNasvmware([TrueNasConfiguration]$param):base()
    {
    }
    [object]postvmware([psobject]$Body)
                    {
                                $reponse = .TrueNasRestMethod("vmware" , "POST", $Body)
                                return $reponse
                    }
    [object]getvmware()
                    {
                                $reponse = .TrueNasRestMethod("vmware" , "GET")
                                return $reponse
                    }
    [object]postvmwaredataset_has_vms([psobject]$Body)
                    {
                                $reponse = .TrueNasRestMethod("vmware/dataset_has_vms" , "POST", $Body)
                                return $reponse
                    }
    [object]postvmwareget_datastores([psobject]$Body)
                    {
                                $reponse = .TrueNasRestMethod("vmware/get_datastores" , "POST", $Body)
                                return $reponse
                    }
    [object]getvmwareget_instance()
                    {
                                $reponse = .TrueNasRestMethod("vmware/get_instance" , "GET")
                                return $reponse
                    }
    [object]postvmwareget_virtual_machines([psobject]$Body)
                    {
                                $reponse = .TrueNasRestMethod("vmware/get_virtual_machines" , "POST", $Body)
                                return $reponse
                    }
    [object]postvmwarematch_datastores_with_datasets([psobject]$Body)
                    {
                                $reponse = .TrueNasRestMethod("vmware/match_datastores_with_datasets" , "POST", $Body)
                                return $reponse
                    }
}
