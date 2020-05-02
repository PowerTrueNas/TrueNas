function Get-TrueNasJob
{
    [CmdletBinding()]

    Param(
        [Parameter (Mandatory = $false)]
        [Int]$Id,
        [ValidateSet("First", "Last", "FiveLast")]
        $Property
    )

    Begin
    {

    }
    Process
    {
        $Uri = "api/v2.0/core/get_jobs"
        $result = Invoke-TrueNasRestMethod -Uri $Uri -Method Get

    }
    End
    {
        $TrueNasJobs = New-Object -TypeName System.Collections.ArrayList

        if ( $PsBoundParameters.ContainsKey('Id'))
        {
            $result = $result | Where-Object { $_.id -eq "$id" }
            $temp = New-Object -TypeName System.Object
            $temp | Add-Member -MemberType NoteProperty -Name "Id" -Value "$($result.id)"
            $temp | Add-Member -MemberType NoteProperty -Name "Method" -Value "$($result.method)"
            $temp | Add-Member -MemberType NoteProperty -Name "Arguments" -Value "$($result.arguments)"
            $temp | Add-Member -MemberType NoteProperty -Name "Logs path" -Value "$($result.logs_path)"
            $temp | Add-Member -MemberType NoteProperty -Name "logs excerpt" -Value "$($result.logs_excerpt)"
            $temp | Add-Member -MemberType NoteProperty -Name "Progress" -Value "$($result.progress)"
            $temp | Add-Member -MemberType NoteProperty -Name "Result" -Value "$($result.result)"
            $temp | Add-Member -MemberType NoteProperty -Name "Error" -Value "$($result.error)"
            $temp | Add-Member -MemberType NoteProperty -Name "Exception" -Value "$($result.exception)"
            $temp | Add-Member -MemberType NoteProperty -Name "Exc info" -Value "$($result.exc_info)"
            $temp | Add-Member -MemberType NoteProperty -Name "State" -Value "$($result.state)"
            $TrueNasJobs.Add($temp) | Out-Null

        }
        elseif ( $PsBoundParameters.ContainsKey('Property'))
        {
            switch ($Property)
            {

                'First'
                {
                    $result = $result | Select-Object -First 1
                    $temp = New-Object -TypeName System.Object
                    $temp | Add-Member -MemberType NoteProperty -Name "Id" -Value "$($result.id)"
                    $temp | Add-Member -MemberType NoteProperty -Name "Method" -Value "$($result.method)"
                    $temp | Add-Member -MemberType NoteProperty -Name "Arguments" -Value "$($result.arguments)"
                    $temp | Add-Member -MemberType NoteProperty -Name "Logs path" -Value "$($result.logs_path)"
                    $temp | Add-Member -MemberType NoteProperty -Name "logs excerpt" -Value "$($result.logs_excerpt)"
                    $temp | Add-Member -MemberType NoteProperty -Name "Progress" -Value "$($result.progress)"
                    $temp | Add-Member -MemberType NoteProperty -Name "Result" -Value "$($result.result)"
                    $temp | Add-Member -MemberType NoteProperty -Name "Error" -Value "$($result.error)"
                    $temp | Add-Member -MemberType NoteProperty -Name "Exception" -Value "$($result.exception)"
                    $temp | Add-Member -MemberType NoteProperty -Name "Exc info" -Value "$($result.exc_info)"
                    $temp | Add-Member -MemberType NoteProperty -Name "State" -Value "$($result.state)"
                    $TrueNasJobs.Add($temp) | Out-Null
                }
                'Last'
                {
                    $result = $result | Select-Object -Last 1
                    $temp = New-Object -TypeName System.Object
                    $temp | Add-Member -MemberType NoteProperty -Name "Id" -Value "$($result.id)"
                    $temp | Add-Member -MemberType NoteProperty -Name "Method" -Value "$($result.method)"
                    $temp | Add-Member -MemberType NoteProperty -Name "Arguments" -Value "$($result.arguments)"
                    $temp | Add-Member -MemberType NoteProperty -Name "Logs path" -Value "$($result.logs_path)"
                    $temp | Add-Member -MemberType NoteProperty -Name "logs excerpt" -Value "$($result.logs_excerpt)"
                    $temp | Add-Member -MemberType NoteProperty -Name "Progress" -Value "$($result.progress)"
                    $temp | Add-Member -MemberType NoteProperty -Name "Result" -Value "$($result.result)"
                    $temp | Add-Member -MemberType NoteProperty -Name "Error" -Value "$($result.error)"
                    $temp | Add-Member -MemberType NoteProperty -Name "Exception" -Value "$($result.exception)"
                    $temp | Add-Member -MemberType NoteProperty -Name "Exc info" -Value "$($result.exc_info)"
                    $temp | Add-Member -MemberType NoteProperty -Name "State" -Value "$($result.state)"
                    $TrueNasJobs.Add($temp) | Out-Null

                }
                'fiveLast'
                {
                    $result = $result | Select-Object -Last 5
                    for ($i = 0; $i -lt $result.Count; $i++)
                    {
                        $temp = New-Object -TypeName System.Object
                        $temp | Add-Member -MemberType NoteProperty -Name "Id" -Value "$($result[$i].id)"
                        $temp | Add-Member -MemberType NoteProperty -Name "Method" -Value "$($result[$i].method)"
                        $temp | Add-Member -MemberType NoteProperty -Name "Arguments" -Value "$($result[$i].arguments)"
                        $temp | Add-Member -MemberType NoteProperty -Name "Logs path" -Value "$($result[$i].logs_path)"
                        $temp | Add-Member -MemberType NoteProperty -Name "logs excerpt" -Value "$($result[$i].logs_excerpt)"
                        $temp | Add-Member -MemberType NoteProperty -Name "Progress" -Value "$($result[$i].progress)"
                        $temp | Add-Member -MemberType NoteProperty -Name "Result" -Value "$($result[$i].result)"
                        $temp | Add-Member -MemberType NoteProperty -Name "Error" -Value "$($result[$i].error)"
                        $temp | Add-Member -MemberType NoteProperty -Name "Exception" -Value "$($result[$i].exception)"
                        $temp | Add-Member -MemberType NoteProperty -Name "Exc info" -Value "$($result[$i].exc_info)"
                        $temp | Add-Member -MemberType NoteProperty -Name "State" -Value "$($result[$i].state)"
                        $TrueNasJobs.Add($temp) | Out-Null
                    }
                }
            }
        }
        else
        {

            if ($null -eq $result.count)
            {
                $temp = New-Object -TypeName System.Object
                $temp | Add-Member -MemberType NoteProperty -Name "Id" -Value "$($result.id)"
                $temp | Add-Member -MemberType NoteProperty -Name "Method" -Value "$($result.method)"
                $temp | Add-Member -MemberType NoteProperty -Name "Arguments" -Value "$($result.arguments)"
                $temp | Add-Member -MemberType NoteProperty -Name "Logs path" -Value "$($result.logs_path)"
                $temp | Add-Member -MemberType NoteProperty -Name "logs excerpt" -Value "$($result.logs_excerpt)"
                $temp | Add-Member -MemberType NoteProperty -Name "Progress" -Value "$($result.progress)"
                $temp | Add-Member -MemberType NoteProperty -Name "Result" -Value "$($result.result)"
                $temp | Add-Member -MemberType NoteProperty -Name "Error" -Value "$($result.error)"
                $temp | Add-Member -MemberType NoteProperty -Name "Exception" -Value "$($result.exception)"
                $temp | Add-Member -MemberType NoteProperty -Name "Exc info" -Value "$($result.exc_info)"
                $temp | Add-Member -MemberType NoteProperty -Name "State" -Value "$($result.state)"
                $TrueNasJobs.Add($temp) | Out-Null

            }
            else
            {
                for ($i = 0; $i -lt $result.Count; $i++)
                {
                    $temp = New-Object -TypeName System.Object
                    $temp | Add-Member -MemberType NoteProperty -Name "Id" -Value "$($result[$i].id)"
                    $temp | Add-Member -MemberType NoteProperty -Name "Method" -Value "$($result[$i].method)"
                    $temp | Add-Member -MemberType NoteProperty -Name "Arguments" -Value "$($result[$i].arguments)"
                    $temp | Add-Member -MemberType NoteProperty -Name "Logs path" -Value "$($result[$i].logs_path)"
                    $temp | Add-Member -MemberType NoteProperty -Name "logs excerpt" -Value "$($result[$i].logs_excerpt)"
                    $temp | Add-Member -MemberType NoteProperty -Name "Progress" -Value "$($result[$i].progress)"
                    $temp | Add-Member -MemberType NoteProperty -Name "Result" -Value "$($result[$i].result)"
                    $temp | Add-Member -MemberType NoteProperty -Name "Error" -Value "$($result[$i].error)"
                    $temp | Add-Member -MemberType NoteProperty -Name "Exception" -Value "$($result[$i].exception)"
                    $temp | Add-Member -MemberType NoteProperty -Name "Exc info" -Value "$($result[$i].exc_info)"
                    $temp | Add-Member -MemberType NoteProperty -Name "State" -Value "$($result[$i].state)"
                    $TrueNasJobs.Add($temp) | Out-Null
                }

            }

        }

        return $TrueNasJobs
    }
}
