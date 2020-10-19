class TrueNasrsynctask :TrueNasConfiguration
    {
        [String]$CommonName
        [String]$Uri
        [PSobject]$Params

        TrueNasrsynctask([TrueNasConfiguration]$param):base()
    {
    }
    [object]postrsynctask([psobject]$Body)
                    {
                                $reponse = .TrueNasRestMethod("rsynctask" , "POST", $Body)
                                return $reponse
                    }
    [object]getrsynctask()
                    {
                                $reponse = .TrueNasRestMethod("rsynctask" , "GET")
                                return $reponse
                    }
    [object]getrsynctaskget_instance()
                    {
                                $reponse = .TrueNasRestMethod("rsynctask/get_instance" , "GET")
                                return $reponse
                    }
}
