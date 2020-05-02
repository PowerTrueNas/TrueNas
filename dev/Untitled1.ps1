$PoolName = "toto"
        $encryption = $true
        $deduplication = "null"
        $FreenasDataVolume = ("da1","da2","da3")
        $DataVdevType = "RAIDZ2"


 
 
 $Obj = [Ordered]@{
                name = $PoolName
                encryption = $Encryption
                deduplication = $Deduplication
                topology = [Ordered]@{
                data      = @(@{
                        type     = $DataVdevType
                        disks    = $FreenasDataVolume
                    })
                
            }

            }

$Post = $Obj |ConvertTo-Json -Depth 5 
$Post
