class TrueNasConfiguration
{
    [String] $CommonName
    [String]$Uri
    [PSobject]$Params

    TrueNasConfiguration([TrueNasServer]$param)
    {
        $this.CommonName = $param.CommonName
        $this.Uri = $param.Uri
        $this.Params = $param.Params
    }
    TrueNasConfiguration([TrueNasConfiguration]$param)
    {
        $this.CommonName = $param.CommonName
        $this.Uri = $param.Uri
        $this.Params = $param.Params
    }
    [object]TrueNasRestMethod([String]$Url, [string]$Method)
    {
        $response = $null
        if ([enum]::GetNames("Action").Contains($Method))
        {
            $This.Uri = $This.Uri + "/" + "$Url"
            $settings = @{
                Uri                  = $This.Uri
                Method               = $Method
                WebSession           = $this.Params.Session
                SkipCertificateCheck = $true
                UseBasicParsing      = $true

            }
            try
            {
                $response = Invoke-RestMethod  @settings
            }
            catch
            {
                throw "Unable to use TrueNAS API"
            }
        }
        else
        {
            throw "The Method is not recognozied or available"
        }
        $This.Uri = $this.BaseUri
        return $response
    }
    [object]TrueNasRestMethod([String]$Url, [string]$Method, [psobject]$Body)
    {
        $response = $null
        if ([enum]::GetNames("Action").Contains($Method))
        {
            $This.Uri = $This.Uri + "/" + "$Url"
            $settings = @{
                Uri                  = $This.Uri
                Method               = $Method
                $Body                = ($Body | ConvertTo-Json -Compress -Depth 5)
                WebSession           = $this.Params.Session
                SkipCertificateCheck = $true
                UseBasicParsing      = $true

            }
            try
            {
                $response = Invoke-RestMethod  @settings
            }
            catch
            {
                #Show-TrueNasException $_
                throw "Unable to use TrueNAS API"
            }
        }
        else
        {
            throw "The Method is not recognozied or available"
        }
        $This.Uri = $this.BaseUri
        return $response
    }
}
class TrueNasacme :TrueNasConfiguration
{
    [String]$CommonName
    [String]$Uri
    [PSobject]$Params

    TrueNasacme([TrueNasConfiguration]$param):base()
    {
    }
    [object]postacmednsauthenticator([psobject]$Body)
    {
        $reponse = .TrueNasRestMethod("acme/dns/authenticator" , "POST", $Body)
        return $reponse
    }
    [object]getacmednsauthenticator()
    {
        $reponse = .TrueNasRestMethod("acme/dns/authenticator" , "GET")
        return $reponse
    }
    [object]getacmednsauthenticatorauthenticator_schemas()
    {
        $reponse = .TrueNasRestMethod("acme/dns/authenticator/authenticator_schemas" , "GET")
        return $reponse
    }
    [object]getacmednsauthenticatorget_instance()
    {
        $reponse = .TrueNasRestMethod("acme/dns/authenticator/get_instance" , "GET")
        return $reponse
    }
}
class TrueNasactivedirectory :TrueNasConfiguration
{
    [String]$CommonName
    [String]$Uri
    [PSobject]$Params

    TrueNasactivedirectory([TrueNasConfiguration]$param):base()
    {
    }
    [object]putactivedirectory([psobject]$Body)
    {
        $reponse = .TrueNasRestMethod("activedirectory" , "PUT", $Body)
        return $reponse
    }
    [object]getactivedirectory()
    {
        $reponse = .TrueNasRestMethod("activedirectory" , "GET")
        return $reponse
    }
    [object]getactivedirectorychange_trust_account_pw()
    {
        $reponse = .TrueNasRestMethod("activedirectory/change_trust_account_pw" , "GET")
        return $reponse
    }
    [object]getactivedirectorydomain_info()
    {
        $reponse = .TrueNasRestMethod("activedirectory/domain_info" , "GET")
        return $reponse
    }
    [object]getactivedirectoryget_spn_list()
    {
        $reponse = .TrueNasRestMethod("activedirectory/get_spn_list" , "GET")
        return $reponse
    }
    [object]getactivedirectoryget_state()
    {
        $reponse = .TrueNasRestMethod("activedirectory/get_state" , "GET")
        return $reponse
    }
    [object]postactivedirectoryleave([psobject]$Body)
    {
        $reponse = .TrueNasRestMethod("activedirectory/leave" , "POST", $Body)
        return $reponse
    }
    [object]getactivedirectorynss_info_choices()
    {
        $reponse = .TrueNasRestMethod("activedirectory/nss_info_choices" , "GET")
        return $reponse
    }
    [object]getactivedirectorysasl_wrapping_choices()
    {
        $reponse = .TrueNasRestMethod("activedirectory/sasl_wrapping_choices" , "GET")
        return $reponse
    }
    [object]getactivedirectoryssl_choices()
    {
        $reponse = .TrueNasRestMethod("activedirectory/ssl_choices" , "GET")
        return $reponse
    }
    [object]getactivedirectorystarted()
    {
        $reponse = .TrueNasRestMethod("activedirectory/started" , "GET")
        return $reponse
    }
}
class TrueNasafp :TrueNasConfiguration
{
    [String]$CommonName
    [String]$Uri
    [PSobject]$Params

    TrueNasafp([TrueNasConfiguration]$param):base()
    {
    }
    [object]putafp([psobject]$Body)
    {
        $reponse = .TrueNasRestMethod("afp" , "PUT", $Body)
        return $reponse
    }
    [object]getafp()
    {
        $reponse = .TrueNasRestMethod("afp" , "GET")
        return $reponse
    }
    [object]getafpbindip_choices()
    {
        $reponse = .TrueNasRestMethod("afp/bindip_choices" , "GET")
        return $reponse
    }
}
class TrueNasalert :TrueNasConfiguration
{
    [String]$CommonName
    [String]$Uri
    [PSobject]$Params

    TrueNasalert([TrueNasConfiguration]$param):base()
    {
    }
    [object]postalertdismiss([psobject]$Body)
    {
        $reponse = .TrueNasRestMethod("alert/dismiss" , "POST", $Body)
        return $reponse
    }
    [object]getalertlist()
    {
        $reponse = .TrueNasRestMethod("alert/list" , "GET")
        return $reponse
    }
    [object]getalertlist_categories()
    {
        $reponse = .TrueNasRestMethod("alert/list_categories" , "GET")
        return $reponse
    }
    [object]getalertlist_policies()
    {
        $reponse = .TrueNasRestMethod("alert/list_policies" , "GET")
        return $reponse
    }
    [object]postalertrestore([psobject]$Body)
    {
        $reponse = .TrueNasRestMethod("alert/restore" , "POST", $Body)
        return $reponse
    }
}
class TrueNasalertclasses :TrueNasConfiguration
{
    [String]$CommonName
    [String]$Uri
    [PSobject]$Params

    TrueNasalertclasses([TrueNasConfiguration]$param):base()
    {
    }
    [object]putalertclasses([psobject]$Body)
    {
        $reponse = .TrueNasRestMethod("alertclasses" , "PUT", $Body)
        return $reponse
    }
    [object]getalertclasses()
    {
        $reponse = .TrueNasRestMethod("alertclasses" , "GET")
        return $reponse
    }
}
class TrueNasalertservice :TrueNasConfiguration
{
    [String]$CommonName
    [String]$Uri
    [PSobject]$Params

    TrueNasalertservice([TrueNasConfiguration]$param):base()
    {
    }
    [object]postalertservice([psobject]$Body)
    {
        $reponse = .TrueNasRestMethod("alertservice" , "POST", $Body)
        return $reponse
    }
    [object]getalertservice()
    {
        $reponse = .TrueNasRestMethod("alertservice" , "GET")
        return $reponse
    }
    [object]getalertserviceget_instance()
    {
        $reponse = .TrueNasRestMethod("alertservice/get_instance" , "GET")
        return $reponse
    }
    [object]getalertservicelist_types()
    {
        $reponse = .TrueNasRestMethod("alertservice/list_types" , "GET")
        return $reponse
    }
    [object]postalertservicetest([psobject]$Body)
    {
        $reponse = .TrueNasRestMethod("alertservice/test" , "POST", $Body)
        return $reponse
    }
}
class TrueNasapi_key :TrueNasConfiguration
{
    [String]$CommonName
    [String]$Uri
    [PSobject]$Params

    TrueNasapi_key([TrueNasConfiguration]$param):base()
    {
    }
    [object]postapi_key([psobject]$Body)
    {
        $reponse = .TrueNasRestMethod("api_key" , "POST", $Body)
        return $reponse
    }
    [object]getapi_key()
    {
        $reponse = .TrueNasRestMethod("api_key" , "GET")
        return $reponse
    }
    [object]getapi_keyget_instance()
    {
        $reponse = .TrueNasRestMethod("api_key/get_instance" , "GET")
        return $reponse
    }
}
class TrueNasauth :TrueNasConfiguration
{
    [String]$CommonName
    [String]$Uri
    [PSobject]$Params

    TrueNasauth([TrueNasConfiguration]$param):base()
    {
    }
    [object]postauthcheck_user([psobject]$Body)
    {
        $reponse = .TrueNasRestMethod("auth/check_user" , "POST", $Body)
        return $reponse
    }
    [object]postauthgenerate_token([psobject]$Body)
    {
        $reponse = .TrueNasRestMethod("auth/generate_token" , "POST", $Body)
        return $reponse
    }
    [object]getauthsessions()
    {
        $reponse = .TrueNasRestMethod("auth/sessions" , "GET")
        return $reponse
    }
    [object]getauthtwo_factor_auth()
    {
        $reponse = .TrueNasRestMethod("auth/two_factor_auth" , "GET")
        return $reponse
    }
    [object]putauthtwofactor([psobject]$Body)
    {
        $reponse = .TrueNasRestMethod("auth/twofactor" , "PUT", $Body)
        return $reponse
    }
    [object]getauthtwofactor()
    {
        $reponse = .TrueNasRestMethod("auth/twofactor" , "GET")
        return $reponse
    }
    [object]getauthtwofactorprovisioning_uri()
    {
        $reponse = .TrueNasRestMethod("auth/twofactor/provisioning_uri" , "GET")
        return $reponse
    }
    [object]getauthtwofactorrenew_secret()
    {
        $reponse = .TrueNasRestMethod("auth/twofactor/renew_secret" , "GET")
        return $reponse
    }
    [object]postauthtwofactorverify([psobject]$Body)
    {
        $reponse = .TrueNasRestMethod("auth/twofactor/verify" , "POST", $Body)
        return $reponse
    }
}
class TrueNasboot :TrueNasConfiguration
{
    [String]$CommonName
    [String]$Uri
    [PSobject]$Params

    TrueNasboot([TrueNasConfiguration]$param):base()
    {
    }
    [object]postbootattach([psobject]$Body)
    {
        $reponse = .TrueNasRestMethod("boot/attach" , "POST", $Body)
        return $reponse
    }
    [object]postbootdetach([psobject]$Body)
    {
        $reponse = .TrueNasRestMethod("boot/detach" , "POST", $Body)
        return $reponse
    }
    [object]getbootget_disks()
    {
        $reponse = .TrueNasRestMethod("boot/get_disks" , "GET")
        return $reponse
    }
    [object]getbootget_scrub_interval()
    {
        $reponse = .TrueNasRestMethod("boot/get_scrub_interval" , "GET")
        return $reponse
    }
    [object]getbootget_state()
    {
        $reponse = .TrueNasRestMethod("boot/get_state" , "GET")
        return $reponse
    }
    [object]postbootreplace([psobject]$Body)
    {
        $reponse = .TrueNasRestMethod("boot/replace" , "POST", $Body)
        return $reponse
    }
    [object]getbootscrub()
    {
        $reponse = .TrueNasRestMethod("boot/scrub" , "GET")
        return $reponse
    }
    [object]postbootset_scrub_interval([psobject]$Body)
    {
        $reponse = .TrueNasRestMethod("boot/set_scrub_interval" , "POST", $Body)
        return $reponse
    }
}
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
class TrueNascertificate :TrueNasConfiguration
{
    [String]$CommonName
    [String]$Uri
    [PSobject]$Params

