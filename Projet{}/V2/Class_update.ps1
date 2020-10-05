class TrueNasupdate :TrueNasConfiguration
    {
        [String]$CommonName
        [String]$Uri
        [PSobject]$Params

        TrueNasupdate([TrueNasConfiguration]$param):base()
    {
    }
    [object]postupdatecheck_available([psobject]$Body)
                    {
                                $reponse = .TrueNasRestMethod("update/check_available" , "POST", $Body)
                                return $reponse
                    }
    [object]getupdatedownload()
                    {
                                $reponse = .TrueNasRestMethod("update/download" , "GET")
                                return $reponse
                    }
    [object]getupdateget_auto_download()
                    {
                                $reponse = .TrueNasRestMethod("update/get_auto_download" , "GET")
                                return $reponse
                    }
    [object]postupdateget_pending([psobject]$Body)
                    {
                                $reponse = .TrueNasRestMethod("update/get_pending" , "POST", $Body)
                                return $reponse
                    }
    [object]getupdateget_trains()
                    {
                                $reponse = .TrueNasRestMethod("update/get_trains" , "GET")
                                return $reponse
                    }
    [object]postupdatemanual([psobject]$Body)
                    {
                                $reponse = .TrueNasRestMethod("update/manual" , "POST", $Body)
                                return $reponse
                    }
    [object]postupdateset_auto_download([psobject]$Body)
                    {
                                $reponse = .TrueNasRestMethod("update/set_auto_download" , "POST", $Body)
                                return $reponse
                    }
    [object]postupdateset_train([psobject]$Body)
                    {
                                $reponse = .TrueNasRestMethod("update/set_train" , "POST", $Body)
                                return $reponse
                    }
    [object]postupdateupdate([psobject]$Body)
                    {
                                $reponse = .TrueNasRestMethod("update/update" , "POST", $Body)
                                return $reponse
                    }
}
