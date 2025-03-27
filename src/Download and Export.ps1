

function Export-Windows {
    param (
        [Parameter(Mandatory=$true)]
        [string]$Url,
        
        [Parameter(Mandatory=$true)]
        [string]$SourcePath,

        [Parameter(Mandatory=$true)]
        [string]$DestinationPath
        
    )
    
    try {
        $FileName = Split-Path $Url -Leaf

        $Extension = [System.IO.Path]::GetExtension($FileName)

        # Check if zip file exists
        if (-not (Test-Path $FileName)) {
            Invoke-WebRequest $Url -OutFile $FileName
        }
        
        $ZipFolder = "CUSTOMTEMP"

        New-Item -ItemType Directory -Path $ZipFolder -Force

        Expand-Archive -Path $FileName -DestinationPath $ZipFolder -Force
        

        $SubFolder = Split-Path -Path $DestinationPath -Parent
        New-Item -ItemType Directory -Path $SubFolder -Force

        Copy-Item "$($ZipFolder)\$($SourcePath)" $DestinationPath -Force

        Remove-Item $ZipFolder -Recurse
        Remove-Item $FileName

    }
    catch {
        Write-Error "Error extracting zip: $_"
    }
}


function Export-Linux {
    param (
        [Parameter(Mandatory=$true)]
        [string]$Url,
        
        [Parameter(Mandatory=$true)]
        [string]$SourcePath,

        [Parameter(Mandatory=$true)]
        [string]$DestinationPath
        
    )
    

        $FileName = Split-Path $Url -Leaf

        $Extension = [System.IO.Path]::GetExtension($FileName)

        # Check if zip file exists
        if (-not (Test-Path $FileName)) {
            Invoke-WebRequest $Url -OutFile $FileName
        }
        
        $ZipFolder = "CUSTOMTEMP"

        New-Item -ItemType Directory -Path $ZipFolder -Force

        tar -xzf $FileName -C $ZipFolder

        
        $SubFolder2 = Get-ChildItem -Path $ZipFolder -Directory -Filter "Firebird*"


        $BuildRootTar = "$($SubFolder2.FullName)\buildroot.tar.gz"
        $BuildRoot = "$($SubFolder2.FullName)\buildroot\"

        New-Item -ItemType Directory -Path $BuildRoot -Force

        $BuildRoot
        $BuildRootTar

        tar -xzf $BuildRootTar -C $BuildRoot
        
        $Search = "$($BuildRoot)$($SourcePath)"

        $SearchPath = Get-ChildItem $Search



        $SubFolder = Split-Path -Path $DestinationPath -Parent
        New-Item -ItemType Directory -Path $SubFolder -Force

        Copy-Item $SearchPath $DestinationPath -Force
        

        Remove-Item $ZipFolder -Recurse
        Remove-Item $FileName
    
}


$Firebird_3_Win_x86 = "https://github.com/FirebirdSQL/firebird/releases/download/v3.0.12/Firebird-3.0.12.33787-0-Win32.zip"
$Firebird_4_Win_x86 = "https://github.com/FirebirdSQL/firebird/releases/download/v4.0.5/Firebird-4.0.5.3140-0-Win32.zip"
$Firebird_5_Win_x86 = "https://github.com/FirebirdSQL/firebird/releases/download/v5.0.2/Firebird-5.0.2.1613-0-windows-x86.zip"

$Firebird_3_Win_x64 = "https://github.com/FirebirdSQL/firebird/releases/download/v3.0.12/Firebird-3.0.12.33787-0-x64.zip"
$Firebird_4_Win_x64 = "https://github.com/FirebirdSQL/firebird/releases/download/v4.0.5/Firebird-4.0.5.3140-0-x64.zip"
$Firebird_5_Win_x64 = "https://github.com/FirebirdSQL/firebird/releases/download/v5.0.2/Firebird-5.0.2.1613-0-windows-x64.zip"


Export-Windows $Firebird_3_Win_x86 "fbclient.dll" "Firebird.Data.Version3.win-x32\firebird\v3\win\x32\fbclient.dll"
Export-Windows $Firebird_4_Win_x86 "fbclient.dll" "Firebird.Data.Version4.win-x32\firebird\v4\win\x32\fbclient.dll"
Export-Windows $Firebird_5_Win_x86 "fbclient.dll" "Firebird.Data.Version5.win-x32\firebird\v5\win\x32\fbclient.dll"

Export-Windows $Firebird_3_Win_x64 "fbclient.dll" "Firebird.Data.Version3.win-x64\firebird\v3\win\x64\fbclient.dll"
Export-Windows $Firebird_4_Win_x64 "fbclient.dll" "Firebird.Data.Version4.win-x64\firebird\v4\win\x64\fbclient.dll"
Export-Windows $Firebird_5_Win_x64 "fbclient.dll" "Firebird.Data.Version5.win-x64\firebird\v5\win\x64\fbclient.dll"




