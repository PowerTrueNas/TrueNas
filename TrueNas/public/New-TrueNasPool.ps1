function New-TrueNasPool
{

    [CmdletBinding()]
    [Alias()]
    [OutputType([int])]
    Param
    (

        [Parameter (Mandatory = $true)]
        [string]$PoolName,
        [Parameter (Mandatory = $true)]
        [Bool]$Encryption,
        [Parameter (Mandatory = $true)]
        [ValidateSet("ON", "VERIFY", "OFF")]
        $Deduplication,
        [Parameter (Mandatory = $true)]
        [ValidateSet("Data", "DataCache", "DataCacheLog", "DataCacheLogSpare", "DataCacheSpare", "DataLogSpare")]
        [String]$PoolDesign,
        [Parameter (Mandatory = $true)]
        [ValidateSet("STRIPE", "MIRROR", "RAIDZ1", "RAIDZ2", "RAIDZ3")]
        [String]$DataVdevType,
        [Parameter (Mandatory = $False)]
        [ValidateSet("STRIPE", "MIRROR", "RAIDZ1", "RAIDZ2", "RAIDZ3")]
        [String]$CacheVdevType,
        [Parameter (Mandatory = $False)]
        [ValidateSet("STRIPE", "MIRROR", "RAIDZ1", "RAIDZ2", "RAIDZ3")]
        [String]$LogVdevType,
        [Parameter (Mandatory = $false)]
        [ValidateSet("yes")]
        $force,
        [Parameter (Mandatory = $false)]
        [String]$DiskNamebase = "da",
        [Parameter (Mandatory = $true)]
        [Int]$NbDataDisks,
        [Parameter (Mandatory = $false)]
        [Int]$NbCacheDisks,
        [Parameter (Mandatory = $false)]
        [Int]$NbLogDisks,
        [Parameter (Mandatory = $false)]
        [Int]$NbSpareDisks,
        [Parameter (Mandatory = $false)]
        [Int]$StartDataDisksNB = 1,
        [Parameter (Mandatory = $false)]
        [Int]$StartCacheDisksNB = 1,
        [Parameter (Mandatory = $false)]
        [Int]$StartLogDisksNB = 1,
        [Parameter (Mandatory = $false)]
        [Int]$StartSpareDisksNB = 1
    )
    Begin
    {
        $Uri = "api/v2.0/pool"
    }
    Process
    {
        $TruenasDataVolume = @()
        $StartDataDisksNB..$($StartDataDisksNB + $NbDataDisks - 1) | Foreach-Object { $TruenasDataVolume += "$DiskNamebase$_" }

        switch ($PoolDesign)
        {
            'Data'
            {
                $Obj = [Ordered]@{
                    name          = $PoolName
                    encryption    = $Encryption
                    deduplication = $Deduplication
                    topology      = [Ordered]@{
                        data = @(@{
                                type  = $DataVdevType
                                disks = $TruenasDataVolume
                            })
                    }
                }

            }
            'DataCache'
            {
                $TruenasCacheVolume = @()
                $StartCacheDisksNB..$($StartCacheDisksNB + $NbCacheDisks - 1) | Foreach-Object { $TruenasCacheVolume += "$DiskNamebase$_" }


                $Obj = [Ordered]@{
                    name          = $PoolName
                    encryption    = $Encryption
                    deduplication = $Deduplication
                    topology      = [Ordered]@{
                        data  = @(@{
                                type  = $DataVdevType
                                disks = $TruenasDataVolume
                            })
                        cache = @(@{
                                type  = $CacheVdevType
                                disks = @( $TruenasCacheVolume)
                            })
                    }
                }

            }
            'DataCacheLog'
            {
                $TruenasCacheVolume = @()
                $StartCacheDisksNB..$($StartCacheDisksNB + $NbCacheDisks - 1) | Foreach-Object { $TruenasCacheVolume += "$DiskNamebase$_" }

                $TruenasLogVolume = @()
                $StartLogDisksNB..$($StartLogDisksNB + $NbLogDisks - 1) | Foreach-Object { $TruenasLogVolume += "$DiskNamebase$_" }

                $Obj = [Ordered]@{
                    name          = $PoolName
                    encryption    = $Encryption
                    deduplication = $Deduplication
                    topology      = [Ordered]@{
                        data  = @(@{
                                type  = $DataVdevType
                                disks = $TruenasDataVolume
                            })
                        cache = @(@{
                                type  = $CacheVdevType
                                disks = @( $TruenasCacheVolume)
                            })
                        log   = @(@{
                                type  = $LogVdevType
                                disks = @( $TruenasLogVolume)
                            })
                    }
                }

            }
            'DataCacheLogSpare'
            {
                $TruenasCacheVolume = @()
                $StartCacheDisksNB..$($StartCacheDisksNB + $NbCacheDisks - 1) | Foreach-Object { $TruenasCacheVolume += "$DiskNamebase$_" }

                $TruenasLogVolume = @()
                $StartLogDisksNB..$($StartLogDisksNB + $NbLogDisks - 1) | Foreach-Object { $TruenasLogVolume += "$DiskNamebase$_" }

                $TruenasSpareVolume = @()
                $StartSpareDisksNB..$($StartSpareDisksNB + $NbSpareDisks - 1) | Foreach-Object { $TruenasSpareVolume += "$DiskNamebase$_" }

                $Obj = [Ordered]@{
                    name          = $PoolName
                    encryption    = $Encryption
                    deduplication = $Deduplication
                    topology      = [Ordered]@{
                        data   = @(@{
                                type  = $DataVdevType
                                disks = $TruenasDataVolume
                            })
                        cache  = @(@{
                                type  = $CacheVdevType
                                disks = @( $TruenasCacheVolume)
                            })
                        log    = @(@{
                                type  = $LogVdevType
                                disks = @( $TruenasLogVolume)
                            })
                        spares = @($TruenasSpareVolume)
                    }
                }

            }
            'DataCacheSpare'
            {

                $TruenasCacheVolume = @()
                $StartCacheDisksNB..$($StartCacheDisksNB + $NbCacheDisks - 1) | Foreach-Object { $TruenasCacheVolume += "$DiskNamebase$_" }

                $TruenasSpareVolume = @()
                $StartSpareDisksNB..$($StartSpareDisksNB + $NbSpareDisks - 1) | Foreach-Object { $TruenasSpareVolume += "$DiskNamebase$_" }

                $Obj = [Ordered]@{
                    name          = $PoolName
                    encryption    = $Encryption
                    deduplication = $Deduplication
                    topology      = [Ordered]@{
                        data   = @(@{
                                type  = $DataVdevType
                                disks = $TruenasDataVolume
                            })
                        cache  = @(@{
                                type  = $CacheVdevType
                                disks = @( $TruenasCacheVolume)
                            })
                        spares = @($TruenasSpareVolume)
                    }
                }


            }
            'DataLogSpare'
            {

                $TruenasLogVolume = @()
                $StartLogDisksNB..$($StartLogDisksNB + $NbLogDisks - 1) | Foreach-Object { $TruenasLogVolume += "$DiskNamebase$_" }

                $TruenasSpareVolume = @()
                $StartSpareDisksNB..$($StartSpareDisksNB + $NbSpareDisks - 1) | Foreach-Object { $TruenasSpareVolume += "$DiskNamebase$_" }

                $Obj = [Ordered]@{
                    name          = $PoolName
                    encryption    = $Encryption
                    deduplication = $Deduplication
                    topology      = [Ordered]@{
                        data   = @(@{
                                type  = $DataVdevType
                                disks = $TruenasDataVolume
                            })
                        log    = @(@{
                                type  = $LogVdevType
                                disks = @( $TruenasLogVolume)
                            })
                        spares = @($TruenasSpareVolume)
                    }
                }


            }

        }
    }

    End
    {
        $response = Invoke-TrueNasRestMethod -Method Post -body $Obj -Uri $uri
        Write-host "PROGESS : " -ForegroundColor Green -NoNewline
        do
        {
            $Value = $((Get-TrueNasJob -Id $response).Progress).Substring(10, 2)
            $Test = $Value -match ".*\d+.*"
            if ($Test -eq "True")
            {
                Write-host "$value%" -ForegroundColor Yellow -NoNewline
                Write-Host "..." -NoNewline
            }
            else
            { }
        }
        While ((Get-TrueNasJob -Id $response).State -eq "RUNNING")

        if ((Get-TrueNasJob -Id $response).State -eq "SUCCESS" )
        {
            Write-host " "
            Write-Output "The creation for the  $PoolName is finished "
            return $Obj
        }
        else
        {
            Write-Warning -Message "The opperation finish with some error"
            Get-TrueNasJob -Id $response
        }

    }
}
