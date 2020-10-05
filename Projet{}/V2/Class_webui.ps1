class TrueNaswebui :TrueNasConfiguration
    {
        [String]$CommonName
        [String]$Uri
        [PSobject]$Params

        TrueNaswebui([TrueNasConfiguration]$param):base()
    {
    }
    [object]getwebuiimage()
                    {
                                $reponse = .TrueNasRestMethod("webui/image" , "GET")
                                return $reponse
                    }
    [object]getwebuiimageget_instance()
                    {
                                $reponse = .TrueNasRestMethod("webui/image/get_instance" , "GET")
                                return $reponse
                    }
}
