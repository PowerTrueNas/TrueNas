class TrueNasec2 :TrueNasConfiguration
    {
        [String]$CommonName
        [String]$Uri
        [PSobject]$Params

        TrueNasec2([TrueNasConfiguration]$param):base()
    {
    }
    [object]getec2instance_id()
                    {
                                $reponse = .TrueNasRestMethod("ec2/instance_id" , "GET")
                                return $reponse
                    }
    [object]getec2Meta()
                    {
                                $reponse = .TrueNasRestMethod("ec2/Meta" , "GET")
                                return $reponse
                    }
    [object]getec2set_ntp_servers()
                    {
                                $reponse = .TrueNasRestMethod("ec2/set_ntp_servers" , "GET")
                                return $reponse
                    }
    [object]getec2set_root_ssh_public_key()
                    {
                                $reponse = .TrueNasRestMethod("ec2/set_root_ssh_public_key" , "GET")
                                return $reponse
                    }
    [object]getec2setup()
                    {
                                $reponse = .TrueNasRestMethod("ec2/setup" , "GET")
                                return $reponse
                    }
}
