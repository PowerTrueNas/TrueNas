function Get-TrueNasIscsiConf
{
    Param
    ( )

    Begin
    {

    }
    Process
    {
        $Uri = "api/v2.0/iscsi/global"

        $result = Invoke-TrueNasRestMethod -Uri $Uri -Method Get

    }
    End
    {
        $IscsiConf = New-Object -TypeName System.Collections.ArrayList

        $temp = New-Object -TypeName PSObject
        $temp | Add-Member -MemberType NoteProperty -Name "Id" -Value $result.id
        $temp | Add-Member -MemberType NoteProperty -Name "Base Name" -Value $result.basename
        $temp | Add-Member -MemberType NoteProperty -Name "ISNS Server" -Value $result.isns_servers
        $temp | Add-Member -MemberType NoteProperty -Name "Pool available space Threshold (%)" -Value $result.pool_avail_threshold
        $temp | Add-Member -MemberType NoteProperty -Name "Alua" -Value $result.alua


        $IscsiConf.Add($temp) | Out-Null

        return $IscsiConf | fl
    }
}