    TrueNascertificate([TrueNasConfiguration]$param):base()
    {
    }
    [object]postcertificate([psobject]$Body)
    {
        $reponse = .TrueNasRestMethod("certificate" , "POST", $Body)
        return $reponse
    }
    [object]getcertificate()
    {
        $reponse = .TrueNasRestMethod("certificate" , "GET")
        return $reponse
    }
    [object]getcertificateacme_server_choices()
    {
        $reponse = .TrueNasRestMethod("certificate/acme_server_choices" , "GET")
        return $reponse
    }
    [object]getcertificatecountry_choices()
    {
        $reponse = .TrueNasRestMethod("certificate/country_choices" , "GET")
        return $reponse
    }
    [object]getcertificateec_curve_choices()
    {
        $reponse = .TrueNasRestMethod("certificate/ec_curve_choices" , "GET")
        return $reponse
    }
    [object]getcertificateextended_key_usage_choices()
    {
        $reponse = .TrueNasRestMethod("certificate/extended_key_usage_choices" , "GET")
        return $reponse
    }
    [object]getcertificateget_instance()
    {
        $reponse = .TrueNasRestMethod("certificate/get_instance" , "GET")
        return $reponse
    }
    [object]getcertificatekey_type_choices()
    {
        $reponse = .TrueNasRestMethod("certificate/key_type_choices" , "GET")
        return $reponse
    }
    [object]getcertificateprofiles()
    {
        $reponse = .TrueNasRestMethod("certificate/profiles" , "GET")
        return $reponse
    }
}
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
class TrueNascloudsync :TrueNasConfiguration
{
    [String]$CommonName
    [String]$Uri
    [PSobject]$Params

    TrueNascloudsync([TrueNasConfiguration]$param):base()
    {
    }
    [object]postcloudsync([psobject]$Body)
    {
        $reponse = .TrueNasRestMethod("cloudsync" , "POST", $Body)
        return $reponse
    }
    [object]getcloudsync()
    {
        $reponse = .TrueNasRestMethod("cloudsync" , "GET")
        return $reponse
    }
    [object]getcloudsynccommon_task_schema()
    {
        $reponse = .TrueNasRestMethod("cloudsync/common_task_schema" , "GET")
        return $reponse
    }
    [object]postcloudsynccredentials([psobject]$Body)
    {
        $reponse = .TrueNasRestMethod("cloudsync/credentials" , "POST", $Body)
        return $reponse
    }
    [object]getcloudsynccredentials()
    {
        $reponse = .TrueNasRestMethod("cloudsync/credentials" , "GET")
        return $reponse
    }
    [object]getcloudsynccredentialsget_instance()
    {
        $reponse = .TrueNasRestMethod("cloudsync/credentials/get_instance" , "GET")
        return $reponse
    }
    [object]postcloudsynccredentialsverify([psobject]$Body)
    {
        $reponse = .TrueNasRestMethod("cloudsync/credentials/verify" , "POST", $Body)
        return $reponse
    }
    [object]getcloudsyncget_instance()
    {
        $reponse = .TrueNasRestMethod("cloudsync/get_instance" , "GET")
        return $reponse
    }
    [object]postcloudsynclist_buckets([psobject]$Body)
    {
        $reponse = .TrueNasRestMethod("cloudsync/list_buckets" , "POST", $Body)
        return $reponse
    }
    [object]postcloudsynclist_directory([psobject]$Body)
    {
        $reponse = .TrueNasRestMethod("cloudsync/list_directory" , "POST", $Body)
        return $reponse
    }
    [object]postcloudsynconedrive_list_drives([psobject]$Body)
    {
        $reponse = .TrueNasRestMethod("cloudsync/onedrive_list_drives" , "POST", $Body)
        return $reponse
    }
    [object]getcloudsyncproviders()
    {
        $reponse = .TrueNasRestMethod("cloudsync/providers" , "GET")
        return $reponse
    }
    [object]postcloudsyncsync_onetime([psobject]$Body)
    {
        $reponse = .TrueNasRestMethod("cloudsync/sync_onetime" , "POST", $Body)
        return $reponse
    }
}
class TrueNasconfig :TrueNasConfiguration
{
    [String]$CommonName
    [String]$Uri
    [PSobject]$Params

    TrueNasconfig([TrueNasConfiguration]$param):base()
    {
    }
    [object]postconfigreset([psobject]$Body)
    {
        $reponse = .TrueNasRestMethod("config/reset" , "POST", $Body)
        return $reponse
    }
}
class TrueNascore :TrueNasConfiguration
{
    [String]$CommonName
    [String]$Uri
    [PSobject]$Params

    TrueNascore([TrueNasConfiguration]$param):base()
    {
    }
    [object]postcorebulk([psobject]$Body)
    {
        $reponse = .TrueNasRestMethod("core/bulk" , "POST", $Body)
        return $reponse
    }
    [object]postcoredebug([psobject]$Body)
    {
        $reponse = .TrueNasRestMethod("core/debug" , "POST", $Body)
        return $reponse
    }
    [object]postcoredownload([psobject]$Body)
    {
        $reponse = .TrueNasRestMethod("core/download" , "POST", $Body)
        return $reponse
    }
    [object]getcoreget_events()
    {
        $reponse = .TrueNasRestMethod("core/get_events" , "GET")
        return $reponse
    }
    [object]getcoreget_jobs()
    {
        $reponse = .TrueNasRestMethod("core/get_jobs" , "GET")
        return $reponse
    }
    [object]postcoreget_methods([psobject]$Body)
    {
        $reponse = .TrueNasRestMethod("core/get_methods" , "POST", $Body)
        return $reponse
    }
    [object]getcoreget_services()
    {
        $reponse = .TrueNasRestMethod("core/get_services" , "GET")
        return $reponse
    }
    [object]postcorejob_abort([psobject]$Body)
    {
        $reponse = .TrueNasRestMethod("core/job_abort" , "POST", $Body)
        return $reponse
    }
    [object]postcorejob_update([psobject]$Body)
    {
        $reponse = .TrueNasRestMethod("core/job_update" , "POST", $Body)
        return $reponse
    }
    [object]postcorejob_wait([psobject]$Body)
    {
        $reponse = .TrueNasRestMethod("core/job_wait" , "POST", $Body)
        return $reponse
    }
    [object]getcoreping()
    {
        $reponse = .TrueNasRestMethod("core/ping" , "GET")
        return $reponse
    }
    [object]postcoreresize_shell([psobject]$Body)
    {
        $reponse = .TrueNasRestMethod("core/resize_shell" , "POST", $Body)
        return $reponse
    }
    [object]getcoresessions()
    {
        $reponse = .TrueNasRestMethod("core/sessions" , "GET")
        return $reponse
    }
}
class TrueNascronjob :TrueNasConfiguration
{
    [String]$CommonName
    [String]$Uri
    [PSobject]$Params

    TrueNascronjob([TrueNasConfiguration]$param):base()
    {
    }
    [object]postcronjob([psobject]$Body)
    {
        $reponse = .TrueNasRestMethod("cronjob" , "POST", $Body)
        return $reponse
    }
    [object]getcronjob()
    {
        $reponse = .TrueNasRestMethod("cronjob" , "GET")
        return $reponse
    }
    [object]getcronjobget_instance()
    {
        $reponse = .TrueNasRestMethod("cronjob/get_instance" , "GET")
        return $reponse
    }
    [object]postcronjobrun([psobject]$Body)
    {
        $reponse = .TrueNasRestMethod("cronjob/run" , "POST", $Body)
        return $reponse
    }
}
class TrueNasdevice :TrueNasConfiguration
{
    [String]$CommonName
    [String]$Uri
    [PSobject]$Params

    TrueNasdevice([TrueNasConfiguration]$param):base()
    {
    }
    [object]postdeviceget_info([psobject]$Body)
    {
        $reponse = .TrueNasRestMethod("device/get_info" , "POST", $Body)
        return $reponse
    }
}
class TrueNasdirectoryservices :TrueNasConfiguration
{
    [String]$CommonName
    [String]$Uri
    [PSobject]$Params

    TrueNasdirectoryservices([TrueNasConfiguration]$param):base()
    {
    }
    [object]getdirectoryservicescache_refresh()
    {
        $reponse = .TrueNasRestMethod("directoryservices/cache_refresh" , "GET")
        return $reponse
    }
    [object]getdirectoryservicesget_state()
    {
        $reponse = .TrueNasRestMethod("directoryservices/get_state" , "GET")
        return $reponse
    }
}
class TrueNasdisk :TrueNasConfiguration
{
    [String]$CommonName
    [String]$Uri
    [PSobject]$Params

    TrueNasdisk([TrueNasConfiguration]$param):base()
    {
    }
    [object]getdisk()
    {
        $reponse = .TrueNasRestMethod("disk" , "GET")
        return $reponse
    }
    [object]postdiskget_encrypted([psobject]$Body)
    {
        $reponse = .TrueNasRestMethod("disk/get_encrypted" , "POST", $Body)
        return $reponse
    }
    [object]getdiskget_instance()
    {
        $reponse = .TrueNasRestMethod("disk/get_instance" , "GET")
        return $reponse
    }
    [object]postdiskget_unused([psobject]$Body)
    {
        $reponse = .TrueNasRestMethod("disk/get_unused" , "POST", $Body)
        return $reponse
    }
    [object]getdisklabel_to_dev()
    {
        $reponse = .TrueNasRestMethod("disk/label_to_dev" , "GET")
        return $reponse
    }
    [object]postdiskoverprovision([psobject]$Body)
    {
        $reponse = .TrueNasRestMethod("disk/overprovision" , "POST", $Body)
        return $reponse
    }
    [object]postdisksmart_attributes([psobject]$Body)
    {
        $reponse = .TrueNasRestMethod("disk/smart_attributes" , "POST", $Body)
        return $reponse
    }
    [object]postdiskspindown([psobject]$Body)
    {
        $reponse = .TrueNasRestMethod("disk/spindown" , "POST", $Body)
        return $reponse
    }
    [object]postdisktemperature([psobject]$Body)
    {
        $reponse = .TrueNasRestMethod("disk/temperature" , "POST", $Body)
        return $reponse
    }
    [object]postdisktemperatures([psobject]$Body)
    {
        $reponse = .TrueNasRestMethod("disk/temperatures" , "POST", $Body)
        return $reponse
    }
    [object]postdiskunoverprovision([psobject]$Body)
    {
        $reponse = .TrueNasRestMethod("disk/unoverprovision" , "POST", $Body)
        return $reponse
    }
    [object]postdiskwipe([psobject]$Body)
    {
        $reponse = .TrueNasRestMethod("disk/wipe" , "POST", $Body)
        return $reponse
    }
}
class TrueNasdns :TrueNasConfiguration
{
    [String]$CommonName
    [String]$Uri
    [PSobject]$Params

