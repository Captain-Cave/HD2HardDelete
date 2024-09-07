# Deleting folder %appdata%\Arrowhead
$folderToDelete = "$env:APPDATA\Arrowhead"
if (Test-Path $folderToDelete) {
    Remove-Item -Path $folderToDelete -Recurse -Force
    Write-Output "Folder $folderToDelete is deleted."
} else {
    Write-Output "Cannot find folder $folderToDelete."
}

# Deleting registerykeys
$registryPaths = @(
    "HKCU:\SOFTWARE\Microsoft\DirectInput\HELLDIVERS2.EXE66C4AF1400DA6230",
    "HKCU:\SOFTWARE\NVIDIA Corporation\Ansel\HELLDIVERS 2"
)

foreach ($path in $registryPaths) {
    if (Test-Path $path) {
        Remove-Item -Path $path -Recurse -Force
        Write-Output "Registerkey $path is deleted."
    } else {
        Write-Output "Cannot find registerkey $path."
    }
}

# Delete specific infos from registerkey
$bamRegistryPath = "HKLM:\SYSTEM\ControlSet001\Services\bam\State\UserSettings\S-1-5-21-4125124034-1850078268-1397146319-1001"
$bamValuesToDelete = @(
    "\Device\HarddiskVolume6\SteamLibrary\steamapps\common\Helldivers 2\bin\GameGuard.des",
    "\Device\HarddiskVolume6\SteamLibrary\steamapps\common\Helldivers 2\bin\helldivers2.exe",
    "\Device\HarddiskVolume6\SteamLibrary\steamapps\common\Helldivers 2\tools\gguninst.exe"
)

foreach ($value in $bamValuesToDelete) {
    $fullPath = "$bamRegistryPath\$value"
    if (Test-Path $fullPath) {
        Remove-ItemProperty -Path $bamRegistryPath -Name $value -Force
        Write-Output "Register info $value is deleted."
    } else {
        Write-Output "Didn't find info $value."
    }
}

# Deleting firewall rules
$firewallRules = Get-NetFirewallRule | Where-Object { $_.DisplayName -like "*Helldivers 2*" }
foreach ($rule in $firewallRules) {
    Remove-NetFirewallRule -Name $rule.Name
    Write-Output "Firewall rules $($rule.Name) is deleted."
}

Write-Output "Helldivers 2 is deleted and you can try install it back now."
Write-Output "I hope this help you but I don't promise anything."
