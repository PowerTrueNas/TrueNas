class TrueNassharing :TrueNasConfiguration
    {
        [String]$CommonName
        [String]$Uri
        [PSobject]$Params

        TrueNassharing([TrueNasConfiguration]$param):base()
    {
    }
    [object]postsharingafp([psobject]$Body)
                    {
                                $reponse = .TrueNasRestMethod("sharing/afp" , "POST", $Body)
                                return $reponse
                    }
    [object]getsharingafp()
                    {
                                $reponse = .TrueNasRestMethod("sharing/afp" , "GET")
                                return $reponse
                    }
    [object]getsharingafpget_instance()
                    {
                                $reponse = .TrueNasRestMethod("sharing/afp/get_instance" , "GET")
                                return $reponse
                    }
    [object]postsharingnfs([psobject]$Body)
                    {
                                $reponse = .TrueNasRestMethod("sharing/nfs" , "POST", $Body)
                                return $reponse
                    }
    [object]getsharingnfs()
                    {
                                $reponse = .TrueNasRestMethod("sharing/nfs" , "GET")
                                return $reponse
                    }
    [object]getsharingnfsget_instance()
                    {
                                $reponse = .TrueNasRestMethod("sharing/nfs/get_instance" , "GET")
                                return $reponse
                    }
    [object]postsharingsmb([psobject]$Body)
                    {
                                $reponse = .TrueNasRestMethod("sharing/smb" , "POST", $Body)
                                return $reponse
                    }
    [object]getsharingsmb()
                    {
                                $reponse = .TrueNasRestMethod("sharing/smb" , "GET")
                                return $reponse
                    }
    [object]getsharingsmbget_instance()
                    {
                                $reponse = .TrueNasRestMethod("sharing/smb/get_instance" , "GET")
                                return $reponse
                    }
    [object]getsharingsmbpresets()
                    {
                                $reponse = .TrueNasRestMethod("sharing/smb/presets" , "GET")
                                return $reponse
                    }
    [object]postsharingwebdav([psobject]$Body)
                    {
                                $reponse = .TrueNasRestMethod("sharing/webdav" , "POST", $Body)
                                return $reponse
                    }
    [object]getsharingwebdav()
                    {
                                $reponse = .TrueNasRestMethod("sharing/webdav" , "GET")
                                return $reponse
                    }
    [object]getsharingwebdavget_instance()
                    {
                                $reponse = .TrueNasRestMethod("sharing/webdav/get_instance" , "GET")
                                return $reponse
                    }
}