    TrueNasdns([TrueNasConfiguration]$param):base()
    {
    }
    [object]getdnsquery()
    {
        $reponse = .TrueNasRestMethod("dns/query" , "GET")
        return $reponse
    }
}
class TrueNasdyndns :TrueNasConfiguration
{
    [String]$CommonName
    [String]$Uri
    [PSobject]$Params

    TrueNasdyndns([TrueNasConfiguration]$param):base()
    {
    }
    [object]putdyndns([psobject]$Body)
    {
        $reponse = .TrueNasRestMethod("dyndns" , "PUT", $Body)
        return $reponse
    }
    [object]getdyndns()
    {
        $reponse = .TrueNasRestMethod("dyndns" , "GET")
        return $reponse
    }
    [object]getdyndnsprovider_choices()
    {
        $reponse = .TrueNasRestMethod("dyndns/provider_choices" , "GET")
        return $reponse
    }
}
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
class TrueNasfailover :TrueNasConfiguration
{
    [String]$CommonName
    [String]$Uri
    [PSobject]$Params

    TrueNasfailover([TrueNasConfiguration]$param):base()
    {
    }
    [object]putfailover([psobject]$Body)
    {
        $reponse = .TrueNasRestMethod("failover" , "PUT", $Body)
        return $reponse
    }
    [object]getfailover()
    {
        $reponse = .TrueNasRestMethod("failover" , "GET")
        return $reponse
    }
    [object]postfailovercall_remote([psobject]$Body)
    {
        $reponse = .TrueNasRestMethod("failover/call_remote" , "POST", $Body)
        return $reponse
    }
    [object]postfailovercontrol([psobject]$Body)
    {
        $reponse = .TrueNasRestMethod("failover/control" , "POST", $Body)
        return $reponse
    }
    [object]getfailoverforce_master()
    {
        $reponse = .TrueNasRestMethod("failover/force_master" , "GET")
        return $reponse
    }
    [object]getfailoverhardware()
    {
        $reponse = .TrueNasRestMethod("failover/hardware" , "GET")
        return $reponse
    }
    [object]getfailoverin_progress()
    {
        $reponse = .TrueNasRestMethod("failover/in_progress" , "GET")
        return $reponse
    }
    [object]getfailoverlicensed()
    {
        $reponse = .TrueNasRestMethod("failover/licensed" , "GET")
        return $reponse
    }
    [object]getfailovernode()
    {
        $reponse = .TrueNasRestMethod("failover/node" , "GET")
        return $reponse
    }
    [object]getfailoversync_from_peer()
    {
        $reponse = .TrueNasRestMethod("failover/sync_from_peer" , "GET")
        return $reponse
    }
    [object]postfailoversync_to_peer([psobject]$Body)
    {
        $reponse = .TrueNasRestMethod("failover/sync_to_peer" , "POST", $Body)
        return $reponse
    }
    [object]postfailoverunlock([psobject]$Body)
    {
        $reponse = .TrueNasRestMethod("failover/unlock" , "POST", $Body)
        return $reponse
    }
    [object]postfailoverupgrade([psobject]$Body)
    {
        $reponse = .TrueNasRestMethod("failover/upgrade" , "POST", $Body)
        return $reponse
    }
    [object]getfailoverupgrade_finish()
    {
        $reponse = .TrueNasRestMethod("failover/upgrade_finish" , "GET")
        return $reponse
    }
    [object]getfailoverupgrade_pending()
    {
        $reponse = .TrueNasRestMethod("failover/upgrade_pending" , "GET")
        return $reponse
    }
}
class TrueNasfcport :TrueNasConfiguration
{
    [String]$CommonName
    [String]$Uri
    [PSobject]$Params

    TrueNasfcport([TrueNasConfiguration]$param):base()
    {
    }
    [object]getfcport()
    {
        $reponse = .TrueNasRestMethod("fcport" , "GET")
        return $reponse
    }
    [object]getfcportget_instance()
    {
        $reponse = .TrueNasRestMethod("fcport/get_instance" , "GET")
        return $reponse
    }
}
class TrueNasfilesystem :TrueNasConfiguration
{
    [String]$CommonName
    [String]$Uri
    [PSobject]$Params

    TrueNasfilesystem([TrueNasConfiguration]$param):base()
    {
    }
    [object]postfilesystemacl_is_trivial([psobject]$Body)
    {
        $reponse = .TrueNasRestMethod("filesystem/acl_is_trivial" , "POST", $Body)
        return $reponse
    }
    [object]postfilesystemchown([psobject]$Body)
    {
        $reponse = .TrueNasRestMethod("filesystem/chown" , "POST", $Body)
        return $reponse
    }
    [object]getfilesystemdefault_acl_choices()
    {
        $reponse = .TrueNasRestMethod("filesystem/default_acl_choices" , "GET")
        return $reponse
    }
    [object]postfilesystemget_default_acl([psobject]$Body)
    {
        $reponse = .TrueNasRestMethod("filesystem/get_default_acl" , "POST", $Body)
        return $reponse
    }
    [object]postfilesystemgetacl([psobject]$Body)
    {
        $reponse = .TrueNasRestMethod("filesystem/getacl" , "POST", $Body)
        return $reponse
    }
    [object]postfilesystemlistdir([psobject]$Body)
    {
        $reponse = .TrueNasRestMethod("filesystem/listdir" , "POST", $Body)
        return $reponse
    }
    [object]postfilesystemsetacl([psobject]$Body)
    {
        $reponse = .TrueNasRestMethod("filesystem/setacl" , "POST", $Body)
        return $reponse
    }
    [object]postfilesystemsetperm([psobject]$Body)
    {
        $reponse = .TrueNasRestMethod("filesystem/setperm" , "POST", $Body)
        return $reponse
    }
    [object]postfilesystemstat([psobject]$Body)
    {
        $reponse = .TrueNasRestMethod("filesystem/stat" , "POST", $Body)
        return $reponse
    }
    [object]postfilesystemstatfs([psobject]$Body)
    {
        $reponse = .TrueNasRestMethod("filesystem/statfs" , "POST", $Body)
        return $reponse
    }
}
class TrueNasftp :TrueNasConfiguration
{
    [String]$CommonName
    [String]$Uri
    [PSobject]$Params

    TrueNasftp([TrueNasConfiguration]$param):base()
    {
    }
    [object]putftp([psobject]$Body)
    {
        $reponse = .TrueNasRestMethod("ftp" , "PUT", $Body)
        return $reponse
    }
    [object]getftp()
    {
        $reponse = .TrueNasRestMethod("ftp" , "GET")
        return $reponse
    }
}
class TrueNasgroup :TrueNasConfiguration
{
    [String]$CommonName
    [String]$Uri
    [PSobject]$Params

    TrueNasgroup([TrueNasConfiguration]$param):base()
    {
    }
    [object]postgroup([psobject]$Body)
    {
        $reponse = .TrueNasRestMethod("group" , "POST", $Body)
        return $reponse
    }
    [object]getgroup()
    {
        $reponse = .TrueNasRestMethod("group" , "GET")
        return $reponse
    }
    [object]postgroupget_group_obj([psobject]$Body)
    {
        $reponse = .TrueNasRestMethod("group/get_group_obj" , "POST", $Body)
        return $reponse
    }
    [object]getgroupget_instance()
    {
        $reponse = .TrueNasRestMethod("group/get_instance" , "GET")
        return $reponse
    }
    [object]getgroupget_next_gid()
    {
        $reponse = .TrueNasRestMethod("group/get_next_gid" , "GET")
        return $reponse
    }
}
class TrueNasidmap :TrueNasConfiguration
{
    [String]$CommonName
    [String]$Uri
    [PSobject]$Params

    TrueNasidmap([TrueNasConfiguration]$param):base()
    {
    }
    [object]postidmap([psobject]$Body)
    {
        $reponse = .TrueNasRestMethod("idmap" , "POST", $Body)
        return $reponse
    }
    [object]getidmap()
    {
        $reponse = .TrueNasRestMethod("idmap" , "GET")
        return $reponse
    }
    [object]getidmapbackend_choices()
    {
        $reponse = .TrueNasRestMethod("idmap/backend_choices" , "GET")
        return $reponse
    }
    [object]getidmapbackend_options()
    {
        $reponse = .TrueNasRestMethod("idmap/backend_options" , "GET")
        return $reponse
    }
    [object]getidmapclear_idmap_cache()
    {
        $reponse = .TrueNasRestMethod("idmap/clear_idmap_cache" , "GET")
        return $reponse
    }
    [object]getidmapget_instance()
    {
        $reponse = .TrueNasRestMethod("idmap/get_instance" , "GET")
        return $reponse
    }
    [object]postidmapoptions_choices([psobject]$Body)
    {
        $reponse = .TrueNasRestMethod("idmap/options_choices" , "POST", $Body)
        return $reponse
    }
}
class TrueNasinitshutdownscript :TrueNasConfiguration
{
    [String]$CommonName
    [String]$Uri
    [PSobject]$Params

    TrueNasinitshutdownscript([TrueNasConfiguration]$param):base()
    {
    }
    [object]postinitshutdownscript([psobject]$Body)
    {
        $reponse = .TrueNasRestMethod("initshutdownscript" , "POST", $Body)
        return $reponse
    }
    [object]getinitshutdownscript()
    {
        $reponse = .TrueNasRestMethod("initshutdownscript" , "GET")
        return $reponse
    }
    [object]getinitshutdownscriptget_instance()
    {
        $reponse = .TrueNasRestMethod("initshutdownscript/get_instance" , "GET")
        return $reponse
    }
}
class TrueNasinterface :TrueNasConfiguration
{
    [String]$CommonName
    [String]$Uri
    [PSobject]$Params

    TrueNasinterface([TrueNasConfiguration]$param):base()
    {
    }
    [object]postinterface([psobject]$Body)
    {
        $reponse = .TrueNasRestMethod("interface" , "POST", $Body)
        return $reponse
    }
    [object]getinterface()
    {
        $reponse = .TrueNasRestMethod("interface" , "GET")
        return $reponse
    }
    [object]postinterfacebridge_members_choices([psobject]$Body)
    {
        $reponse = .TrueNasRestMethod("interface/bridge_members_choices" , "POST", $Body)
        return $reponse
    }
    [object]getinterfacebridge_setup()
    {
        $reponse = .TrueNasRestMethod("interface/bridge_setup" , "GET")
        return $reponse
    }
    [object]getinterfacecheckin()
    {
        $reponse = .TrueNasRestMethod("interface/checkin" , "GET")
        return $reponse
    }
    [object]getinterfacecheckin_waiting()
    {
        $reponse = .TrueNasRestMethod("interface/checkin_waiting" , "GET")
        return $reponse
    }
    [object]postinterfacechoices([psobject]$Body)
    {
        $reponse = .TrueNasRestMethod("interface/choices" , "POST", $Body)
        return $reponse
    }
    [object]postinterfacecommit([psobject]$Body)
    {
        $reponse = .TrueNasRestMethod("interface/commit" , "POST", $Body)
        return $reponse
    }
    [object]getinterfaceget_instance()
    {
        $reponse = .TrueNasRestMethod("interface/get_instance" , "GET")
        return $reponse
    }
    [object]getinterfacehas_pending_changes()
    {
        $reponse = .TrueNasRestMethod("interface/has_pending_changes" , "GET")
        return $reponse
    }
    [object]postinterfaceip_in_use([psobject]$Body)
    {
        $reponse = .TrueNasRestMethod("interface/ip_in_use" , "POST", $Body)
        return $reponse
    }
    [object]postinterfacelag_ports_choices([psobject]$Body)
    {
        $reponse = .TrueNasRestMethod("interface/lag_ports_choices" , "POST", $Body)
        return $reponse
    }
    [object]getinterfacelag_setup()
    {
        $reponse = .TrueNasRestMethod("interface/lag_setup" , "GET")
        return $reponse
    }
    [object]getinterfacerollback()
    {
        $reponse = .TrueNasRestMethod("interface/rollback" , "GET")
        return $reponse
    }
    [object]getinterfacevlan_parent_interface_choices()
    {
        $reponse = .TrueNasRestMethod("interface/vlan_parent_interface_choices" , "GET")
        return $reponse
    }
    [object]getinterfacevlan_setup()
    {
        $reponse = .TrueNasRestMethod("interface/vlan_setup" , "GET")
        return $reponse
    }
}
class TrueNasipmi :TrueNasConfiguration
{
    [String]$CommonName
    [String]$Uri
    [PSobject]$Params

