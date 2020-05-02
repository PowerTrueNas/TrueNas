function Get-TrueNasIscsiAssociat2Extent
{
    [CmdletBinding()]
    [Alias()]
    [OutputType([int])]
    Param
    (
        [ValidateSet("Id", "Name")]
        [string]$Output = "Id"

    )


    Begin
    {

    }
    Process
    {
        $Uri = "api/v2.0/iscsi/targetextent"

        $result = Invoke-TrueNasRestMethod -Uri $Uri -Method Get

        switch ($Output)
        {
            'Id'
            {
                $TruenasIscsiAssociat2Extent = New-Object -TypeName System.Collections.ArrayList
                if ($null -eq $result.count)
                {
                    $temp = New-Object -TypeName System.Object
                    $temp | Add-Member -MemberType NoteProperty -Name "Id" -Value "$($result.id)"
                    $temp | Add-Member -MemberType NoteProperty -Name "Iscsi Extent Id" -Value "$($result.extent)"
                    $temp | Add-Member -MemberType NoteProperty -Name "Iscsi Lun Id" -Value "$($result.lunid)"
                    $temp | Add-Member -MemberType NoteProperty -Name "Iscsi Target Id" -Value "$($result.target)"
                    $TruenasIscsiAssociat2Extent.Add($temp) | Out-Null
                }

                for ($i = 0; $i -lt $result.Count; $i++)
                {
                    $temp = New-Object -TypeName System.Object
                    $temp | Add-Member -MemberType NoteProperty -Name "Id" -Value "$($result[$i].id)"
                    $temp | Add-Member -MemberType NoteProperty -Name "Iscsi Extent Id" -Value "$($result[$i].extent)"
                    $temp | Add-Member -MemberType NoteProperty -Name "Iscsi Lun Id" -Value "$($result[$i].lunid)"
                    $temp | Add-Member -MemberType NoteProperty -Name "Iscsi Target Id" -Value "$($result[$i].target)"

                    $TruenasIscsiAssociat2Extent.Add($temp) | Out-Null
                }
            }
            'Name'
            {
                $TruenasIscsiAssociat2Extent = New-Object -TypeName System.Collections.ArrayList

                if ($null -eq $result.Count)
                {
                    $value = $result.extent
                    $value2 = $result.target
                    $TargetName = Get-TruenasIscsiTarget
                    $IscsiExtend = Get-TruenasIscsiExtent

                    foreach ($item in $TargetName)
                    {
                        if ( $Item.Id -eq $value2 )
                        {
                            $TargetNameF = $item.'Target name'
                        }

                    }

                    foreach ($item in $IscsiExtend)
                    {
                        if ( $Item.Id -eq $value )
                        {
                            $IscsiExtendF = $item.'Extent Name'
                        }
                    }
                    $temp = New-Object -TypeName System.Object
                    $temp | Add-Member -MemberType NoteProperty -Name "Id" -Value "$($result.Id)"
                    $temp | Add-Member -MemberType NoteProperty -Name "Iscsi_Extent_Name" -Value $IscsiExtendF
                    $temp | Add-Member -MemberType NoteProperty -Name "LUN Id" -Value "$($result.lunid)"
                    $temp | Add-Member -MemberType NoteProperty -Name "Target_Name" -Value $TargetNameF

                    $TruenasIscsiAssociat2Extent.Add($temp) | Out-Null


                }


                for ($i = 0; $i -lt $result.Count; $i++)
                {
                    $value = $result[$i].extent
                    $value2 = $result[$i].target
                    $TargetName = Get-TruenasIscsiTarget
                    $IscsiExtend = Get-TruenasIscsiExtent


                    foreach ($item in $TargetName)
                    {
                        if ( $Item.Id -eq $value2 )
                        {
                            $TargetNameF = $item.'Target name'
                        }

                    }

                    foreach ($item in $IscsiExtend)
                    {
                        if ( $Item.Id -eq $value )
                        {
                            $IscsiExtendF = $item.'Extent Name'
                        }
                    }


                    $temp = New-Object -TypeName System.Object
                    $temp | Add-Member -MemberType NoteProperty -Name "Id" -Value "$($result[$i].Id)"
                    $temp | Add-Member -MemberType NoteProperty -Name "Iscsi_Extent_Name" -Value $IscsiExtendF
                    $temp | Add-Member -MemberType NoteProperty -Name "LUN Id" -Value "$($result[$i].lunid)"
                    $temp | Add-Member -MemberType NoteProperty -Name "Target_Name" -Value $TargetNameF

                    $TruenasIscsiAssociat2Extent.Add($temp) | Out-Null
                }

            }

        }

        return $TruenasIscsiAssociat2Extent
    }
    End
    { }
}
