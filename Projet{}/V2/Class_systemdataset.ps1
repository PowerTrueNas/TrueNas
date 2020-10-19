class TrueNassystemdataset :TrueNasConfiguration
    {
        [String]$CommonName
        [String]$Uri
        [PSobject]$Params

        TrueNassystemdataset([TrueNasConfiguration]$param):base()
    {
    }
    [object]putsystemdataset([psobject]$Body)
                    {
                                $reponse = .TrueNasRestMethod("systemdataset" , "PUT", $Body)
                                return $reponse
                    }
    [object]getsystemdataset()
                    {
                                $reponse = .TrueNasRestMethod("systemdataset" , "GET")
                                return $reponse
                    }
}
