class TrueNasenclosure :TrueNasConfiguration
    {
        [String]$CommonName
        [String]$Uri
        [PSobject]$Params

        TrueNasenclosure([TrueNasConfiguration]$param):base()
    {
    }
    [object]getenclosure()
                    {
                                $reponse = .TrueNasRestMethod("enclosure" , "GET")
                                return $reponse
                    }
    [object]getenclosureget_instance()
                    {
                                $reponse = .TrueNasRestMethod("enclosure/get_instance" , "GET")
                                return $reponse
                    }
    [object]postenclosureset_slot_status([psobject]$Body)
                    {
                                $reponse = .TrueNasRestMethod("enclosure/set_slot_status" , "POST", $Body)
                                return $reponse
                    }
}
