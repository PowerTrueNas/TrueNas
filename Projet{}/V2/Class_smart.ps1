class TrueNassmart :TrueNasConfiguration
    {
        [String]$CommonName
        [String]$Uri
        [PSobject]$Params

        TrueNassmart([TrueNasConfiguration]$param):base()
    {
    }
    [object]putsmart([psobject]$Body)
                    {
                                $reponse = .TrueNasRestMethod("smart" , "PUT", $Body)
                                return $reponse
                    }
    [object]getsmart()
                    {
                                $reponse = .TrueNasRestMethod("smart" , "GET")
                                return $reponse
                    }
    [object]postsmarttest([psobject]$Body)
                    {
                                $reponse = .TrueNasRestMethod("smart/test" , "POST", $Body)
                                return $reponse
                    }
    [object]getsmarttest()
                    {
                                $reponse = .TrueNasRestMethod("smart/test" , "GET")
                                return $reponse
                    }
    [object]getsmarttestget_instance()
                    {
                                $reponse = .TrueNasRestMethod("smart/test/get_instance" , "GET")
                                return $reponse
                    }
    [object]postsmarttestmanual_test([psobject]$Body)
                    {
                                $reponse = .TrueNasRestMethod("smart/test/manual_test" , "POST", $Body)
                                return $reponse
                    }
    [object]getsmarttestresults()
                    {
                                $reponse = .TrueNasRestMethod("smart/test/results" , "GET")
                                return $reponse
                    }
}