    TrueNasipmi([TrueNasConfiguration]$param):base()
    {
    }
    [object]getipmi()
    {
        $reponse = .TrueNasRestMethod("ipmi" , "GET")
        return $reponse
    }
    [object]getipmichannels()
    {
        $reponse = .TrueNasRestMethod("ipmi/channels" , "GET")
        return $reponse
    }
    [object]getipmiget_instance()
    {
        $reponse = .TrueNasRestMethod("ipmi/get_instance" , "GET")
        return $reponse
    }
    [object]postipmiidentify([psobject]$Body)
    {
        $reponse = .TrueNasRestMethod("ipmi/identify" , "POST", $Body)
        return $reponse
    }
    [object]getipmiis_loaded()
    {
        $reponse = .TrueNasRestMethod("ipmi/is_loaded" , "GET")
        return $reponse
    }
}
class TrueNasiscsi :TrueNasConfiguration
{
    [String]$CommonName
    [String]$Uri
    [PSobject]$Params

    TrueNasiscsi([TrueNasConfiguration]$param):base()
    {
    }
    [object]postiscsiauth([psobject]$Body)
    {
        $reponse = .TrueNasRestMethod("iscsi/auth" , "POST", $Body)
        return $reponse
    }
    [object]getiscsiauth()
    {
        $reponse = .TrueNasRestMethod("iscsi/auth" , "GET")
        return $reponse
    }
    [object]getiscsiauthget_instance()
    {
        $reponse = .TrueNasRestMethod("iscsi/auth/get_instance" , "GET")
        return $reponse
    }
    [object]postiscsiextent([psobject]$Body)
    {
        $reponse = .TrueNasRestMethod("iscsi/extent" , "POST", $Body)
        return $reponse
    }
    [object]getiscsiextent()
    {
        $reponse = .TrueNasRestMethod("iscsi/extent" , "GET")
        return $reponse
    }
    [object]postiscsiextentdisk_choices([psobject]$Body)
    {
        $reponse = .TrueNasRestMethod("iscsi/extent/disk_choices" , "POST", $Body)
        return $reponse
    }
    [object]getiscsiextentget_instance()
    {
        $reponse = .TrueNasRestMethod("iscsi/extent/get_instance" , "GET")
        return $reponse
    }
    [object]putiscsiglobal([psobject]$Body)
    {
        $reponse = .TrueNasRestMethod("iscsi/global" , "PUT", $Body)
        return $reponse
    }
    [object]getiscsiglobal()
    {
        $reponse = .TrueNasRestMethod("iscsi/global" , "GET")
        return $reponse
    }
    [object]getiscsiglobalalua_enabled()
    {
        $reponse = .TrueNasRestMethod("iscsi/global/alua_enabled" , "GET")
        return $reponse
    }
    [object]getiscsiglobalsessions()
    {
        $reponse = .TrueNasRestMethod("iscsi/global/sessions" , "GET")
        return $reponse
    }
    [object]postiscsiinitiator([psobject]$Body)
    {
        $reponse = .TrueNasRestMethod("iscsi/initiator" , "POST", $Body)
        return $reponse
    }
    [object]getiscsiinitiator()
    {
        $reponse = .TrueNasRestMethod("iscsi/initiator" , "GET")
        return $reponse
    }
    [object]getiscsiinitiatorget_instance()
    {
        $reponse = .TrueNasRestMethod("iscsi/initiator/get_instance" , "GET")
        return $reponse
    }
    [object]postiscsiportal([psobject]$Body)
    {
        $reponse = .TrueNasRestMethod("iscsi/portal" , "POST", $Body)
        return $reponse
    }
    [object]getiscsiportal()
    {
        $reponse = .TrueNasRestMethod("iscsi/portal" , "GET")
        return $reponse
    }
    [object]getiscsiportalget_instance()
    {
        $reponse = .TrueNasRestMethod("iscsi/portal/get_instance" , "GET")
        return $reponse
    }
    [object]getiscsiportallisten_ip_choices()
    {
        $reponse = .TrueNasRestMethod("iscsi/portal/listen_ip_choices" , "GET")
        return $reponse
    }
    [object]postiscsitarget([psobject]$Body)
    {
        $reponse = .TrueNasRestMethod("iscsi/target" , "POST", $Body)
        return $reponse
    }
    [object]getiscsitarget()
    {
        $reponse = .TrueNasRestMethod("iscsi/target" , "GET")
        return $reponse
    }
    [object]getiscsitargetget_instance()
    {
        $reponse = .TrueNasRestMethod("iscsi/target/get_instance" , "GET")
        return $reponse
    }
    [object]postiscsitargetextent([psobject]$Body)
    {
        $reponse = .TrueNasRestMethod("iscsi/targetextent" , "POST", $Body)
        return $reponse
    }
    [object]getiscsitargetextent()
    {
        $reponse = .TrueNasRestMethod("iscsi/targetextent" , "GET")
        return $reponse
    }
    [object]getiscsitargetextentget_instance()
    {
        $reponse = .TrueNasRestMethod("iscsi/targetextent/get_instance" , "GET")
        return $reponse
    }
}
class TrueNasjail :TrueNasConfiguration
{
    [String]$CommonName
    [String]$Uri
    [PSobject]$Params

    TrueNasjail([TrueNasConfiguration]$param):base()
    {
    }
    [object]postjail([psobject]$Body)
    {
        $reponse = .TrueNasRestMethod("jail" , "POST", $Body)
        return $reponse
    }
    [object]getjail()
    {
        $reponse = .TrueNasRestMethod("jail" , "GET")
        return $reponse
    }
    [object]postjailactivate([psobject]$Body)
    {
        $reponse = .TrueNasRestMethod("jail/activate" , "POST", $Body)
        return $reponse
    }
    [object]postjailclean([psobject]$Body)
    {
        $reponse = .TrueNasRestMethod("jail/clean" , "POST", $Body)
        return $reponse
    }
    [object]getjaildefault_configuration()
    {
        $reponse = .TrueNasRestMethod("jail/default_configuration" , "GET")
        return $reponse
    }
    [object]postjailexec([psobject]$Body)
    {
        $reponse = .TrueNasRestMethod("jail/exec" , "POST", $Body)
        return $reponse
    }
    [object]postjailexport([psobject]$Body)
    {
        $reponse = .TrueNasRestMethod("jail/export" , "POST", $Body)
        return $reponse
    }
    [object]postjailfetch([psobject]$Body)
    {
        $reponse = .TrueNasRestMethod("jail/fetch" , "POST", $Body)
        return $reponse
    }
    [object]postjailfstab([psobject]$Body)
    {
        $reponse = .TrueNasRestMethod("jail/fstab" , "POST", $Body)
        return $reponse
    }
    [object]getjailget_activated_pool()
    {
        $reponse = .TrueNasRestMethod("jail/get_activated_pool" , "GET")
        return $reponse
    }
    [object]getjailget_instance()
    {
        $reponse = .TrueNasRestMethod("jail/get_instance" , "GET")
        return $reponse
    }
    [object]postjailimport_image([psobject]$Body)
    {
        $reponse = .TrueNasRestMethod("jail/import_image" , "POST", $Body)
        return $reponse
    }
    [object]getjailinterface_choices()
    {
        $reponse = .TrueNasRestMethod("jail/interface_choices" , "GET")
        return $reponse
    }
    [object]postjailrc_action([psobject]$Body)
    {
        $reponse = .TrueNasRestMethod("jail/rc_action" , "POST", $Body)
        return $reponse
    }
    [object]postjailreleases_choices([psobject]$Body)
    {
        $reponse = .TrueNasRestMethod("jail/releases_choices" , "POST", $Body)
        return $reponse
    }
    [object]postjailrestart([psobject]$Body)
    {
        $reponse = .TrueNasRestMethod("jail/restart" , "POST", $Body)
        return $reponse
    }
    [object]postjailstart([psobject]$Body)
    {
        $reponse = .TrueNasRestMethod("jail/start" , "POST", $Body)
        return $reponse
    }
    [object]postjailstop([psobject]$Body)
    {
        $reponse = .TrueNasRestMethod("jail/stop" , "POST", $Body)
        return $reponse
    }
    [object]postjailupdate_defaults([psobject]$Body)
    {
        $reponse = .TrueNasRestMethod("jail/update_defaults" , "POST", $Body)
        return $reponse
    }
    [object]postjailupdate_to_latest_patch([psobject]$Body)
    {
        $reponse = .TrueNasRestMethod("jail/update_to_latest_patch" , "POST", $Body)
        return $reponse
    }
}
class TrueNaskerberos :TrueNasConfiguration
{
    [String]$CommonName
    [String]$Uri
    [PSobject]$Params

    TrueNaskerberos([TrueNasConfiguration]$param):base()
    {
    }
    [object]putkerberos([psobject]$Body)
    {
        $reponse = .TrueNasRestMethod("kerberos" , "PUT", $Body)
        return $reponse
    }
    [object]getkerberos()
    {
        $reponse = .TrueNasRestMethod("kerberos" , "GET")
        return $reponse
    }
    [object]postkerberoskeytab([psobject]$Body)
    {
        $reponse = .TrueNasRestMethod("kerberos/keytab" , "POST", $Body)
        return $reponse
    }
    [object]getkerberoskeytab()
    {
        $reponse = .TrueNasRestMethod("kerberos/keytab" , "GET")
        return $reponse
    }
    [object]getkerberoskeytabget_instance()
    {
        $reponse = .TrueNasRestMethod("kerberos/keytab/get_instance" , "GET")
        return $reponse
    }
    [object]getkerberoskeytabsystem_keytab_list()
    {
        $reponse = .TrueNasRestMethod("kerberos/keytab/system_keytab_list" , "GET")
        return $reponse
    }
    [object]postkerberosrealm([psobject]$Body)
    {
        $reponse = .TrueNasRestMethod("kerberos/realm" , "POST", $Body)
        return $reponse
    }
    [object]getkerberosrealm()
    {
        $reponse = .TrueNasRestMethod("kerberos/realm" , "GET")
        return $reponse
    }
    [object]getkerberosrealmget_instance()
    {
        $reponse = .TrueNasRestMethod("kerberos/realm/get_instance" , "GET")
        return $reponse
    }
}
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
class TrueNaskmip :TrueNasConfiguration
{
    [String]$CommonName
    [String]$Uri
    [PSobject]$Params

