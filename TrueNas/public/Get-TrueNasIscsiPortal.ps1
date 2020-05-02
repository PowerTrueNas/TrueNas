function Get-TrueNasIscsiPortal
{
    Param
    ( )


    Begin
    {

    }
    Process
    {
        $Uri = "api/v2.0/iscsi/portal"

        $result = Invoke-TrueNasRestMethod -Uri $Uri -Method Get

        $Obj = New-Object -TypeName System.Collections.ArrayList
        $temp = New-Object -TypeName System.Object

        if ($null -eq $result.Count)
        {
            $temp | Add-Member -MemberType NoteProperty -Name "Id" -Value $result.id
            $temp | Add-Member -MemberType NoteProperty -Name "Tag" -Value $result.tag
            $temp | Add-Member -MemberType NoteProperty -Name "Listen" -Value $result.listen.ip
            $temp | Add-Member -MemberType NoteProperty -Name "Port" -Value $result.listen.port
            $temp | Add-Member -MemberType NoteProperty -Name "Discovery authmethod" -Value $result.discovery_authmethod
            $temp | Add-Member -MemberType NoteProperty -Name "Discovery authgroup" -Value $result.discovery_authgroup
            $Obj.Add($temp) | Out-Null

        }
        else
        {
            for ($i = 0; $i -lt $result.Count; $i++)
            {
                $temp = New-Object -TypeName System.Object
                $temp | Add-Member -MemberType NoteProperty -Name "Id" -Value "$($result[$i].id)"
                $temp | Add-Member -MemberType NoteProperty -Name "Tag" -Value "$($result[$i].tag)"
                $temp | Add-Member -MemberType NoteProperty -Name "Listen" -Value "$($result[$i].listen.ip)"
                $temp | Add-Member -MemberType NoteProperty -Name "Port" -Value "$($result[$i].listen.port)"
                $temp | Add-Member -MemberType NoteProperty -Name "Discovery authmethod" -Value "$($result[$i].discovery_authmethod)"
                $temp | Add-Member -MemberType NoteProperty -Name "Discovery authgroup" -Value "$($result[$i].discovery_authgroup)"
                $Obj.Add($temp) | Out-Null
            }

        }
        return $Obj
    }
    End
    { }
}
