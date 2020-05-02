function Get-TrueNasIscsiInitiator
{
    Param
    ( )


    Begin
    {

    }
    Process
    {
        $Uri = "api/v2.0/iscsi/initiator"
        $result = Invoke-TrueNasRestMethod -Uri $Uri -Method Get

        $initiator = New-Object -TypeName System.Collections.ArrayList
        $temp = New-Object -TypeName System.Object

        if ($null -eq $result.Count)
        {
            $temp | Add-Member -MemberType NoteProperty -Name "Id" -Value $result.id
            $temp | Add-Member -MemberType NoteProperty -Name "Tag" -Value $result.tag
            $temp | Add-Member -MemberType NoteProperty -Name "Initiator" -Value $result.initiators
            $temp | Add-Member -MemberType NoteProperty -Name "Auth Network" -Value $result.auth_network
            $temp | Add-Member -MemberType NoteProperty -Name "Comments" -Value $result.comment
            $initiator.Add($temp) | Out-Null

        }
        else
        {
            for ($i = 0; $i -lt $result.Count; $i++)
            {
                $temp = New-Object -TypeName System.Object
                $temp | Add-Member -MemberType NoteProperty -Name "Id" -Value "$($result[$i].id)"
                $temp | Add-Member -MemberType NoteProperty -Name "Tag" -Value "$($result[$i].tag)"
                $temp | Add-Member -MemberType NoteProperty -Name "Initiator" -Value "$($result[$i].initiators)"
                $temp | Add-Member -MemberType NoteProperty -Name "Auth Network" -Value "$($result[$i].auth_network)"
                $temp | Add-Member -MemberType NoteProperty -Name "Comments" -Value "$($result[$i].comment)"
                $initiator.Add($temp) | Out-Null
            }

        }

        return $initiator


    }
    End
    { }
}
