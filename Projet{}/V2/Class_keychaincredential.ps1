class TrueNaskeychaincredential :TrueNasConfiguration
    {
        [String]$CommonName
        [String]$Uri
        [PSobject]$Params

        TrueNaskeychaincredential([TrueNasConfiguration]$param):base()
    {
    }
    [object]postkeychaincredential([psobject]$Body)
                    {
                                $reponse = .TrueNasRestMethod("keychaincredential" , "POST", $Body)
                                return $reponse
                    }
    [object]getkeychaincredential()
                    {
                                $reponse = .TrueNasRestMethod("keychaincredential" , "GET")
                                return $reponse
                    }
    [object]getkeychaincredentialgenerate_ssh_key_pair()
                    {
                                $reponse = .TrueNasRestMethod("keychaincredential/generate_ssh_key_pair" , "GET")
                                return $reponse
                    }
    [object]getkeychaincredentialget_instance()
                    {
                                $reponse = .TrueNasRestMethod("keychaincredential/get_instance" , "GET")
                                return $reponse
                    }
    [object]postkeychaincredentialremote_ssh_host_key_scan([psobject]$Body)
                    {
                                $reponse = .TrueNasRestMethod("keychaincredential/remote_ssh_host_key_scan" , "POST", $Body)
                                return $reponse
                    }
    [object]postkeychaincredentialremote_ssh_semiautomatic_setup([psobject]$Body)
                    {
                                $reponse = .TrueNasRestMethod("keychaincredential/remote_ssh_semiautomatic_setup" , "POST", $Body)
                                return $reponse
                    }
    [object]postkeychaincredentialused_by([psobject]$Body)
                    {
                                $reponse = .TrueNasRestMethod("keychaincredential/used_by" , "POST", $Body)
                                return $reponse
                    }
}