    TrueNaskmip([TrueNasConfiguration]$param):base()
    {
    }
    [object]putkmip([psobject]$Body)
    {
        $reponse = .TrueNasRestMethod("kmip" , "PUT", $Body)
        return $reponse
    }
    [object]getkmip()
    {
        $reponse = .TrueNasRestMethod("kmip" , "GET")
        return $reponse
    }
    [object]getkmipclear_sync_pending_keys()
    {
        $reponse = .TrueNasRestMethod("kmip/clear_sync_pending_keys" , "GET")
        return $reponse
    }
    [object]getkmipkmip_sync_pending()
    {
        $reponse = .TrueNasRestMethod("kmip/kmip_sync_pending" , "GET")
        return $reponse
    }
    [object]getkmipsync_keys()
    {
        $reponse = .TrueNasRestMethod("kmip/sync_keys" , "GET")
        return $reponse
    }
}
class TrueNasldap :TrueNasConfiguration
{
    [String]$CommonName
    [String]$Uri
    [PSobject]$Params

    TrueNasldap([TrueNasConfiguration]$param):base()
    {
    }
    [object]putldap([psobject]$Body)
    {
        $reponse = .TrueNasRestMethod("ldap" , "PUT", $Body)
        return $reponse
    }
    [object]getldap()
    {
        $reponse = .TrueNasRestMethod("ldap" , "GET")
        return $reponse
    }
    [object]getldapget_state()
    {
        $reponse = .TrueNasRestMethod("ldap/get_state" , "GET")
        return $reponse
    }
    [object]getldapschema_choices()
    {
        $reponse = .TrueNasRestMethod("ldap/schema_choices" , "GET")
        return $reponse
    }
    [object]getldapssl_choices()
    {
        $reponse = .TrueNasRestMethod("ldap/ssl_choices" , "GET")
        return $reponse
    }
}
class TrueNaslldp :TrueNasConfiguration
{
    [String]$CommonName
    [String]$Uri
    [PSobject]$Params

    TrueNaslldp([TrueNasConfiguration]$param):base()
    {
    }
    [object]putlldp([psobject]$Body)
    {
        $reponse = .TrueNasRestMethod("lldp" , "PUT", $Body)
        return $reponse
    }
    [object]getlldp()
    {
        $reponse = .TrueNasRestMethod("lldp" , "GET")
        return $reponse
    }
    [object]getlldpcountry_choices()
    {
        $reponse = .TrueNasRestMethod("lldp/country_choices" , "GET")
        return $reponse
    }
}
class TrueNasmail :TrueNasConfiguration
{
    [String]$CommonName
    [String]$Uri
    [PSobject]$Params

    TrueNasmail([TrueNasConfiguration]$param):base()
    {
    }
    [object]putmail([psobject]$Body)
    {
        $reponse = .TrueNasRestMethod("mail" , "PUT", $Body)
        return $reponse
    }
    [object]getmail()
    {
        $reponse = .TrueNasRestMethod("mail" , "GET")
        return $reponse
    }
    [object]postmailsend([psobject]$Body)
    {
        $reponse = .TrueNasRestMethod("mail/send" , "POST", $Body)
        return $reponse
    }
}
class TrueNasmultipath :TrueNasConfiguration
{
    [String]$CommonName
    [String]$Uri
    [PSobject]$Params

    TrueNasmultipath([TrueNasConfiguration]$param):base()
    {
    }
    [object]getmultipath()
    {
        $reponse = .TrueNasRestMethod("multipath" , "GET")
        return $reponse
    }
    [object]getmultipathget_instance()
    {
        $reponse = .TrueNasRestMethod("multipath/get_instance" , "GET")
        return $reponse
    }
}
class TrueNasnetwork :TrueNasConfiguration
{
    [String]$CommonName
    [String]$Uri
    [PSobject]$Params

    TrueNasnetwork([TrueNasConfiguration]$param):base()
    {
    }
    [object]putnetworkconfiguration([psobject]$Body)
    {
        $reponse = .TrueNasRestMethod("network/configuration" , "PUT", $Body)
        return $reponse
    }
    [object]getnetworkconfiguration()
    {
        $reponse = .TrueNasRestMethod("network/configuration" , "GET")
        return $reponse
    }
    [object]getnetworkgeneralsummary()
    {
        $reponse = .TrueNasRestMethod("network/general/summary" , "GET")
        return $reponse
    }
}
class TrueNasnfs :TrueNasConfiguration
{
    [String]$CommonName
    [String]$Uri
    [PSobject]$Params

    TrueNasnfs([TrueNasConfiguration]$param):base()
    {
    }
    [object]putnfs([psobject]$Body)
    {
        $reponse = .TrueNasRestMethod("nfs" , "PUT", $Body)
        return $reponse
    }
    [object]getnfs()
    {
        $reponse = .TrueNasRestMethod("nfs" , "GET")
        return $reponse
    }
    [object]getnfsbindip_choices()
    {
        $reponse = .TrueNasRestMethod("nfs/bindip_choices" , "GET")
        return $reponse
    }
}
class TrueNasnis :TrueNasConfiguration
{
    [String]$CommonName
    [String]$Uri
    [PSobject]$Params

    TrueNasnis([TrueNasConfiguration]$param):base()
    {
    }
    [object]putnis([psobject]$Body)
    {
        $reponse = .TrueNasRestMethod("nis" , "PUT", $Body)
        return $reponse
    }
    [object]getnis()
    {
        $reponse = .TrueNasRestMethod("nis" , "GET")
        return $reponse
    }
    [object]getnisget_state()
    {
        $reponse = .TrueNasRestMethod("nis/get_state" , "GET")
        return $reponse
    }
}
class TrueNasopenvpn :TrueNasConfiguration
{
    [String]$CommonName
    [String]$Uri
    [PSobject]$Params

    TrueNasopenvpn([TrueNasConfiguration]$param):base()
    {
    }
    [object]putopenvpnclient([psobject]$Body)
    {
        $reponse = .TrueNasRestMethod("openvpn/client" , "PUT", $Body)
        return $reponse
    }
    [object]getopenvpnclient()
    {
        $reponse = .TrueNasRestMethod("openvpn/client" , "GET")
        return $reponse
    }
    [object]getopenvpnclientauthentication_algorithm_choices()
    {
        $reponse = .TrueNasRestMethod("openvpn/client/authentication_algorithm_choices" , "GET")
        return $reponse
    }
    [object]getopenvpnclientcipher_choices()
    {
        $reponse = .TrueNasRestMethod("openvpn/client/cipher_choices" , "GET")
        return $reponse
    }
    [object]putopenvpnserver([psobject]$Body)
    {
        $reponse = .TrueNasRestMethod("openvpn/server" , "PUT", $Body)
        return $reponse
    }
    [object]getopenvpnserver()
    {
        $reponse = .TrueNasRestMethod("openvpn/server" , "GET")
        return $reponse
    }
    [object]getopenvpnserverauthentication_algorithm_choices()
    {
        $reponse = .TrueNasRestMethod("openvpn/server/authentication_algorithm_choices" , "GET")
        return $reponse
    }
    [object]getopenvpnservercipher_choices()
    {
        $reponse = .TrueNasRestMethod("openvpn/server/cipher_choices" , "GET")
        return $reponse
    }
    [object]postopenvpnserverclient_configuration_generation([psobject]$Body)
    {
        $reponse = .TrueNasRestMethod("openvpn/server/client_configuration_generation" , "POST", $Body)
        return $reponse
    }
    [object]getopenvpnserverrenew_static_key()
    {
        $reponse = .TrueNasRestMethod("openvpn/server/renew_static_key" , "GET")
        return $reponse
    }
}
class TrueNasplugin :TrueNasConfiguration
{
    [String]$CommonName
    [String]$Uri
    [PSobject]$Params

    TrueNasplugin([TrueNasConfiguration]$param):base()
    {
    }
    [object]postplugin([psobject]$Body)
    {
        $reponse = .TrueNasRestMethod("plugin" , "POST", $Body)
        return $reponse
    }
    [object]getplugin()
    {
        $reponse = .TrueNasRestMethod("plugin" , "GET")
        return $reponse
    }
    [object]postpluginavailable([psobject]$Body)
    {
        $reponse = .TrueNasRestMethod("plugin/available" , "POST", $Body)
        return $reponse
    }
    [object]postpluginbranches_choices([psobject]$Body)
    {
        $reponse = .TrueNasRestMethod("plugin/branches_choices" , "POST", $Body)
        return $reponse
    }
    [object]postplugindefaults([psobject]$Body)
    {
        $reponse = .TrueNasRestMethod("plugin/defaults" , "POST", $Body)
        return $reponse
    }
    [object]getpluginget_instance()
    {
        $reponse = .TrueNasRestMethod("plugin/get_instance" , "GET")
        return $reponse
    }
    [object]getpluginofficial_repositories()
    {
        $reponse = .TrueNasRestMethod("plugin/official_repositories" , "GET")
        return $reponse
    }
    [object]getpluginretrieve_versions_for_repos()
    {
        $reponse = .TrueNasRestMethod("plugin/retrieve_versions_for_repos" , "GET")
        return $reponse
    }
}
class TrueNaspool :TrueNasConfiguration
{
    [String]$CommonName
    [String]$Uri
    [PSobject]$Params

