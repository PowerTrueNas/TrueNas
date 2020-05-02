function Get-TrueNasIscsiTarget
{
    Param
    ( )


    Begin
    {

    }
    Process
    {
        $Uri = "api/v2.0/iscsi/target"

        $result = Invoke-TrueNasRestMethod -Uri $Uri -Method Get
        $TruenasIscsiTarget = New-Object -TypeName System.Collections.ArrayList

        if ($null -eq $result.Count)
        {

            $temp = New-Object -TypeName System.Object
            $temp | Add-Member -MemberType NoteProperty -Name "Id" -Value "$($result.id)"
            $temp | Add-Member -MemberType NoteProperty -Name "Target alias" -Value "$($result.alias)"
            $temp | Add-Member -MemberType NoteProperty -Name "Target name" -Value "$($result.name)"
            $temp | Add-Member -MemberType NoteProperty -Name "Target mode" -Value "$($result.mode)"
            $temp | Add-Member -MemberType NoteProperty -Name "Groups portal" -Value "$($result.groups.portal)"
            $temp | Add-Member -MemberType NoteProperty -Name "Groups initiator" -Value "$($result.groups.initiator)"
            $temp | Add-Member -MemberType NoteProperty -Name "Groups authentification" -Value "$($result.groups.auth)"
            $temp | Add-Member -MemberType NoteProperty -Name "Groups authen-method" -Value "$($result.groups.authmethod)"
            $TruenasIscsiTarget.Add($temp) | Out-Null
        }
        else
        {
            for ($i = 0; $i -lt $result.Count; $i++)
            {
                $temp = New-Object -TypeName System.Object
                $temp | Add-Member -MemberType NoteProperty -Name "Id" -Value "$($result[$i].id)"
                $temp | Add-Member -MemberType NoteProperty -Name "Target alias" -Value "$($result[$i].alias)"
                $temp | Add-Member -MemberType NoteProperty -Name "Target name" -Value "$($result[$i].name)"
                $temp | Add-Member -MemberType NoteProperty -Name "Target mode" -Value "$($result[$i].mode)"
                $temp | Add-Member -MemberType NoteProperty -Name "Groups portal" -Value "$($result[$i].groups.portal)"
                $temp | Add-Member -MemberType NoteProperty -Name "Groups initiator" -Value "$($result[$i].groups.initiator)"
                $temp | Add-Member -MemberType NoteProperty -Name "Groups authentification" -Value "$($result[$i].groups.auth)"
                $temp | Add-Member -MemberType NoteProperty -Name "Groups authen-method" -Value "$($result[$i].groups.authmethod)"

                $TruenasIscsiTarget.Add($temp) | Out-Null
            }
        }

        return $TruenasIscsiTarget
    }
    End
    { }
}
