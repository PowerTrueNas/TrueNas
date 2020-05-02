function Get-TrueNasPool
{
    Param

    ( )

    Begin
    {

    }
    Process
    {
        $Uri = "api/v2.0/pool"
        $result = Invoke-TrueNasRestMethod -Uri $Uri -Method Get

    }
    End
    {
        $TruenasVolume = New-Object -TypeName System.Collections.ArrayList

        if ($null -eq $result.count)
        {
            $temp = New-Object -TypeName System.Object
            $temp | Add-Member -MemberType NoteProperty -Name "Name" -Value "$($result.name)"
            $temp | Add-Member -MemberType NoteProperty -Name "Id" -Value "$($result.id)"
            $temp | Add-Member -MemberType NoteProperty -Name "Guid" -Value "$($result.guid)"
            $temp | Add-Member -MemberType NoteProperty -Name "Encrypt" -Value "$($result.encrypt)"
            $temp | Add-Member -MemberType NoteProperty -Name "Encrypt key" -Value "$($result.encryptkey)"
            $temp | Add-Member -MemberType NoteProperty -Name "Path" -Value "$($result.path)"
            $temp | Add-Member -MemberType NoteProperty -Name "Status" -Value "$($result.status)"
            $temp | Add-Member -MemberType NoteProperty -Name "Healthy" -Value "$($result.healthy)"
            $temp | Add-Member -MemberType NoteProperty -Name "Is decrypted" -Value "$($result.is_decrypted)"
            #$result.topology.data.children Topology
            $TruenasVolume.Add($temp) | Out-Null

        }
        else
        {
            for ($i = 0; $i -lt $result.Count; $i++)
            {
                $temp = New-Object -TypeName System.Object
                $temp | Add-Member -MemberType NoteProperty -Name "Name" -Value "$($result[$i].name)"
                $temp | Add-Member -MemberType NoteProperty -Name "Id" -Value "$($result[$i].id)"
                $temp | Add-Member -MemberType NoteProperty -Name "Guid" -Value "$($result[$i].guid)"
                $temp | Add-Member -MemberType NoteProperty -Name "Encrypt" -Value "$($result[$i].encrypt)"
                $temp | Add-Member -MemberType NoteProperty -Name "Encrypt key" -Value "$($result[$i].encryptkey)"
                $temp | Add-Member -MemberType NoteProperty -Name "Path" -Value "$($result[$i].path)"
                $temp | Add-Member -MemberType NoteProperty -Name "Status" -Value "$($result[$i].status)"
                $temp | Add-Member -MemberType NoteProperty -Name "Healthy" -Value "$($result[$i].healthy)"
                $temp | Add-Member -MemberType NoteProperty -Name "Is decrypted" -Value "$($result[$i].is_decrypted)"
                $TruenasVolume.Add($temp) | Out-Null
            }

        }


        return $TruenasVolume



    }
}
