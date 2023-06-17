function Get-StringHash {
    param(
        [string]$StringToHash,
        [ValidateSet("MD5", "SHA1", "SHA256", "SHA512")]
        [string]$HashType = 'SHA1',
        [switch]$ReturnBytes
    )
    $hash = ""
    switch ($HashType) {
        "SHA1" { 
            $provider = New-Object system.security.cryptography.sha1cryptoserviceprovider
        }
        "SHA256" { 
            $provider = New-Object system.security.cryptography.sha256cryptoserviceprovider
        }
        "SHA512" { 
            $provider = New-Object system.security.cryptography.sha512cryptoserviceprovider
        }
        Default {
            $provider = New-Object system.security.cryptography.md5cryptoserviceprovider
            
        }
    }
    $hashbytes = $provider.ComputeHash([char[]]$StringToHash)
    if ($returnBytes) {
        $hashbytes
    }
    else {
        $hash = ''
        $hashbytes|ForEach-Object { $hash += $_.tostring("X2")}
        $hash
    }
    
    
}
Function Get-DesKey {
    param(
        $Password = '',
        [ValidateSet("TripleDES", "DES")]
        $KeyType = "TripleDES"
        
    )
    if ($KeyType -eq 'DES') {
        $cypher = New-Object System.Security.Cryptography.DESCryptoServiceProvider
    }
    else {
        $cypher = New-Object System.Security.Cryptography.TripleDESCryptoServiceProvider
    }    
    #if a password was specified use it to crete key
    if ($Password -ne '') {
        $kb=Get-StringHash $Password -ReturnBytes -HashType 'SHA256'
        "$([System.Convert]::ToBase64String($kb[0..23])):$([System.Convert]::ToBase64String($kb[24..31]))"
    }
    else {

    
        $cypher.GenerateKey();
        $cypher.GenerateIV();
        "$([System.Convert]::ToBase64String($cypher.Key)):$([System.Convert]::ToBase64String($cypher.IV))"
    }
    
}

Function ConvertTo-Hex([byte[]]$ByteArray) {
    $output = New-Object System.Text.StringBuilder
    foreach ($b in $byteArray) {
        $output.append($b.ToString("X2"))
    }
    $output.Tostring()
}


Function Encrypt-String([string]$PlainText, [string]$key) {
    [Reflection.Assembly]::LoadWithPartialName("System.Security")  | Out-Null
    if ($key.length -notin 25, 45) {
        throw "Invalid Key"
        return
    }
    $k = $key -split ":"
    if ($k.Length -ne 2) {
        throw "Invalid Key"
        return
    }
    $DesKey = [System.Convert]::FromBase64String($k[0])
    $IV = [System.Convert]::FromBase64String($k[1])
    if ($key.Length -eq 45) {
        $DES = New-Object System.Security.Cryptography.TripleDESCryptoServiceProvider    
    }
    else {
        $DES = New-Object System.Security.Cryptography.DESCryptoServiceProvider    
    }
    $ms = New-Object System.IO.MemoryStream
    $cs = New-Object System.Security.Cryptography.CryptoStream($ms, $DES.CreateEncryptor($DesKey, $IV), [System.Security.Cryptography.CryptoStreamMode]::Write)
    $sw = New-Object System.IO.StreamWriter($cs)
    $sw.Write($PlainText)
    $sw.Flush()
    $cs.FlushFinalBlock()
    $sw.Flush()
    [System.Convert]::ToBase64String($ms.GetBuffer(), 0, [int]$ms.Length)
   
}
Function Decrypt-String([string]$CypherText, [string]$Key) {
    [Reflection.Assembly]::LoadWithPartialName("System.Security")| Out-Null
    if ($key.length -notin 25, 45) {
        throw "Invalid Key"
        return
    }
    $k = $key -split ":"
    if ($k.Length -ne 2) {
        throw "Invalid Key"
        return
    }
    if ([string]::IsNullOrEmpty($CypherText)) {
        throw "Nothing to decrypt"
        return
    }
    $DesKey = [System.Convert]::FromBase64String($k[0])
    $IV = [System.Convert]::FromBase64String($k[1])
    if ($key.Length -eq 45) {
        $DES = New-Object System.Security.Cryptography.TripleDESCryptoServiceProvider    
    }
    else {
        $DES = New-Object System.Security.Cryptography.DESCryptoServiceProvider    
    }
    $CypherBytes = [System.Convert]::FromBase64String($CypherText)
    $Decryptor = $DES.CreateDecryptor($DesKey, $IV)
    $plainBytes = $Decryptor.TransformFinalBlock($CypherBytes, 0, $CypherBytes.Length)
    $enc = [System.Text.Encoding]::ASCII
    return $enc.GetString($plainBytes)
}
function Get-CaesarCypher {
    param ([string]$PlainText = "", [string]$CypherText = "", [int]$Key = 0)
    $alpha = "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"
    $code = "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"
    $alphaPos = 0
    $codePos = $key
    for ($i = 0; $i -le 25; $i++) {
        $code[$codePos] = $alpha[$alphaPos]
        $codePos++
        $alphaPos++
        if ($codePos -ge 26) {$codePos = 0}
    }
    $output = ""
    if ($PlainText -ne "") {
        #encode
        $PlainText = $PlainText.ToUpper()
        $chars = $PlainText -split ""
        foreach ($c in $chars) {
            $pos = $alpha.IndexOf($c)
            if ($pos -ge 0) {
                $output += $code[$pos]
            }
            else {
                $output += $c
            }
        }
 
    }
    else {
        #decode
        $CyperText = $CypherText.ToUpper()
        $chars = $CypherText -split ""
        foreach ($c in $chars) {
            $pos = $code.IndexOf($c)
            if ($pos -ge 0) {
                $output += $alpha[$pos]
            }
            else {
                $output += $c
            }
        }

    }
    return $output
}

function Get-MD5([string]$inputstring) {
    Get-StringHash -StringToHash $inputstring -HashType MD5
}