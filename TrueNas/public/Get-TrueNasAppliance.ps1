function Get-TrueNasAppliance
{
    [OutputType([System.IO.FileInfo])]
    [CmdletBinding()]

    param
  ()

    DynamicParam
    {
        $folderBase = Get-TrueNasModuleBase
        $FolderJson = Join-path $folderBase -ChildPath 'Appliances'
        $FolderAria2c = Join-path $folderBase -ChildPath "Aria2c"
        join-TrueNasAppliance -sourceDir $FolderJson
        $ParamAttrib = New-Object System.Management.Automation.ParameterAttribute

        $ParamAttrib.Mandatory = $true

        $ParamAttrib.ParameterSetName = '__AllParameterSets'
        $AttribColl = New-Object  System.Collections.ObjectModel.Collection[System.Attribute]
        $AttribColl.Add($ParamAttrib)
        $configurationFileNames = (Get-ChildItem -Path $FolderJson -file -Filter *.json).BaseName
        $AttribColl.Add((New-Object  System.Management.Automation.ValidateSetAttribute($configurationFileNames)))

        $RuntimeParam = New-Object System.Management.Automation.RuntimeDefinedParameter('ApplianceVersion', [string], $AttribColl)

        $RuntimeParamDic = New-Object System.Management.Automation.RuntimeDefinedParameterDictionary

        $RuntimeParamDic.Add('ApplianceVersion', $RuntimeParam)

        return  $RuntimeParamDic
    }

    process
    {
        $folderBase = Get-TrueNasModuleBase
        $FolderJson = Join-path $folderBase -ChildPath 'Appliances'
        $FolderAria2c = Join-path $folderBase -ChildPath "Aria2c"
        $folderDestination = "c:\TrueNas\Appliances"

        if (!(Test-Path $folderDestination))
        {
            New-Item -ItemType Directory -Path $folderDestination -force | out-null
        }

        write-host  "$($PSBoundParameters.ApplianceVersion)" -ForegroundColor Green -NoNewline
        write-host  " is selected for download"

        $json = Get-Content -path  "$FolderJson\$($PSBoundParameters.ApplianceVersion).json" -Raw | ConvertFrom-Json
        New-Item -Path $FolderJson -Name donwloads.txt -Force | Out-Null

        #Create the aria2c script for the download
        for ($i = 0; $i -lt $json.Count; $i++)
        {

            #Extract URI for Appliance
            $json[$i].URL_public | Out-File "$FolderJson\donwloads.txt" -Append

            #Extract FileName for Appliance FileName
            $json[$i].FileName | % { $out = "   out=" + "$_" | Out-File "$FolderJson\donwloads.txt" -Append }
            $json[$i].Hash -split " "  | % { $out = "   checksum=" + "sha-256=" + "$_" | Out-File "$FolderJson\donwloads.txt" -Append }
            $endfile = "`n" | Out-File "$FolderJson\donwloads.txt" -Append
        }

        $Aria2cSource = "$FolderAria2c\aria2c.exe"
        $ArgumentList = "--no-conf --log-level=info --download-result=hide --optimize-concurrent-downloads --file-allocation=none --log=TrueNasdowload.log"
        $ArgumentList1 = "-x16 -s16 -j3 -c -V -R -d"
        $ArgumentList2 = "-i"

        $file = "$FolderJson\donwloads.txt"

        Start-Process -FilePath $Aria2cSource -ArgumentList "$ArgumentList $ArgumentList1 $folderDestination $ArgumentList2 $file" -Wait -NoNewWindow

        remove-item -Path "$FolderJson\donwloads.txt" -Force -ErrorAction SilentlyContinue | Out-Null
    }
}
