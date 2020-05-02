$Global:Current_Folder = split-path $MyInvocation.MyCommand.Path
Set-Location $Global:Current_Folder
cd ..
cd FreeNas
$Private = gci -Recurse -Path ./private
$Public = gci -Recurse -Path ./public

foreach ($Files in $Private)
{
    Get-Content -Path ./private/$Files| Out-File -Append -FilePath $Global:Current_Folder\Env_dev_FreeNas.ps1
}
foreach ($Files in $Public)
{
    Get-Content -Path ./public/$Files | Out-File -Append -FilePath $Global:Current_Folder\Env_dev_FreeNas.ps1
}
cd ..