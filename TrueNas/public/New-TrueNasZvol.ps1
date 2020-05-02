function New-TrueNasZvol
{

    [CmdletBinding()]
    [Alias()]
    [OutputType([int])]
    Param
    (

        [Parameter (Mandatory = $true)]
        [string]$Name,

        [Parameter (Mandatory = $true)]
        [string]$ZvolName,

        [Parameter (Mandatory = $true)]
        [Int]$Volsize,

        [Parameter (Mandatory = $true)]
        [ValidateSet("VOLUME", "FILESYSTEM")]
        [String]$Type = "VOLUME",

        [Parameter (Mandatory = $true)]
        [ValidateSet( "MiB", "GiB", "TiB")]
        [String]$Unit = "GiB",


        [Parameter (Mandatory = $False)]
        [ValidateSet("OFF", "LZ4", "GZIP", "GZIP-1", "GZIP-9", "ZLE", "LZJB")]
        [String]$Compression = "lz4",

        [Parameter (Mandatory = $False)]
        [bool]$Sparse,

        [Parameter (Mandatory = $False)]
        [bool]$Forcesize,

        [Parameter (Mandatory = $False)]
        [ValidateSet("4K", "8K", "16K" , "32K", "64K", "128K")]
        [String]$BlokSize = "4K",

        [Parameter (Mandatory = $False)]
        [String]$Comment
    )


    Begin
    {

    }

    Process
    {

        $Uri = "api/v2.0/pool/dataset"


        $Zvolc = new-Object -TypeName PSObject


        if ( $PsBoundParameters.ContainsKey('ZvolName') )
        {
            $Zvolc | add-member -name "name" -membertype NoteProperty -Value $ZvolName/$Name
        }
        if ( $PsBoundParameters.ContainsKey('Type') )
        {
            $Zvolc | add-member -name "type" -membertype NoteProperty -Value $Type
        }

        if ( $PsBoundParameters.ContainsKey('Volsize') -and $PsBoundParameters.ContainsKey('Unit') )
        {
            switch ($Unit)
            {
                'MiB' { $size = ($Volsize * 1024 * 1024) }
                'GiB' { $size = ($Volsize * 1024 * 1024 * 1024) }
                'TiB' { $size = ($Volsize * 1024 * 1024 * 1024 * 1024) }
                Default { }
            }
            $Zvolc | add-member -name "volsize" -membertype NoteProperty -Value $Size
        }
        if ( $PsBoundParameters.ContainsKey('Sparse') )
        {
            $Zvolc | add-member -name "sparse" -membertype NoteProperty -Value $Sparse
        }
        if ( $PsBoundParameters.ContainsKey('Forcesize') )
        {
            $Zvolc | add-member -name "force_size" -membertype NoteProperty -Value $Forcesize
        }
        if ( $PsBoundParameters.ContainsKey('Compression') )
        {
            $Zvolc | add-member -name "compression" -membertype NoteProperty -Value $Compression
        }
        if ( $PsBoundParameters.ContainsKey('Comment') )
        {
            $Zvolc | add-member -name "comments" -membertype NoteProperty -Value $Comment
        }
        if ( $PsBoundParameters.ContainsKey('BlokSize') )
        {
            $Zvolc | add-member -name "blocksize" -membertype NoteProperty -Value $BlokSize
        }

        $response = Invoke-TrueNasRestMethod -method Post -body $Zvolc -Uri $Uri

    }

    End
    {
    }
}
