function Get-TrueNasCertificate
{
    [CmdletBinding()]
    [Alias()]
    Param
    ()

    Begin
    {
        $uri = "api/v2.0/certificate/"
    }
    Process
    {
        Write-Verbose $uri
        $result = Invoke-TrueNasRestMethod -Uri $Uri -Method Get

        $Certificate = New-Object -TypeName System.Collections.ArrayList

        if ($null -eq $result.count)
        {

            $temp = New-Object -TypeName System.Object
            $temp | Add-Member -MemberType NoteProperty -Name "Name" -Value "$($result.name)"
            $temp | Add-Member -MemberType NoteProperty -Name "Id" -Value "$($result.id)"
            $temp | Add-Member -MemberType NoteProperty -Name "Type" -Value "$($result.type)"
            $temp | Add-Member -MemberType NoteProperty -Name "Certificate" -Value "$($result.certificate)"
            $temp | Add-Member -MemberType NoteProperty -Name "PrivateKey" -Value "$($result.privatekey)"
            $temp | Add-Member -MemberType NoteProperty -Name "CSR" -Value "$($result.CSR)"
            $temp | Add-Member -MemberType NoteProperty -Name "Signedby" -Value "$($result.signedby)"
            $temp | Add-Member -MemberType NoteProperty -Name "Root path" -Value "$($result.root_path)"
            $temp | Add-Member -MemberType NoteProperty -Name "Certificate path" -Value "$($result.certificate_path)"
            $temp | Add-Member -MemberType NoteProperty -Name "Private key path" -Value "$($result.private_key_path)"
            $temp | Add-Member -MemberType NoteProperty -Name "Csr path" -Value "$($result.csr_path)"
            $temp | Add-Member -MemberType NoteProperty -Name "Cert type" -Value "$($result.cert_type)"
            $temp | Add-Member -MemberType NoteProperty -Name "Issuer" -Value "$($result.issuer)"
            $temp | Add-Member -MemberType NoteProperty -Name "Chain list" -Value "$($result.chain_list)"
            $temp | Add-Member -MemberType NoteProperty -Name "Country" -Value "$($result.country)"
            $temp | Add-Member -MemberType NoteProperty -Name "State" -Value "$($result.state)"
            $temp | Add-Member -MemberType NoteProperty -Name "City" -Value "$($result.city)"
            $temp | Add-Member -MemberType NoteProperty -Name "Organization" -Value "$($result.organization)"
            $temp | Add-Member -MemberType NoteProperty -Name "Organizational unit" -Value "$($result.organization_unit)"
            $temp | Add-Member -MemberType NoteProperty -Name "Common" -Value "$($result.Common)"
            $temp | Add-Member -MemberType NoteProperty -Name "San" -Value "$($result.San)"
            $temp | Add-Member -MemberType NoteProperty -Name "Email" -Value "$($result.email)"
            $temp | Add-Member -MemberType NoteProperty -Name "DN" -Value "$($result.DN)"
            $temp | Add-Member -MemberType NoteProperty -Name "Digest_algorithm" -Value "$($result.digest_algorithm)"
            $temp | Add-Member -MemberType NoteProperty -Name "Lifetime" -Value "$($result.lifetime)"
            $temp | Add-Member -MemberType NoteProperty -Name "From" -Value "$($result.from)"
            $temp | Add-Member -MemberType NoteProperty -Name "Until" -Value "$($result.until)"
            $temp | Add-Member -MemberType NoteProperty -Name "Serial" -Value "$($result.serial)"
            $temp | Add-Member -MemberType NoteProperty -Name "Chain" -Value "$($result.chain)"
            $temp | Add-Member -MemberType NoteProperty -Name "Fingerprint" -Value "$($result.fingerprint)"
            $temp | Add-Member -MemberType NoteProperty -Name "Key lenght" -Value "$($result.key_length)"
            $temp | Add-Member -MemberType NoteProperty -Name "Key Type" -Value "$($result.key_type)"
            $temp | Add-Member -MemberType NoteProperty -Name "Parsed" -Value "$($result.parsed)"
            $temp | Add-Member -MemberType NoteProperty -Name "Internal" -Value "$($result.internal)"
            $temp | Add-Member -MemberType NoteProperty -Name "CA Type Existing" -Value "$($result.CA_type_existing)"
            $temp | Add-Member -MemberType NoteProperty -Name "CA type Internal" -Value "$($result.CA_type_internal)"
            $temp | Add-Member -MemberType NoteProperty -Name "CA type Intermediate" -Value "$($result.CA_type_intermediate)"
            $temp | Add-Member -MemberType NoteProperty -Name "Cert type existing" -Value "$($result.cert_type_existing)"
            $temp | Add-Member -MemberType NoteProperty -Name "Cert type Internal" -Value "$($result.cert_type_internal)"
            $temp | Add-Member -MemberType NoteProperty -Name "CA type CSR" -Value "$($result.cert_type_CSR)"
            $Certificate.Add($temp) | Out-Null
        }
        else
        {
            for ($i = 0; $i -lt $result.Count; $i++)
            {
                $temp = New-Object -TypeName System.Object
                $temp | Add-Member -MemberType NoteProperty -Name "Name" -Value "$($result[$i].name)"
                $temp | Add-Member -MemberType NoteProperty -Name "Id" -Value "$($result[$i].id)"
                $temp | Add-Member -MemberType NoteProperty -Name "Type" -Value "$($result[$i].type)"
                $temp | Add-Member -MemberType NoteProperty -Name "Certificate" -Value "$($result[$i].certificate)"
                $temp | Add-Member -MemberType NoteProperty -Name "PrivateKey" -Value "$($result[$i].privatekey)"
                $temp | Add-Member -MemberType NoteProperty -Name "CSR" -Value "$($result[$i].CSR)"
                $temp | Add-Member -MemberType NoteProperty -Name "Signedby" -Value "$($result[$i].signedby)"
                $temp | Add-Member -MemberType NoteProperty -Name "Root path" -Value "$($result[$i].root_path)"
                $temp | Add-Member -MemberType NoteProperty -Name "Certificate path" -Value "$($result[$i].certificate_path)"
                $temp | Add-Member -MemberType NoteProperty -Name "Private key path" -Value "$($result[$i].private_key_path)"
                $temp | Add-Member -MemberType NoteProperty -Name "Csr path" -Value "$($result[$i].csr_path)"
                $temp | Add-Member -MemberType NoteProperty -Name "Cert type" -Value "$($result[$i].cert_type)"
                $temp | Add-Member -MemberType NoteProperty -Name "Issuer" -Value "$($result[$i].issuer)"
                $temp | Add-Member -MemberType NoteProperty -Name "Chain list" -Value "$($result[$i].chain_list)"
                $temp | Add-Member -MemberType NoteProperty -Name "Country" -Value "$($result[$i].country)"
                $temp | Add-Member -MemberType NoteProperty -Name "State" -Value "$($result[$i].state)"
                $temp | Add-Member -MemberType NoteProperty -Name "City" -Value "$($result[$i].city)"
                $temp | Add-Member -MemberType NoteProperty -Name "Organization" -Value "$($result[$i].organization)"
                $temp | Add-Member -MemberType NoteProperty -Name "Organizational unit" -Value "$($result[$i].organization_unit)"
                $temp | Add-Member -MemberType NoteProperty -Name "Common" -Value "$($result[$i].Common)"
                $temp | Add-Member -MemberType NoteProperty -Name "San" -Value "$($result[$i].San)"
                $temp | Add-Member -MemberType NoteProperty -Name "Email" -Value "$($result[$i].email)"
                $temp | Add-Member -MemberType NoteProperty -Name "DN" -Value "$($result[$i].DN)"
                $temp | Add-Member -MemberType NoteProperty -Name "Digest_algorithm" -Value "$($result[$i].digest_algorithm)"
                $temp | Add-Member -MemberType NoteProperty -Name "Lifetime" -Value "$($result[$i].lifetime)"
                $temp | Add-Member -MemberType NoteProperty -Name "From" -Value "$($result[$i].from)"
                $temp | Add-Member -MemberType NoteProperty -Name "Until" -Value "$($result[$i].until)"
                $temp | Add-Member -MemberType NoteProperty -Name "Serial" -Value "$($result[$i].serial)"
                $temp | Add-Member -MemberType NoteProperty -Name "Chain" -Value "$($result[$i].chain)"
                $temp | Add-Member -MemberType NoteProperty -Name "Fingerprint" -Value "$($result[$i].fingerprint)"
                $temp | Add-Member -MemberType NoteProperty -Name "Key lenght" -Value "$($result[$i].key_length)"
                $temp | Add-Member -MemberType NoteProperty -Name "Key Type" -Value "$($result[$i].key_type)"
                $temp | Add-Member -MemberType NoteProperty -Name "Parsed" -Value "$($result[$i].parsed)"
                $temp | Add-Member -MemberType NoteProperty -Name "Internal" -Value "$($result[$i].internal)"
                $temp | Add-Member -MemberType NoteProperty -Name "CA Type Existing" -Value "$($result[$i].CA_type_existing)"
                $temp | Add-Member -MemberType NoteProperty -Name "CA type Internal" -Value "$($result[$i].CA_type_internal)"
                $temp | Add-Member -MemberType NoteProperty -Name "CA type Intermediate" -Value "$($result[$i].CA_type_intermediate)"
                $temp | Add-Member -MemberType NoteProperty -Name "Cert type existing" -Value "$($result[$i].cert_type_existing)"
                $temp | Add-Member -MemberType NoteProperty -Name "Cert type Internal" -Value "$($result[$i].cert_type_internal)"
                $temp | Add-Member -MemberType NoteProperty -Name "CA type CSR" -Value "$($result[$i].cert_type_CSR)"
                $Certificate.Add($temp) | Out-Null
            }
        }
    }
    End
    {
        return $Certificate

    }
}
