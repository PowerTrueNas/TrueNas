function New-TrueNasIscsiExtent
{

    [CmdletBinding()]
    [Alias()]
    [OutputType([int])]
    Param
    (

        [Parameter (Mandatory = $true)]
        [string]$ExtentName,

        [Parameter (Mandatory = $true)]
        [ValidateSet("DISK", "Zvol", "File")]
        [String]$ExtenType,

        [Parameter (Mandatory = $false)]
        [String]$TrueNasPoolName,

        [Parameter (Mandatory = $false)]
        [String]$TrueNasZvolName,


        [Parameter (Mandatory = $true)]
        [ValidateSet("Unknown", "SSD", "5400", "7200", "10000", "15000")]
        $ExtentSpeed,

        [Parameter (Mandatory = $false)]
        [string]$ExtendComment,

        [Parameter (Mandatory = $false)]
        [String]$ExtenDiskPath

    )


    Begin
    {

    }

    Process
    {
        $Uri = "api/v2.0/iscsi/extent"

        switch ($ExtenType)
        {
            Zvol
            {
                $ExtenType = "DISK"
                $ExtenDiskPath = 'zvol/' + $TrueNasPoolName + '/' + $TrueNasZvolName
                $Obj = [Ordered]@{
                    name         = $ExtentName
                    type         = $ExtenType
                    disk         = $ExtenDiskPath
                    comment      = $ExtendComment
                    insecure_tpc = $true
                    xen          = $true
                    rpm          = $ExtentSpeed
                    ro           = $true
                    enabled      = $true
                }

            }
            DISK
            {
                $Obj = [Ordered]@{
                    name         = $ExtentName
                    type         = $ExtenType
                    disk         = $ExtenDiskPath
                    comment      = $ExtendComment
                    insecure_tpc = $true
                    xen          = $true
                    rpm          = $ExtentSpeed
                    ro           = $true
                    enabled      = $true
                }
            }
            File { Write-Warning "Not implemented yet..." }
            Default { }
        }
        Invoke-TrueNasRestMethod -method Post -body $Obj -Uri $Uri

    }
    End
    { }

}
