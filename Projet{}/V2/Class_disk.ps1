class TrueNasdisk :TrueNasConfiguration
    {
        [String]$CommonName
        [String]$Uri
        [PSobject]$Params

        TrueNasdisk([TrueNasConfiguration]$param):base()
    {
    }
    [object]getdisk()
                    {
                                $reponse = .TrueNasRestMethod("disk" , "GET")
                                return $reponse
                    }
    [object]postdiskget_encrypted([psobject]$Body)
                    {
                                $reponse = .TrueNasRestMethod("disk/get_encrypted" , "POST", $Body)
                                return $reponse
                    }
    [object]getdiskget_instance()
                    {
                                $reponse = .TrueNasRestMethod("disk/get_instance" , "GET")
                                return $reponse
                    }
    [object]postdiskget_unused([psobject]$Body)
                    {
                                $reponse = .TrueNasRestMethod("disk/get_unused" , "POST", $Body)
                                return $reponse
                    }
    [object]getdisklabel_to_dev()
                    {
                                $reponse = .TrueNasRestMethod("disk/label_to_dev" , "GET")
                                return $reponse
                    }
    [object]postdiskoverprovision([psobject]$Body)
                    {
                                $reponse = .TrueNasRestMethod("disk/overprovision" , "POST", $Body)
                                return $reponse
                    }
    [object]postdisksmart_attributes([psobject]$Body)
                    {
                                $reponse = .TrueNasRestMethod("disk/smart_attributes" , "POST", $Body)
                                return $reponse
                    }
    [object]postdiskspindown([psobject]$Body)
                    {
                                $reponse = .TrueNasRestMethod("disk/spindown" , "POST", $Body)
                                return $reponse
                    }
    [object]postdisktemperature([psobject]$Body)
                    {
                                $reponse = .TrueNasRestMethod("disk/temperature" , "POST", $Body)
                                return $reponse
                    }
    [object]postdisktemperatures([psobject]$Body)
                    {
                                $reponse = .TrueNasRestMethod("disk/temperatures" , "POST", $Body)
                                return $reponse
                    }
    [object]postdiskunoverprovision([psobject]$Body)
                    {
                                $reponse = .TrueNasRestMethod("disk/unoverprovision" , "POST", $Body)
                                return $reponse
                    }
    [object]postdiskwipe([psobject]$Body)
                    {
                                $reponse = .TrueNasRestMethod("disk/wipe" , "POST", $Body)
                                return $reponse
                    }
}
