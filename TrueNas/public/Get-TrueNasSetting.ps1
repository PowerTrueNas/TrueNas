function Get-TrueNasSetting
{
    [CmdletBinding()]
    [Alias()]
    Param
    ()


    Begin
    { }
    Process
    {
        $Uri = "api/v2.0/system/general"

        $result = Invoke-TrueNasRestMethod -Uri $Uri -Method Get
    }
    End
    {
        $Global = new-Object -TypeName PSObject

        $Global | add-member -name "Id" -membertype NoteProperty -Value "$($result.id)"
        $Global | add-member -name "Language" -membertype NoteProperty -Value "$($result.language)"
        $Global | add-member -name "Keyboard map" -membertype NoteProperty -Value "$($result.kbdmap)"
        $Global | add-member -name "Time zone" -membertype NoteProperty -Value "$($result.timezone)"
        $Global | add-member -name "SysLog Level" -membertype NoteProperty -Value "$($result.sysloglevel)"
        $Global | add-member -name "Syslog server" -membertype NoteProperty -Value "$($result.syslogserver)"
        $Global | add-member -name "Crash reporting" -membertype NoteProperty -Value "$($result.crash_reporting )"
        $Global | add-member -name "WizardShonw" -membertype NoteProperty -Value "$($result.wizardshown)"
        $Global | add-member -name "Usage collection" -membertype NoteProperty -Value "$($result.usage_collection)"
        $Global | add-member -name "Ui certificate" -membertype NoteProperty -Value "$($result.ui_certificate)"
        $Global | add-member -name "Ui address" -membertype NoteProperty -Value "$($result.ui_address)"
        $Global | add-member -name "Ui v6address" -membertype NoteProperty -Value "$($result.ui_v6address)"
        $Global | add-member -name "Ui port" -membertype NoteProperty -Value "$($result.ui_port)"
        $Global | add-member -name "Ui https port" -membertype NoteProperty -Value "$($result.ui_httpsport)"
        $Global | add-member -name "Ui https redirect" -membertype NoteProperty -Value "$($result.ui_httpsredirect)"
        $Global | add-member -name "Crash reporting is set" -membertype NoteProperty -Value "$($result.crash_reporting_is_set)"
        $Global | add-member -name "usage collection is set" -membertype NoteProperty -Value "$($result.usage_collection_is_set)"

        return $Global
    }
}
