class TrueNasmail :TrueNasConfiguration
    {
        [String]$CommonName
        [String]$Uri
        [PSobject]$Params

        TrueNasmail([TrueNasConfiguration]$param):base()
    {
    }
    [object]putmail([psobject]$Body)
                    {
                                $reponse = .TrueNasRestMethod("mail" , "PUT", $Body)
                                return $reponse
                    }
    [object]getmail()
                    {
                                $reponse = .TrueNasRestMethod("mail" , "GET")
                                return $reponse
                    }
    [object]postmailsend([psobject]$Body)
                    {
                                $reponse = .TrueNasRestMethod("mail/send" , "POST", $Body)
                                return $reponse
                    }
}