$Firebird_3_Linux_x86 = "https://github.com/FirebirdSQL/firebird/releases/download/v3.0.12/Firebird-3.0.12.33787-0.i686.tar.gz"
$Firebird_4_Linux_x86 = "https://github.com/FirebirdSQL/firebird/releases/download/v4.0.5/Firebird-4.0.5.3140-0.i686.tar.gz" 
$Firebird_5_Linux_x86 = "https://github.com/FirebirdSQL/firebird/releases/download/v5.0.2/Firebird-5.0.2.1613-0-linux-x86.tar.gz" 

$Firebird_3_Linux_x64 = "https://github.com/FirebirdSQL/firebird/releases/download/v3.0.12/Firebird-3.0.12.33787-0.amd64.tar.gz" 
$Firebird_4_Linux_x64 = "https://github.com/FirebirdSQL/firebird/releases/download/v4.0.5/Firebird-4.0.5.3140-0.amd64.tar.gz" 
$Firebird_5_Linux_x64 = "https://github.com/FirebirdSQL/firebird/releases/download/v5.0.2/Firebird-5.0.2.1613-0-linux-x64.tar.gz" 


Export-Linux $Firebird_3_Linux_x86 "opt\firebird\lib\libfbclient.so.3*" "Firebird.Data.Version3.linux-x32\firebird\v3\linux\x32\fbclient.so"
Export-Linux $Firebird_4_Linux_x86 "opt\firebird\lib\libfbclient.so.4*" "Firebird.Data.Version4.linux-x32\firebird\v4\linux\x32\fbclient.so"
Export-Linux $Firebird_5_Linux_x86 "opt\firebird\lib\libfbclient.so.5*" "Firebird.Data.Version5.linux-x32\firebird\v5\linux\x32\fbclient.so"

Export-Linux $Firebird_3_Linux_x64 "opt\firebird\lib\libfbclient.so.3*" "Firebird.Data.Version3.linux-x64\firebird\v3\linux\x64\fbclient.so"
Export-Linux $Firebird_4_Linux_x64 "opt\firebird\lib\libfbclient.so.4*" "Firebird.Data.Version4.linux-x64\firebird\v4\linux\x64\fbclient.so"
Export-Linux $Firebird_5_Linux_x64 "opt\firebird\lib\libfbclient.so.5*" "Firebird.Data.Version5.linux-x64\firebird\v5\linux\x64\fbclient.so"




$Firebird_3_Android_Arm32 = "https://github.com/FirebirdSQL/firebird/releases/download/v3.0.12/Firebird-3.0.12.33787-0.arm.tar.gz" 
$Firebird_3_Android_Arm64 = "https://github.com/FirebirdSQL/firebird/releases/download/v3.0.12/Firebird-3.0.12.33787-0.arm64.tar.gz" 
$Firebird_4_Android_Arm32 = "https://github.com/FirebirdSQL/firebird/releases/download/v4.0.5/Firebird-4.0.5.3140-0.arm.tar.gz" 
$Firebird_4_Android_Arm64 = "https://github.com/FirebirdSQL/firebird/releases/download/v4.0.5/Firebird-4.0.5.3140-0.arm64.tar.gz" 
$Firebird_5_Android_Arm32 = "https://github.com/FirebirdSQL/firebird/releases/download/v5.0.2/Firebird-5.0.2.1613-0-android-arm32.tar.gz" 
$Firebird_5_Android_Arm64 = "https://github.com/FirebirdSQL/firebird/releases/download/v5.0.2/Firebird-5.0.2.1613-0-android-arm64.tar.gz" 

#Export-Linux $Firebird_3_Android_Arm32 "libfbclient.so" "firebird\v3\linux\x32\fbclient.so"
#Export-Linux $Firebird_3_Android_Arm64 "libfbclient.so" "firebird\v3\linux\x64\fbclient.so"
#Export-Linux $Firebird_4_Android_Arm32 "opt\firebird\lib\libfbclient.so.4*" "firebird\v4\linux\x32\fbclient.so"
#Export-Linux $Firebird_4_Android_Arm64 "opt\firebird\lib\libfbclient.so.4*" "firebird\v4\linux\x64\fbclient.so"
#Export-Linux $Firebird_5_Android_Arm32 "opt\firebird\lib\libfbclient.so.5*" "firebird\v5\linux\x32\fbclient.so"
#Export-Linux $Firebird_5_Android_Arm64 "opt\firebird\lib\libfbclient.so.5*" "firebird\v5\linux\x64\fbclient.so"
