class TrueNassnmp :TrueNasConfiguration
    {
        [String]$CommonName
        [String]$Uri
        [PSobject]$Params

        TrueNassnmp([TrueNasConfiguration]$param):base()
    {
    }
    [object]putsnmp([psobject]$Body)
                    {
                                $reponse = .TrueNasRestMethod("snmp" , "PUT", $Body)
                                return $reponse
                    }
    [object]getsnmp()
                    {
                                $reponse = .TrueNasRestMethod("snmp" , "GET")
                                return $reponse
                    }
}
