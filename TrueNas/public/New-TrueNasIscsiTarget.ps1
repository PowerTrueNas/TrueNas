function New-TrueNasIscsiTarget
{
    [CmdletBinding()]
    [Alias()]
    [OutputType([int])]
    Param
    (
        [Parameter (Mandatory = $true)]
        [string]$TargetName,

        [Parameter (Mandatory = $true)]
        [string]$TargetAlias,

        [Parameter (Mandatory = $true)]
        [Int]$GroupsPortalId,

        [Parameter (Mandatory = $true)]
        [Int]$GroupsInitiatorId,

        [Parameter (Mandatory = $false)]
        [int]$Auth,

        [Parameter (Mandatory = $false)]
        [string]$Authmethod = "NONE",

        [Parameter (Mandatory = $false)]
        [string]$TargetMode = "ISCSI"


    )
    Begin
    {

    }
    Process
    {
        $Uri = "api/v2.0/iscsi/target"

        $Obj = new-Object -TypeName PSObject

        $Obj = [Ordered]@{

            name   = $TargetName.ToLower()
            alias  = $TargetAlias.ToLower()
            mode   = $TargetMode.ToUpper()
            groups = @([Ordered]@{
                    portal     = $GroupsPortalId
                    initiator  = $GroupsInitiatorId
                    auth       = $Auth
                    authmethod = $Authmethod
                })
        }

        $response = Invoke-TrueNasRestMethod -method Post -body $Obj -Uri $Uri


    }
    End
    { }
}
