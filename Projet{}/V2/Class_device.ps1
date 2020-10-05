class TrueNasdevice :TrueNasConfiguration
    {
        [String]$CommonName
        [String]$Uri
        [PSobject]$Params

        TrueNasdevice([TrueNasConfiguration]$param):base()
    {
    }
    [object]postdeviceget_info([psobject]$Body)
                    {
                                $reponse = .TrueNasRestMethod("device/get_info" , "POST", $Body)
                                return $reponse
                    }
}