    TrueNaspool([TrueNasConfiguration]$param):base()
    {
    }
    [object]postpool([psobject]$Body)
    {
        $reponse = .TrueNasRestMethod("pool" , "POST", $Body)
        return $reponse
    }
    [object]getpool()
    {
        $reponse = .TrueNasRestMethod("pool" , "GET")
        return $reponse
    }
    [object]postpoolattach([psobject]$Body)
    {
        $reponse = .TrueNasRestMethod("pool/attach" , "POST", $Body)
        return $reponse
    }
    [object]postpooldataset([psobject]$Body)
    {
        $reponse = .TrueNasRestMethod("pool/dataset" , "POST", $Body)
        return $reponse
    }
    [object]getpooldataset()
    {
        $reponse = .TrueNasRestMethod("pool/dataset" , "GET")
        return $reponse
    }
    [object]postpooldatasetchange_key([psobject]$Body)
    {
        $reponse = .TrueNasRestMethod("pool/dataset/change_key" , "POST", $Body)
        return $reponse
    }
    [object]getpooldatasetencryption_algorithm_choices()
    {
        $reponse = .TrueNasRestMethod("pool/dataset/encryption_algorithm_choices" , "GET")
        return $reponse
    }
    [object]postpooldatasetencryption_summary([psobject]$Body)
    {
        $reponse = .TrueNasRestMethod("pool/dataset/encryption_summary" , "POST", $Body)
        return $reponse
    }
    [object]getpooldatasetget_instance()
    {
        $reponse = .TrueNasRestMethod("pool/dataset/get_instance" , "GET")
        return $reponse
    }
    [object]postpooldatasetinherit_parent_encryption_properties([psobject]$Body)
    {
        $reponse = .TrueNasRestMethod("pool/dataset/inherit_parent_encryption_properties" , "POST", $Body)
        return $reponse
    }
    [object]postpooldatasetlock([psobject]$Body)
    {
        $reponse = .TrueNasRestMethod("pool/dataset/lock" , "POST", $Body)
        return $reponse
    }
    [object]postpooldatasetrecommended_zvol_blocksize([psobject]$Body)
    {
        $reponse = .TrueNasRestMethod("pool/dataset/recommended_zvol_blocksize" , "POST", $Body)
        return $reponse
    }
    [object]postpooldatasetunlock([psobject]$Body)
    {
        $reponse = .TrueNasRestMethod("pool/dataset/unlock" , "POST", $Body)
        return $reponse
    }
    [object]postpooldatasetuserprop([psobject]$Body)
    {
        $reponse = .TrueNasRestMethod("pool/dataset/userprop" , "POST", $Body)
        return $reponse
    }
    [object]getpooldatasetuserprop()
    {
        $reponse = .TrueNasRestMethod("pool/dataset/userprop" , "GET")
        return $reponse
    }
    [object]getpooldatasetuserpropget_instance()
    {
        $reponse = .TrueNasRestMethod("pool/dataset/userprop/get_instance" , "GET")
        return $reponse
    }
    [object]postpoolfilesystem_choices([psobject]$Body)
    {
        $reponse = .TrueNasRestMethod("pool/filesystem_choices" , "POST", $Body)
        return $reponse
    }
    [object]getpoolget_instance()
    {
        $reponse = .TrueNasRestMethod("pool/get_instance" , "GET")
        return $reponse
    }
    [object]postpoolimport_disk([psobject]$Body)
    {
        $reponse = .TrueNasRestMethod("pool/import_disk" , "POST", $Body)
        return $reponse
    }
    [object]postpoolimport_disk_autodetect_fs_type([psobject]$Body)
    {
        $reponse = .TrueNasRestMethod("pool/import_disk_autodetect_fs_type" , "POST", $Body)
        return $reponse
    }
    [object]getpoolimport_disk_msdosfs_locales()
    {
        $reponse = .TrueNasRestMethod("pool/import_disk_msdosfs_locales" , "GET")
        return $reponse
    }
    [object]getpoolimport_find()
    {
        $reponse = .TrueNasRestMethod("pool/import_find" , "GET")
        return $reponse
    }
    [object]postpoolimport_pool([psobject]$Body)
    {
        $reponse = .TrueNasRestMethod("pool/import_pool" , "POST", $Body)
        return $reponse
    }
    [object]putpoolresilver([psobject]$Body)
    {
        $reponse = .TrueNasRestMethod("pool/resilver" , "PUT", $Body)
        return $reponse
    }
    [object]getpoolresilver()
    {
        $reponse = .TrueNasRestMethod("pool/resilver" , "GET")
        return $reponse
    }
    [object]postpoolscrub([psobject]$Body)
    {
        $reponse = .TrueNasRestMethod("pool/scrub" , "POST", $Body)
        return $reponse
    }
    [object]getpoolscrub()
    {
        $reponse = .TrueNasRestMethod("pool/scrub" , "GET")
        return $reponse
    }
    [object]getpoolscrubget_instance()
    {
        $reponse = .TrueNasRestMethod("pool/scrub/get_instance" , "GET")
        return $reponse
    }
    [object]postpoolscrubrun([psobject]$Body)
    {
        $reponse = .TrueNasRestMethod("pool/scrub/run" , "POST", $Body)
        return $reponse
    }
    [object]postpoolsnapshottask([psobject]$Body)
    {
        $reponse = .TrueNasRestMethod("pool/snapshottask" , "POST", $Body)
        return $reponse
    }
    [object]getpoolsnapshottask()
    {
        $reponse = .TrueNasRestMethod("pool/snapshottask" , "GET")
        return $reponse
    }
    [object]getpoolsnapshottaskget_instance()
    {
        $reponse = .TrueNasRestMethod("pool/snapshottask/get_instance" , "GET")
        return $reponse
    }
    [object]postpoolunlock_services_restart_choices([psobject]$Body)
    {
        $reponse = .TrueNasRestMethod("pool/unlock_services_restart_choices" , "POST", $Body)
        return $reponse
    }
}
class TrueNasreplication :TrueNasConfiguration
{
    [String]$CommonName
    [String]$Uri
    [PSobject]$Params

    TrueNasreplication([TrueNasConfiguration]$param):base()
    {
    }
    [object]postreplication([psobject]$Body)
    {
        $reponse = .TrueNasRestMethod("replication" , "POST", $Body)
        return $reponse
    }
    [object]getreplication()
    {
        $reponse = .TrueNasRestMethod("replication" , "GET")
        return $reponse
    }
    [object]postreplicationcount_eligible_manual_snapshots([psobject]$Body)
    {
        $reponse = .TrueNasRestMethod("replication/count_eligible_manual_snapshots" , "POST", $Body)
        return $reponse
    }
    [object]postreplicationcreate_dataset([psobject]$Body)
    {
        $reponse = .TrueNasRestMethod("replication/create_dataset" , "POST", $Body)
        return $reponse
    }
    [object]getreplicationget_instance()
    {
        $reponse = .TrueNasRestMethod("replication/get_instance" , "GET")
        return $reponse
    }
    [object]postreplicationlist_datasets([psobject]$Body)
    {
        $reponse = .TrueNasRestMethod("replication/list_datasets" , "POST", $Body)
        return $reponse
    }
    [object]getreplicationlist_naming_schemas()
    {
        $reponse = .TrueNasRestMethod("replication/list_naming_schemas" , "GET")
        return $reponse
    }
    [object]postreplicationtarget_unmatched_snapshots([psobject]$Body)
    {
        $reponse = .TrueNasRestMethod("replication/target_unmatched_snapshots" , "POST", $Body)
        return $reponse
    }
}
class TrueNasreporting :TrueNasConfiguration
{
    [String]$CommonName
    [String]$Uri
    [PSobject]$Params

    TrueNasreporting([TrueNasConfiguration]$param):base()
    {
    }
    [object]putreporting([psobject]$Body)
    {
        $reponse = .TrueNasRestMethod("reporting" , "PUT", $Body)
        return $reponse
    }
    [object]getreporting()
    {
        $reponse = .TrueNasRestMethod("reporting" , "GET")
        return $reponse
    }
    [object]postreportingget_data([psobject]$Body)
    {
        $reponse = .TrueNasRestMethod("reporting/get_data" , "POST", $Body)
        return $reponse
    }
    [object]getreportinggraphs()
    {
        $reponse = .TrueNasRestMethod("reporting/graphs" , "GET")
        return $reponse
    }
}
class TrueNasroute :TrueNasConfiguration
{
    [String]$CommonName
    [String]$Uri
    [PSobject]$Params

    TrueNasroute([TrueNasConfiguration]$param):base()
    {
    }
    [object]postrouteipv4gw_reachable([psobject]$Body)
    {
        $reponse = .TrueNasRestMethod("route/ipv4gw_reachable" , "POST", $Body)
        return $reponse
    }
    [object]getroutesystem_routes()
    {
        $reponse = .TrueNasRestMethod("route/system_routes" , "GET")
        return $reponse
    }
}
class TrueNasrsyncd :TrueNasConfiguration
{
    [String]$CommonName
    [String]$Uri
    [PSobject]$Params

    TrueNasrsyncd([TrueNasConfiguration]$param):base()
    {
    }
    [object]putrsyncd([psobject]$Body)
    {
        $reponse = .TrueNasRestMethod("rsyncd" , "PUT", $Body)
        return $reponse
    }
    [object]getrsyncd()
    {
        $reponse = .TrueNasRestMethod("rsyncd" , "GET")
        return $reponse
    }
}
class TrueNasrsyncmod :TrueNasConfiguration
{
    [String]$CommonName
    [String]$Uri
    [PSobject]$Params

    TrueNasrsyncmod([TrueNasConfiguration]$param):base()
    {
    }
    [object]postrsyncmod([psobject]$Body)
    {
        $reponse = .TrueNasRestMethod("rsyncmod" , "POST", $Body)
        return $reponse
    }
    [object]getrsyncmod()
    {
        $reponse = .TrueNasRestMethod("rsyncmod" , "GET")
        return $reponse
    }
    [object]getrsyncmodget_instance()
    {
        $reponse = .TrueNasRestMethod("rsyncmod/get_instance" , "GET")
        return $reponse
    }
}
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
class TrueNass3 :TrueNasConfiguration
{
    [String]$CommonName
    [String]$Uri
    [PSobject]$Params

    TrueNass3([TrueNasConfiguration]$param):base()
    {
    }
    [object]puts3([psobject]$Body)
    {
        $reponse = .TrueNasRestMethod("s3" , "PUT", $Body)
        return $reponse
    }
    [object]gets3()
    {
        $reponse = .TrueNasRestMethod("s3" , "GET")
        return $reponse
    }
    [object]gets3bindip_choices()
    {
        $reponse = .TrueNasRestMethod("s3/bindip_choices" , "GET")
        return $reponse
    }
}
class TrueNassensor :TrueNasConfiguration
{
    [String]$CommonName
    [String]$Uri
    [PSobject]$Params

    TrueNassensor([TrueNasConfiguration]$param):base()
    {
    }
    [object]getsensorquery()
    {
        $reponse = .TrueNasRestMethod("sensor/query" , "GET")
        return $reponse
    }
}
class TrueNasservice :TrueNasConfiguration
{
    [String]$CommonName
    [String]$Uri
    [PSobject]$Params

    TrueNasservice([TrueNasConfiguration]$param):base()
    {
    }
    [object]getservice()
    {
        $reponse = .TrueNasRestMethod("service" , "GET")
        return $reponse
    }
    [object]getserviceget_instance()
    {
        $reponse = .TrueNasRestMethod("service/get_instance" , "GET")
        return $reponse
    }
    [object]postservicereload([psobject]$Body)
    {
        $reponse = .TrueNasRestMethod("service/reload" , "POST", $Body)
        return $reponse
    }
    [object]postservicerestart([psobject]$Body)
    {
        $reponse = .TrueNasRestMethod("service/restart" , "POST", $Body)
        return $reponse
    }
    [object]postservicestart([psobject]$Body)
    {
        $reponse = .TrueNasRestMethod("service/start" , "POST", $Body)
        return $reponse
    }
    [object]getservicestarted()
    {
        $reponse = .TrueNasRestMethod("service/started" , "GET")
        return $reponse
    }
    [object]postservicestop([psobject]$Body)
    {
        $reponse = .TrueNasRestMethod("service/stop" , "POST", $Body)
        return $reponse
    }
    [object]postserviceterminate_process([psobject]$Body)
    {
        $reponse = .TrueNasRestMethod("service/terminate_process" , "POST", $Body)
        return $reponse
    }
}
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
class TrueNassmb :TrueNasConfiguration
{
    [String]$CommonName
    [String]$Uri
    [PSobject]$Params

    TrueNassmb([TrueNasConfiguration]$param):base()
    {
    }
    [object]putsmb([psobject]$Body)
    {
        $reponse = .TrueNasRestMethod("smb" , "PUT", $Body)
        return $reponse
    }
    [object]getsmb()
    {
        $reponse = .TrueNasRestMethod("smb" , "GET")
        return $reponse
    }
    [object]getsmbbindip_choices()
    {
        $reponse = .TrueNasRestMethod("smb/bindip_choices" , "GET")
        return $reponse
    }
    [object]getsmbdomain_choices()
    {
        $reponse = .TrueNasRestMethod("smb/domain_choices" , "GET")
        return $reponse
    }
    [object]postsmbget_remote_acl([psobject]$Body)
    {
        $reponse = .TrueNasRestMethod("smb/get_remote_acl" , "POST", $Body)
        return $reponse
    }
    [object]postsmbsharesec([psobject]$Body)
    {
        $reponse = .TrueNasRestMethod("smb/sharesec" , "POST", $Body)
        return $reponse
    }
    [object]getsmbsharesec()
    {
        $reponse = .TrueNasRestMethod("smb/sharesec" , "GET")
        return $reponse
    }
    [object]getsmbsharesecget_instance()
    {
        $reponse = .TrueNasRestMethod("smb/sharesec/get_instance" , "GET")
        return $reponse
    }
    [object]postsmbsharesecgetacl([psobject]$Body)
    {
        $reponse = .TrueNasRestMethod("smb/sharesec/getacl" , "POST", $Body)
        return $reponse
    }
    [object]getsmbsharesecsynchronize_acls()
    {
        $reponse = .TrueNasRestMethod("smb/sharesec/synchronize_acls" , "GET")
        return $reponse
    }
    [object]postsmbstatus([psobject]$Body)
    {
        $reponse = .TrueNasRestMethod("smb/status" , "POST", $Body)
        return $reponse
    }
    [object]getsmbunixcharset_choices()
    {
        $reponse = .TrueNasRestMethod("smb/unixcharset_choices" , "GET")
        return $reponse
    }
}
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
class TrueNasssh :TrueNasConfiguration
{
    [String]$CommonName
    [String]$Uri
    [PSobject]$Params

