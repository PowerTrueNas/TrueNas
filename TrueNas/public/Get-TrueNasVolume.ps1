function Get-TrueNasVolume
{
    [CmdletBinding()]
    Param
    (
        [Parameter (Mandatory = $true)]
        [ValidateSet("VOLUME", "FILESYSTEM")]
        $Type

    )

    Begin
    {

    }
    Process
    {
        $Uri = "api/v2.0/pool/dataset"
        $result = Invoke-TrueNasRestMethod -Uri $Uri -Method Get

        switch ($Type)
        {
            'VOLUME' { $result = $result | Where-Object { $_.type -eq "VOLUME" } }
            'FILESYSTEM' { $result = $result | Where-Object { $_.type -eq "FILESYSTEM" } }
            Default { }
        }
    }
    End
    {
        $TruenasVolume = New-Object -TypeName System.Collections.ArrayList

        if ($null -eq $result.count)
        {
            $temp = New-Object -TypeName System.Object
            $temp | Add-Member -MemberType NoteProperty -Name "Name" -Value "$($result.name)"
            $temp | Add-Member -MemberType NoteProperty -Name "Id" -Value "$($result.id)"
            $temp | Add-Member -MemberType NoteProperty -Name "Children" -Value "$($result.children)"
            $temp | Add-Member -MemberType NoteProperty -Name "Type" -Value "$($result.type)"
            $temp | Add-Member -MemberType NoteProperty -Name "Deduplication" -Value "$($result.deduplication.value)"
            $temp | Add-Member -MemberType NoteProperty -Name "Sync" -Value "$($result.sync.value)"
            $temp | Add-Member -MemberType NoteProperty -Name "Compression" -Value "$($result.compression.value)"
            $temp | Add-Member -MemberType NoteProperty -Name "Compression ratio" -Value "$($result.compressratio.value)"
            $temp | Add-Member -MemberType NoteProperty -Name "Ref reservation" -Value "$($result.refreservation.value)"
            $temp | Add-Member -MemberType NoteProperty -Name "Readonly" -Value "$($result.readonly.value)"
            $temp | Add-Member -MemberType NoteProperty -Name "Volume size" -Value "$($result.volsize.value)"
            $temp | Add-Member -MemberType NoteProperty -Name "Volume block size" -Value "$($result.volblocksize.value)"
            $TruenasVolume.Add($temp) | Out-Null

        }
        else
        {
            for ($i = 0; $i -lt $result.Count; $i++)
            {
                $temp = New-Object -TypeName System.Object
                $temp | Add-Member -MemberType NoteProperty -Name "Name" -Value "$($result[$i].name)"
                $temp | Add-Member -MemberType NoteProperty -Name "Id" -Value "$($result[$i].id)"
                $temp | Add-Member -MemberType NoteProperty -Name "Children" -Value "$($result[$i].children)"
                $temp | Add-Member -MemberType NoteProperty -Name "Type" -Value "$($result[$i].type)"
                $temp | Add-Member -MemberType NoteProperty -Name "Deduplication" -Value "$($result[$i].deduplication.value)"
                $temp | Add-Member -MemberType NoteProperty -Name "Sync" -Value "$($result[$i].sync.value)"
                $temp | Add-Member -MemberType NoteProperty -Name "Compression" -Value "$($result[$i].compression.value)"
                $temp | Add-Member -MemberType NoteProperty -Name "Compression ratio" -Value "$($result[$i].compressratio.value)"
                $temp | Add-Member -MemberType NoteProperty -Name "Ref reservation" -Value "$($result[$i].refreservation.value)"
                $temp | Add-Member -MemberType NoteProperty -Name "Readonly" -Value "$($result[$i].readonly.value)"
                $temp | Add-Member -MemberType NoteProperty -Name "Volume size" -Value "$($result[$i].volsize.value)"
                $temp | Add-Member -MemberType NoteProperty -Name "Volume block size" -Value "$($result[$i].volblocksize.value)"
                $TruenasVolume.Add($temp) | Out-Null
            }

        }


        return $TruenasVolume



    }
}
