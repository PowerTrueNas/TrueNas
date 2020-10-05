class TrueNaswebdav :TrueNasConfiguration
    {
        [String]$CommonName
        [String]$Uri
        [PSobject]$Params

        TrueNaswebdav([TrueNasConfiguration]$param):base()
    {
    }
    [object]putwebdav([psobject]$Body)
                    {
                                $reponse = .TrueNasRestMethod("webdav" , "PUT", $Body)
                                return $reponse
                    }
    [object]getwebdav()
                    {
                                $reponse = .TrueNasRestMethod("webdav" , "GET")
                                return $reponse
                    }
}