    TrueNasssh([TrueNasConfiguration]$param):base()
    {
    }
    [object]putssh([psobject]$Body)
    {
        $reponse = .TrueNasRestMethod("ssh" , "PUT", $Body)
        return $reponse
    }
    [object]getssh()
    {
        $reponse = .TrueNasRestMethod("ssh" , "GET")
        return $reponse
    }
    [object]getsshbindiface_choices()
    {
        $reponse = .TrueNasRestMethod("ssh/bindiface_choices" , "GET")
        return $reponse
    }
}
class TrueNasstaticroute :TrueNasConfiguration
{
    [String]$CommonName
    [String]$Uri
    [PSobject]$Params

    TrueNasstaticroute([TrueNasConfiguration]$param):base()
    {
    }
    [object]poststaticroute([psobject]$Body)
    {
        $reponse = .TrueNasRestMethod("staticroute" , "POST", $Body)
        return $reponse
    }
    [object]getstaticroute()
    {
        $reponse = .TrueNasRestMethod("staticroute" , "GET")
        return $reponse
    }
    [object]getstaticrouteget_instance()
    {
        $reponse = .TrueNasRestMethod("staticroute/get_instance" , "GET")
        return $reponse
    }
}
class TrueNasstats :TrueNasConfiguration
{
    [String]$CommonName
    [String]$Uri
    [PSobject]$Params

    TrueNasstats([TrueNasConfiguration]$param):base()
    {
    }
    [object]poststatsget_data([psobject]$Body)
    {
        $reponse = .TrueNasRestMethod("stats/get_data" , "POST", $Body)
        return $reponse
    }
    [object]poststatsget_dataset_info([psobject]$Body)
    {
        $reponse = .TrueNasRestMethod("stats/get_dataset_info" , "POST", $Body)
        return $reponse
    }
    [object]getstatsget_sources()
    {
        $reponse = .TrueNasRestMethod("stats/get_sources" , "GET")
        return $reponse
    }
}
class TrueNassupport :TrueNasConfiguration
{
    [String]$CommonName
    [String]$Uri
    [PSobject]$Params

    TrueNassupport([TrueNasConfiguration]$param):base()
    {
    }
    [object]putsupport([psobject]$Body)
    {
        $reponse = .TrueNasRestMethod("support" , "PUT", $Body)
        return $reponse
    }
    [object]getsupport()
    {
        $reponse = .TrueNasRestMethod("support" , "GET")
        return $reponse
    }
    [object]postsupportfetch_categories([psobject]$Body)
    {
        $reponse = .TrueNasRestMethod("support/fetch_categories" , "POST", $Body)
        return $reponse
    }
    [object]getsupportfields()
    {
        $reponse = .TrueNasRestMethod("support/fields" , "GET")
        return $reponse
    }
    [object]getsupportis_available()
    {
        $reponse = .TrueNasRestMethod("support/is_available" , "GET")
        return $reponse
    }
    [object]getsupportis_available_and_enabled()
    {
        $reponse = .TrueNasRestMethod("support/is_available_and_enabled" , "GET")
        return $reponse
    }
    [object]postsupportnew_ticket([psobject]$Body)
    {
        $reponse = .TrueNasRestMethod("support/new_ticket" , "POST", $Body)
        return $reponse
    }
}
class TrueNassystem :TrueNasConfiguration
{
    [String]$CommonName
    [String]$Uri
    [PSobject]$Params

    TrueNassystem([TrueNasConfiguration]$param):base()
    {
    }
    [object]putsystemadvanced([psobject]$Body)
    {
        $reponse = .TrueNasRestMethod("system/advanced" , "PUT", $Body)
        return $reponse
    }
    [object]getsystemadvanced()
    {
        $reponse = .TrueNasRestMethod("system/advanced" , "GET")
        return $reponse
    }
    [object]getsystemadvancedsed_global_password()
    {
        $reponse = .TrueNasRestMethod("system/advanced/sed_global_password" , "GET")
        return $reponse
    }
    [object]getsystemadvancedserial_port_choices()
    {
        $reponse = .TrueNasRestMethod("system/advanced/serial_port_choices" , "GET")
        return $reponse
    }
    [object]getsystemboot_id()
    {
        $reponse = .TrueNasRestMethod("system/boot_id" , "GET")
        return $reponse
    }
    [object]getsystemenvironment()
    {
        $reponse = .TrueNasRestMethod("system/environment" , "GET")
        return $reponse
    }
    [object]postsystemfeature_enabled([psobject]$Body)
    {
        $reponse = .TrueNasRestMethod("system/feature_enabled" , "POST", $Body)
        return $reponse
    }
    [object]putsystemgeneral([psobject]$Body)
    {
        $reponse = .TrueNasRestMethod("system/general" , "PUT", $Body)
        return $reponse
    }
    [object]getsystemgeneral()
    {
        $reponse = .TrueNasRestMethod("system/general" , "GET")
        return $reponse
    }
    [object]getsystemgeneralcountry_choices()
    {
        $reponse = .TrueNasRestMethod("system/general/country_choices" , "GET")
        return $reponse
    }
    [object]getsystemgeneralkbdmap_choices()
    {
        $reponse = .TrueNasRestMethod("system/general/kbdmap_choices" , "GET")
        return $reponse
    }
    [object]getsystemgenerallanguage_choices()
    {
        $reponse = .TrueNasRestMethod("system/general/language_choices" , "GET")
        return $reponse
    }
    [object]getsystemgenerallocal_url()
    {
        $reponse = .TrueNasRestMethod("system/general/local_url" , "GET")
        return $reponse
    }
    [object]getsystemgeneraltimezone_choices()
    {
        $reponse = .TrueNasRestMethod("system/general/timezone_choices" , "GET")
        return $reponse
    }
    [object]getsystemgeneralui_address_choices()
    {
        $reponse = .TrueNasRestMethod("system/general/ui_address_choices" , "GET")
        return $reponse
    }
    [object]getsystemgeneralui_certificate_choices()
    {
        $reponse = .TrueNasRestMethod("system/general/ui_certificate_choices" , "GET")
        return $reponse
    }
    [object]getsystemgeneralui_httpsprotocols_choices()
    {
        $reponse = .TrueNasRestMethod("system/general/ui_httpsprotocols_choices" , "GET")
        return $reponse
    }
    [object]getsystemgeneralui_restart()
    {
        $reponse = .TrueNasRestMethod("system/general/ui_restart" , "GET")
        return $reponse
    }
    [object]getsystemgeneralui_v6address_choices()
    {
        $reponse = .TrueNasRestMethod("system/general/ui_v6address_choices" , "GET")
        return $reponse
    }
    [object]getsysteminfo()
    {
        $reponse = .TrueNasRestMethod("system/info" , "GET")
        return $reponse
    }
    [object]getsystemis_freenas()
    {
        $reponse = .TrueNasRestMethod("system/is_freenas" , "GET")
        return $reponse
    }
    [object]postsystemlicense_update([psobject]$Body)
    {
        $reponse = .TrueNasRestMethod("system/license_update" , "POST", $Body)
        return $reponse
    }
    [object]postsystemntpserver([psobject]$Body)
    {
        $reponse = .TrueNasRestMethod("system/ntpserver" , "POST", $Body)
        return $reponse
    }
    [object]getsystemntpserver()
    {
        $reponse = .TrueNasRestMethod("system/ntpserver" , "GET")
        return $reponse
    }
    [object]getsystemntpserverget_instance()
    {
        $reponse = .TrueNasRestMethod("system/ntpserver/get_instance" , "GET")
        return $reponse
    }
    [object]getsystemntpservertest_ntp_server()
    {
        $reponse = .TrueNasRestMethod("system/ntpserver/test_ntp_server" , "GET")
        return $reponse
    }
    [object]getsystemproduct_name()
    {
        $reponse = .TrueNasRestMethod("system/product_name" , "GET")
        return $reponse
    }
    [object]getsystemproduct_type()
    {
        $reponse = .TrueNasRestMethod("system/product_type" , "GET")
        return $reponse
    }
    [object]getsystemready()
    {
        $reponse = .TrueNasRestMethod("system/ready" , "GET")
        return $reponse
    }
    [object]postsystemreboot([psobject]$Body)
    {
        $reponse = .TrueNasRestMethod("system/reboot" , "POST", $Body)
        return $reponse
    }
    [object]postsystemshutdown([psobject]$Body)
    {
        $reponse = .TrueNasRestMethod("system/shutdown" , "POST", $Body)
        return $reponse
    }
    [object]getsystemstate()
    {
        $reponse = .TrueNasRestMethod("system/state" , "GET")
        return $reponse
    }
    [object]getsystemversion()
    {
        $reponse = .TrueNasRestMethod("system/version" , "GET")
        return $reponse
    }
}
class TrueNassystemdataset :TrueNasConfiguration
{
    [String]$CommonName
    [String]$Uri
    [PSobject]$Params

    TrueNassystemdataset([TrueNasConfiguration]$param):base()
    {
    }
    [object]putsystemdataset([psobject]$Body)
    {
        $reponse = .TrueNasRestMethod("systemdataset" , "PUT", $Body)
        return $reponse
    }
    [object]getsystemdataset()
    {
        $reponse = .TrueNasRestMethod("systemdataset" , "GET")
        return $reponse
    }
}
class TrueNastftp :TrueNasConfiguration
{
    [String]$CommonName
    [String]$Uri
    [PSobject]$Params

    TrueNastftp([TrueNasConfiguration]$param):base()
    {
    }
    [object]puttftp([psobject]$Body)
    {
        $reponse = .TrueNasRestMethod("tftp" , "PUT", $Body)
        return $reponse
    }
    [object]gettftp()
    {
        $reponse = .TrueNasRestMethod("tftp" , "GET")
        return $reponse
    }
}
class TrueNastruecommand :TrueNasConfiguration
{
    [String]$CommonName
    [String]$Uri
    [PSobject]$Params

    TrueNastruecommand([TrueNasConfiguration]$param):base()
    {
    }
    [object]puttruecommand([psobject]$Body)
    {
        $reponse = .TrueNasRestMethod("truecommand" , "PUT", $Body)
        return $reponse
    }
    [object]gettruecommand()
    {
        $reponse = .TrueNasRestMethod("truecommand" , "GET")
        return $reponse
    }
}
class TrueNastruenas :TrueNasConfiguration
{
    [String]$CommonName
    [String]$Uri
    [PSobject]$Params

