<#
ADUC Scripted Installation Tool v1.0
Compatible with Win 10 1803 and above only
#>

$regKeyOne = Get-ItemPropertyValue -Path HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate -Name 'DisableWindowsUpdateAccess' -ErrorAction SilentlyContinue
$regKeyTwo = Get-ItemPropertyValue -Path HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU -Name 'UseWUServer' -ErrorAction SilentlyContinue

if ($regKeyOne = 1) {
    Set-Itemproperty HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate -Name 'DisableWindowsUpdateAccess' -value "0" -ErrorAction SilentlyContinue
    Write-Host "Enabling Windows update access..."
    Get-Job | Wait-Job
}
else {
    Write-Host "Windows update already enabled..."
}

if ($regKeyTwo = 1) {
    Set-Itemproperty HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU -Name 'UseWUServer' -value "0" -ErrorAction SilentlyContinue
    Write-Host "Disabling WSUS restriction..."
    Get-Job | Wait-Job
}
else {
    Write-Host "WSUS already disabled..."
}

try {
    Restart-Service -Force -Name wuauserv -ErrorAction SilentlyContinue
    Get-Job | Wait-Job    
}
catch {
    Write-Host "Unable to restart Windows Update service, trying to continue..."
}
#TODO Collect registry key data before changes are made, and reset to orignal values at end of script run



$installStatus = Get-WindowsCapability -Name Rsat.ActiveDirectory.DS-LDS.Tools~~~~0.0.1.0 -Online | Select-Object -Property State
if ($installStatus = "Installed") {
    Write-Warning "ADUC already installed!"
}
else {
    Write-Host "ADUC not installed, proceding with installation..."

    try {
        Start-Process #Install Active Directory Users and Computers module
        Add-WindowsCapability –online –Name Rsat.ActiveDirectory.DS-LDS.Tools~~~~0.0.1.0 -wait
    } catch {
        Write-Host "Installation returned the following error $_"
    }
    
}

Read-Host -Prompt "Press Enter to exit"

