class TrueNasbootenv :TrueNasConfiguration
    {
        [String]$CommonName
        [String]$Uri
        [PSobject]$Params

        TrueNasbootenv([TrueNasConfiguration]$param):base()
    {
    }
    [object]postbootenv([psobject]$Body)
                    {
                                $reponse = .TrueNasRestMethod("bootenv" , "POST", $Body)
                                return $reponse
                    }
    [object]getbootenv()
                    {
                                $reponse = .TrueNasRestMethod("bootenv" , "GET")
                                return $reponse
                    }
    [object]getbootenvget_instance()
                    {
                                $reponse = .TrueNasRestMethod("bootenv/get_instance" , "GET")
                                return $reponse
                    }
}
