class TrueNascertificateauthority :TrueNasConfiguration
    {
        [String]$CommonName
        [String]$Uri
        [PSobject]$Params

        TrueNascertificateauthority([TrueNasConfiguration]$param):base()
    {
    }
    [object]postcertificateauthority([psobject]$Body)
                    {
                                $reponse = .TrueNasRestMethod("certificateauthority" , "POST", $Body)
                                return $reponse
                    }
    [object]getcertificateauthority()
                    {
                                $reponse = .TrueNasRestMethod("certificateauthority" , "GET")
                                return $reponse
                    }
    [object]postcertificateauthorityca_sign_csr([psobject]$Body)
                    {
                                $reponse = .TrueNasRestMethod("certificateauthority/ca_sign_csr" , "POST", $Body)
                                return $reponse
                    }
    [object]getcertificateauthorityget_instance()
                    {
                                $reponse = .TrueNasRestMethod("certificateauthority/get_instance" , "GET")
                                return $reponse
                    }
    [object]getcertificateauthorityprofiles()
                    {
                                $reponse = .TrueNasRestMethod("certificateauthority/profiles" , "GET")
                                return $reponse
                    }
}
