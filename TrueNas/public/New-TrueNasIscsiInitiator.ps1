function New-TrueNasIscsiInitiator
{
    [CmdletBinding()]
    [Alias()]
    [OutputType([int])]
    Param
    (

        [Parameter (Mandatory = $False)]
        [ValidateSet("ALL")]
        [string]$AuthInitiators = "ALL",

        [Parameter (Mandatory = $False)]
        [ValidateSet("ALL")]
        [String]$AuthNetwork = "ALL",
        [Parameter (Mandatory = $False)]
        [String]$comment

    )


    Begin
    {
        if ( $AuthInitiators -eq "ALL")
        {
            $AuthInitiator = ""
        }
        else { $AuthInitiators = $AuthInitiator }

        if ( $AuthNetwork -eq "ALL")
        {
            $AuthNetworks = ""
        }
        else { $AuthNetwork = $AuthNetworks }
    }
    Process
    {
        $Uri = "api/v2.0/iscsi/initiator"

        $Obj = [Ordered]@{

            initiators   = @($AuthInitiator)
            auth_network = @($AuthNetworks)
            comment      = $comment
        }


        $result = Invoke-TrueNasRestMethod -Method Post -body $Obj -Uri $uri


    }
    End
    { }
}
