function Get-TrueNasUpdateTrain
{
    Param
    ( )

    Begin
    {

    }
    Process
    {
        $Uri = "api/v2.0/update/get_trains"

        $result = Invoke-TrueNasRestMethod -Uri $Uri -Method Get

        $results = $result | foreach-object { $_.trains.psobject.properties }
    }
    End
    {
        $Available = New-Object -TypeName System.Collections.ArrayList

        $temp = New-Object -TypeName PSObject
        $temp | Add-Member -MemberType NoteProperty -Name "Current profile" -Value $result.current
        $temp | Add-Member -MemberType NoteProperty -Name "Current selected" -Value $result.selected
        for ($i = 0; $i -lt $results.Count; $i++)
        {

            $temp | Add-Member -MemberType NoteProperty -Name "Profile Available $i" -Value $results[$i].Name
            $temp | Add-Member -MemberType NoteProperty -Name "Profile $i description" -Value $results[$i].Value.description

        }
        $Available.Add($temp) | Out-Null

        return $Available
    }
}