    TrueNastruenas([TrueNasConfiguration]$param):base()
    {
    }
    [object]gettruenasaccept_eula()
    {
        $reponse = .TrueNasRestMethod("truenas/accept_eula" , "GET")
        return $reponse
    }
    [object]gettruenasget_chassis_hardware()
    {
        $reponse = .TrueNasRestMethod("truenas/get_chassis_hardware" , "GET")
        return $reponse
    }
    [object]gettruenasget_customer_information()
    {
        $reponse = .TrueNasRestMethod("truenas/get_customer_information" , "GET")
        return $reponse
    }
    [object]gettruenasget_eula()
    {
        $reponse = .TrueNasRestMethod("truenas/get_eula" , "GET")
        return $reponse
    }
    [object]gettruenasis_eula_accepted()
    {
        $reponse = .TrueNasRestMethod("truenas/is_eula_accepted" , "GET")
        return $reponse
    }
    [object]gettruenasis_production()
    {
        $reponse = .TrueNasRestMethod("truenas/is_production" , "GET")
        return $reponse
    }
    [object]posttruenasset_production([psobject]$Body)
    {
        $reponse = .TrueNasRestMethod("truenas/set_production" , "POST", $Body)
        return $reponse
    }
    [object]posttruenasupdate_customer_information([psobject]$Body)
    {
        $reponse = .TrueNasRestMethod("truenas/update_customer_information" , "POST", $Body)
        return $reponse
    }
}
class TrueNastunable :TrueNasConfiguration
{
    [String]$CommonName
    [String]$Uri
    [PSobject]$Params

    TrueNastunable([TrueNasConfiguration]$param):base()
    {
    }
    [object]posttunable([psobject]$Body)
    {
        $reponse = .TrueNasRestMethod("tunable" , "POST", $Body)
        return $reponse
    }
    [object]gettunable()
    {
        $reponse = .TrueNasRestMethod("tunable" , "GET")
        return $reponse
    }
    [object]gettunableget_instance()
    {
        $reponse = .TrueNasRestMethod("tunable/get_instance" , "GET")
        return $reponse
    }
}
class TrueNasupdate :TrueNasConfiguration
{
    [String]$CommonName
    [String]$Uri
    [PSobject]$Params

    TrueNasupdate([TrueNasConfiguration]$param):base()
    {
    }
    [object]postupdatecheck_available([psobject]$Body)
    {
        $reponse = .TrueNasRestMethod("update/check_available" , "POST", $Body)
        return $reponse
    }
    [object]getupdatedownload()
    {
        $reponse = .TrueNasRestMethod("update/download" , "GET")
        return $reponse
    }
    [object]getupdateget_auto_download()
    {
        $reponse = .TrueNasRestMethod("update/get_auto_download" , "GET")
        return $reponse
    }
    [object]postupdateget_pending([psobject]$Body)
    {
        $reponse = .TrueNasRestMethod("update/get_pending" , "POST", $Body)
        return $reponse
    }
    [object]getupdateget_trains()
    {
        $reponse = .TrueNasRestMethod("update/get_trains" , "GET")
        return $reponse
    }
    [object]postupdatemanual([psobject]$Body)
    {
        $reponse = .TrueNasRestMethod("update/manual" , "POST", $Body)
        return $reponse
    }
    [object]postupdateset_auto_download([psobject]$Body)
    {
        $reponse = .TrueNasRestMethod("update/set_auto_download" , "POST", $Body)
        return $reponse
    }
    [object]postupdateset_train([psobject]$Body)
    {
        $reponse = .TrueNasRestMethod("update/set_train" , "POST", $Body)
        return $reponse
    }
    [object]postupdateupdate([psobject]$Body)
    {
        $reponse = .TrueNasRestMethod("update/update" , "POST", $Body)
        return $reponse
    }
}
class TrueNasups :TrueNasConfiguration
{
    [String]$CommonName
    [String]$Uri
    [PSobject]$Params

    TrueNasups([TrueNasConfiguration]$param):base()
    {
    }
    [object]putups([psobject]$Body)
    {
        $reponse = .TrueNasRestMethod("ups" , "PUT", $Body)
        return $reponse
    }
    [object]getups()
    {
        $reponse = .TrueNasRestMethod("ups" , "GET")
        return $reponse
    }
    [object]getupsdriver_choices()
    {
        $reponse = .TrueNasRestMethod("ups/driver_choices" , "GET")
        return $reponse
    }
    [object]getupsport_choices()
    {
        $reponse = .TrueNasRestMethod("ups/port_choices" , "GET")
        return $reponse
    }
}
class TrueNasuser :TrueNasConfiguration
{
    [String]$CommonName
    [String]$Uri
    [PSobject]$Params

    TrueNasuser([TrueNasConfiguration]$param):base()
    {
    }
    [object]postuser([psobject]$Body)
    {
        $reponse = .TrueNasRestMethod("user" , "POST", $Body)
        return $reponse
    }
    [object]getuser()
    {
        $reponse = .TrueNasRestMethod("user" , "GET")
        return $reponse
    }
    [object]getuserget_instance()
    {
        $reponse = .TrueNasRestMethod("user/get_instance" , "GET")
        return $reponse
    }
    [object]getuserget_next_uid()
    {
        $reponse = .TrueNasRestMethod("user/get_next_uid" , "GET")
        return $reponse
    }
    [object]postuserget_user_obj([psobject]$Body)
    {
        $reponse = .TrueNasRestMethod("user/get_user_obj" , "POST", $Body)
        return $reponse
    }
    [object]getuserhas_root_password()
    {
        $reponse = .TrueNasRestMethod("user/has_root_password" , "GET")
        return $reponse
    }
    [object]postusershell_choices([psobject]$Body)
    {
        $reponse = .TrueNasRestMethod("user/shell_choices" , "POST", $Body)
        return $reponse
    }
}
class TrueNasvm :TrueNasConfiguration
{
    [String]$CommonName
    [String]$Uri
    [PSobject]$Params

    TrueNasvm([TrueNasConfiguration]$param):base()
    {
    }
    [object]postvm([psobject]$Body)
    {
        $reponse = .TrueNasRestMethod("vm" , "POST", $Body)
        return $reponse
    }
    [object]getvm()
    {
        $reponse = .TrueNasRestMethod("vm" , "GET")
        return $reponse
    }
    [object]postvmdevice([psobject]$Body)
    {
        $reponse = .TrueNasRestMethod("vm/device" , "POST", $Body)
        return $reponse
    }
    [object]getvmdevice()
    {
        $reponse = .TrueNasRestMethod("vm/device" , "GET")
        return $reponse
    }
    [object]getvmdeviceget_instance()
    {
        $reponse = .TrueNasRestMethod("vm/device/get_instance" , "GET")
        return $reponse
    }
    [object]getvmdevicenic_attach_choices()
    {
        $reponse = .TrueNasRestMethod("vm/device/nic_attach_choices" , "GET")
        return $reponse
    }
    [object]getvmdevicepptdev_choices()
    {
        $reponse = .TrueNasRestMethod("vm/device/pptdev_choices" , "GET")
        return $reponse
    }
    [object]getvmdevicevnc_bind_choices()
    {
        $reponse = .TrueNasRestMethod("vm/device/vnc_bind_choices" , "GET")
        return $reponse
    }
    [object]getvmflags()
    {
        $reponse = .TrueNasRestMethod("vm/flags" , "GET")
        return $reponse
    }
    [object]postvmget_attached_iface([psobject]$Body)
    {
        $reponse = .TrueNasRestMethod("vm/get_attached_iface" , "POST", $Body)
        return $reponse
    }
    [object]postvmget_available_memory([psobject]$Body)
    {
        $reponse = .TrueNasRestMethod("vm/get_available_memory" , "POST", $Body)
        return $reponse
    }
    [object]postvmget_console([psobject]$Body)
    {
        $reponse = .TrueNasRestMethod("vm/get_console" , "POST", $Body)
        return $reponse
    }
    [object]getvmget_instance()
    {
        $reponse = .TrueNasRestMethod("vm/get_instance" , "GET")
        return $reponse
    }
    [object]getvmget_vmemory_in_use()
    {
        $reponse = .TrueNasRestMethod("vm/get_vmemory_in_use" , "GET")
        return $reponse
    }
    [object]postvmget_vnc([psobject]$Body)
    {
        $reponse = .TrueNasRestMethod("vm/get_vnc" , "POST", $Body)
        return $reponse
    }
    [object]getvmget_vnc_ipv4()
    {
        $reponse = .TrueNasRestMethod("vm/get_vnc_ipv4" , "GET")
        return $reponse
    }
    [object]getvmidentify_hypervisor()
    {
        $reponse = .TrueNasRestMethod("vm/identify_hypervisor" , "GET")
        return $reponse
    }
    [object]getvmrandom_mac()
    {
        $reponse = .TrueNasRestMethod("vm/random_mac" , "GET")
        return $reponse
    }
    [object]getvmvnc_port_wizard()
    {
        $reponse = .TrueNasRestMethod("vm/vnc_port_wizard" , "GET")
        return $reponse
    }
}
class TrueNasvmware :TrueNasConfiguration
{
    [String]$CommonName
    [String]$Uri
    [PSobject]$Params

    TrueNasvmware([TrueNasConfiguration]$param):base()
    {
    }
    [object]postvmware([psobject]$Body)
    {
        $reponse = .TrueNasRestMethod("vmware" , "POST", $Body)
        return $reponse
    }
    [object]getvmware()
    {
        $reponse = .TrueNasRestMethod("vmware" , "GET")
        return $reponse
    }
    [object]postvmwaredataset_has_vms([psobject]$Body)
    {
        $reponse = .TrueNasRestMethod("vmware/dataset_has_vms" , "POST", $Body)
        return $reponse
    }
    [object]postvmwareget_datastores([psobject]$Body)
    {
        $reponse = .TrueNasRestMethod("vmware/get_datastores" , "POST", $Body)
        return $reponse
    }
    [object]getvmwareget_instance()
    {
        $reponse = .TrueNasRestMethod("vmware/get_instance" , "GET")
        return $reponse
    }
    [object]postvmwareget_virtual_machines([psobject]$Body)
    {
        $reponse = .TrueNasRestMethod("vmware/get_virtual_machines" , "POST", $Body)
        return $reponse
    }
    [object]postvmwarematch_datastores_with_datasets([psobject]$Body)
    {
        $reponse = .TrueNasRestMethod("vmware/match_datastores_with_datasets" , "POST", $Body)
        return $reponse
    }
}
class TrueNaswebdav :TrueNasConfiguration
{
    [String]$CommonName
    [String]$Uri
    [PSobject]$Params

    TrueNaswebdav([TrueNasConfiguration]$param):base()
    {
    }
    [object]putwebdav([psobject]$Body)
    {
        $reponse = .TrueNasRestMethod("webdav" , "PUT", $Body)
        return $reponse
    }
    [object]getwebdav()
    {
        $reponse = .TrueNasRestMethod("webdav" , "GET")
        return $reponse
    }
}
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
class TrueNaszfs :TrueNasConfiguration
{
    [String]$CommonName
    [String]$Uri
    [PSobject]$Params

    TrueNaszfs([TrueNasConfiguration]$param):base()
    {
    }
    [object]postzfssnapshot([psobject]$Body)
    {
        $reponse = .TrueNasRestMethod("zfs/snapshot" , "POST", $Body)
        return $reponse
    }
    [object]getzfssnapshot()
    {
        $reponse = .TrueNasRestMethod("zfs/snapshot" , "GET")
        return $reponse
    }
    [object]postzfssnapshotclone([psobject]$Body)
    {
        $reponse = .TrueNasRestMethod("zfs/snapshot/clone" , "POST", $Body)
        return $reponse
    }
    [object]getzfssnapshotget_instance()
    {
        $reponse = .TrueNasRestMethod("zfs/snapshot/get_instance" , "GET")
        return $reponse
    }
    [object]postzfssnapshotremove([psobject]$Body)
    {
        $reponse = .TrueNasRestMethod("zfs/snapshot/remove" , "POST", $Body)
        return $reponse
    }
    [object]postzfssnapshotrollback([psobject]$Body)
    {
        $reponse = .TrueNasRestMethod("zfs/snapshot/rollback" , "POST", $Body)
        return $reponse
    }
}
