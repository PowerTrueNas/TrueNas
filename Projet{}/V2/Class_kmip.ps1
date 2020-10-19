class TrueNaskmip :TrueNasConfiguration
    {
        [String]$CommonName
        [String]$Uri
        [PSobject]$Params

        TrueNaskmip([TrueNasConfiguration]$param):base()
    {
    }
    [object]putkmip([psobject]$Body)
                    {
                                $reponse = .TrueNasRestMethod("kmip" , "PUT", $Body)
                                return $reponse
                    }
    [object]getkmip()
                    {
                                $reponse = .TrueNasRestMethod("kmip" , "GET")
                                return $reponse
                    }
    [object]getkmipclear_sync_pending_keys()
                    {
                                $reponse = .TrueNasRestMethod("kmip/clear_sync_pending_keys" , "GET")
                                return $reponse
                    }
    [object]getkmipkmip_sync_pending()
                    {
                                $reponse = .TrueNasRestMethod("kmip/kmip_sync_pending" , "GET")
                                return $reponse
                    }
    [object]getkmipsync_keys()
                    {
                                $reponse = .TrueNasRestMethod("kmip/sync_keys" , "GET")
                                return $reponse
                    }
}
