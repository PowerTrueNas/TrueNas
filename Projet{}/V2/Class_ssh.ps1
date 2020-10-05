class TrueNasssh :TrueNasConfiguration
    {
        [String]$CommonName
        [String]$Uri
        [PSobject]$Params

        TrueNasssh([TrueNasConfiguration]$param):base()
    {
    }
    [object]putssh([psobject]$Body)
                    {
                                $reponse = .TrueNasRestMethod("ssh" , "PUT", $Body)
                                return $reponse
                    }
    [object]getssh()
                    {
                                $reponse = .TrueNasRestMethod("ssh" , "GET")
                                return $reponse
                    }
    [object]getsshbindiface_choices()
                    {
                                $reponse = .TrueNasRestMethod("ssh/bindiface_choices" , "GET")
                                return $reponse
                    }
}
