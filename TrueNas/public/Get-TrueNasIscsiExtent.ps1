function Get-TrueNasIscsiExtent
{

    Param
    ()


    Begin
    {

    }
    Process
    {
        $Uri = "api/v2.0/iscsi/extent"
        $result = Invoke-TrueNasRestMethod -Uri $Uri -Method Get

        $Extent = New-Object -TypeName System.Collections.ArrayList
        $temp = New-Object -TypeName System.Object

        if ($null -eq $result.Count)
        {

            $temp | Add-Member -MemberType NoteProperty -Name "Id" -Value  "$($result.id)"
            $temp | Add-Member -MemberType NoteProperty -Name "Extent Type" -Value "$($result.type)"
            $temp | Add-Member -MemberType NoteProperty -Name "Extent Name" -Value  "$($result.name)"
            $temp | Add-Member -MemberType NoteProperty -Name "Extent path" -Value  "$($result.path)"
            $temp | Add-Member -MemberType NoteProperty -Name "Extent Block Size" -Value  "$($result.blocksize)"
            $temp | Add-Member -MemberType NoteProperty -Name "Extent Speed Type" -Value "$($result.rpm)"
            $temp | Add-Member -MemberType NoteProperty -Name "Extent Naa" -Value "$($result.naa)"
            $temp | Add-Member -MemberType NoteProperty -Name "Extent enabled" -Value "$($result.enabled)"
            $temp | Add-Member -MemberType NoteProperty -Name "Extent disk" -Value "$($result.disk)"
            $temp | Add-Member -MemberType NoteProperty -Name "Extent Xen" -Value "$($result.xen)"

            $Extent.Add($temp) | Out-Null

        }
        else
        {
            for ($i = 0; $i -lt $result.Count; $i++)
            {
                $temp = New-Object -TypeName System.Object
                $temp | Add-Member -MemberType NoteProperty -Name "Id" -Value  "$($result[$i].id)"
                $temp | Add-Member -MemberType NoteProperty -Name "Extent Type" -Value "$($result[$i].type)"
                $temp | Add-Member -MemberType NoteProperty -Name "Extent Name" -Value  "$($result[$i].name)"
                $temp | Add-Member -MemberType NoteProperty -Name "Extent path" -Value  "$($result[$i].path)"
                $temp | Add-Member -MemberType NoteProperty -Name "Extent Block Size" -Value  "$($result[$i].blocksize)"
                $temp | Add-Member -MemberType NoteProperty -Name "Extent Speed Type" -Value "$($result[$i].rpm)"
                $temp | Add-Member -MemberType NoteProperty -Name "Extent Naa" -Value "$($result[$i].naa)"
                $temp | Add-Member -MemberType NoteProperty -Name "Extent enabled" -Value "$($result[$i].enabled)"
                $temp | Add-Member -MemberType NoteProperty -Name "Extent disk" -Value "$($result[$i].disk)"
                $temp | Add-Member -MemberType NoteProperty -Name "Extent Xen" -Value "$($result[$i].xen)"
                $Extent.Add($temp) | Out-Null
            }

        }

        return $Extent


    }
    End
    { }
}
