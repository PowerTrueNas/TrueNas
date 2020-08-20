########### Tools to find API Path The JSON is description.json#########################
Invoke-WebRequest -Uri http://192.168.1.64/api/v2.0 -OutFile .\description.json
$JSON = Get-Content '.\Projet{}\V2\description.json' | ConvertFrom-Json -Depth 8
function ConvertTo-Hashtable
{
    [CmdletBinding()]
    [OutputType('hashtable')]
    param (
        [Parameter(ValueFromPipeline)]
        $InputObject
    )

    process
    {
        ## Return null if the input is null. This can happen when calling the function
        ## recursively and a property is null
        if ($null -eq $InputObject)
        {
            return $null
        }

        ## Check if the input is an array or collection. If so, we also need to convert
        ## those types into hash tables as well. This function will convert all child
        ## objects into hash tables (if applicable)
        if ($InputObject -is [System.Collections.IEnumerable] -and $InputObject -isnot [string])
        {
            $collection = @(
                foreach ($object in $InputObject)
                {
                    ConvertTo-Hashtable -InputObject $object
                }
            )

            ## Return the array but don't enumerate it because the object may be pretty complex
            Write-Output -NoEnumerate $collection
        }
        elseif ($InputObject -is [psobject])
        {
            ## If the object has properties that need enumeration
            ## Convert it to its own hash table and return it
            $hash = @{}
            foreach ($property in $InputObject.PSObject.Properties)
            {
                $hash[$property.Name] = ConvertTo-Hashtable -InputObject $property.Value
            }
            $hash
        }
        else
        {
            ## If the object isn't an array, collection, or other object, it's already a hash table
            ## So just return it.
            $InputObject
        }
    }
}
$ta = $JSON | ConvertTo-Hashtable
$Tableau = $ta.paths.GetEnumerator() | Sort-Object -Property Key | Foreach-Object {
    $Methods = $_.value
    $Path = $_.Key
    $ListMethods = @()

    $Methods.GetEnumerator() | Foreach-Object {
        #$rr = $_.value
        $zz = $_.Key
        $ListMethods += $zz
    }

    $Domains_values = New-Object PSObject
    $Domains_values = $Domains_values | Add-Member NoteProperty Path $Path -passthru
    $Domains_values = $Domains_values | Add-Member NoteProperty Methods $ListMethods -passthru
    $Domains_values = $Domains_values | Add-Member NoteProperty NumberMethods $ListMethods.count -passthru
    $Domains_values = $Domains_values | Add-Member NoteProperty Category $Path.Split("/")[1] -passthru
    return $Domains_values


}
# Full Path and methods and category
$Tableau

#Count Method by Category
$results = $Tableau | select -Property Category, NumberMethods | group Category | select Count, Name

write-host "there is" $($results | Measure-Object Count -Sum).Sum "methods"

$category = @()
$Tableau | select -Property Path | ForEach-Object {


    $name = $_.Path.split("/")[1]
    $category += $name

}
$UniqueCategory = $($category | select -Unique).count

foreach ($item in $UniqueCategory)
{

    write-host "trying" for $item

    $result = $Tableau | where { $_.Category -eq "interface" }


}

function New-TrueNasClass
{
    [CmdletBinding()]
    Param
    (
        [Parameter (Mandatory = $true)]
        $FileName,
        [Parameter (Mandatory = $true)]
        [Array]$Methods

    )

    begin
    {
        $test = Test-Path -Path ".\Projet{}\V2\$FileName"
        $name = "Class_" + $FileName + ".ps1"
        New-Item -Name $name -ItemType File -Force
        $SkipMethod = "MethodSkip.txt"
        New-Item -Name $SkipMethod -ItemType File -Force
    }
    process
    {
        [String]$Headers = "class TrueNas$Filename :TrueNasConfiguration
    {
        [String]`$CommonName
        [String]`$Uri
        [PSobject]`$Params

        TrueNas$Filename([TrueNasConfiguration]`$param):base($param)
    {
    }"
        $Headers | Out-File -FilePath $name -Append

        $result = $Methods | where { $_.Category -eq "$filename" }

        foreach ($item in $result)
        {
            if ($item.NumberMethods -eq 1)
            {
                $NameMethods = $item.path.Replace("/", "")
                $MethodsUse = $item.path.Methods
                $ClassMethod = $MethodsUse + $NameMethods
                $Path = $($item.path).substring(1, $($item.path).Length - 1)
                $MethodsUse = $($item.Methods[0]).toupper()
                $prefix = $MethodsUse.ToLower()
                if ($ClassMethod -like "*{id}*")
                {
                    $skip = "skip $prefix$ClassMethod"
                    $skip | Out-File -FilePath SkipMethod -Append
                }
                else
                {
                    if (($prefix -eq "post") -or ($prefix -eq "put"))
                    {
                        $Text = "    [object]$prefix$ClassMethod([psobject]`$Body)
                    {
                                `$reponse = $this.TrueNasRestMethod(`"$Path`" , `"$MethodsUse`", `$Body)
                                return `$reponse
                    }"
                        $Text | Out-File -FilePath $name -Append

                    }
                    else
                    {
                        $Text = "    [object]$prefix$ClassMethod()
                    {
                                `$reponse = $this.TrueNasRestMethod(`"$Path`" , `"$MethodsUse`")
                                return `$reponse
                    }"
                        $Text | Out-File -FilePath $name -Append
                    }
                }
            }
            else
            {
                $NameMethods = $item.path.Replace("/", "")
                $MethodsUse = $item.path.Methods
                $ClassMethod = $MethodsUse + $NameMethods
                $Path = $($item.path).substring(1, $($item.path).Length - 1)
                if ($ClassMethod -like "*{id}*")
                {
                    $skip = "skip $prefix$ClassMethod"
                    $skip | Out-File -FilePath SkipMethod -Append
                }
                else
                {
                    for ($i = 0; $i -lt $($item.Methods).Count; $i++)
                    {

                        $MethodsUse = $($item.Methods[$i]).toupper()
                        $prefix = $MethodsUse.ToLower()
                        if (($prefix -eq "post") -or ($prefix -eq "put"))
                        {
                            $Text = "    [object]$prefix$ClassMethod([psobject]`$Body)
                    {
                                `$reponse = $this.TrueNasRestMethod(`"$Path`" , `"$MethodsUse`", `$Body)
                                return `$reponse
                    }"
                            $Text | Out-File -FilePath $name -Append

                        }
                        else
                        {
                            $Text = "    [object]$prefix$ClassMethod()
                    {
                                `$reponse = $this.TrueNasRestMethod(`"$Path`" , `"$MethodsUse`")
                                return `$reponse
                    }"
                            $Text | Out-File -FilePath $name -Append
                        }
                    }
                }
            }
        }
    }
    end
    {
        $text = "}"
        $Text | Out-File -FilePath $name -Append
    }
}

$UniqueCategory = $($category | select -Unique)

foreach ($item in $UniqueCategory)
{

    New-TrueNasClass -FileName $item -Methods $Tableau
}

#New-TrueNasClass -FileName Interface -Methods $Tableau

########### Tools to find API Path The JSON is description.json#########################
