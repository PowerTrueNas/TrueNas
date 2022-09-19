function Get-TrueNasModuleBase
{
    [CmdletBinding()]
    [OutputType([System.String])]
    param (
    )

    return $MyInvocation.MyCommand.Module.ModuleBase
}