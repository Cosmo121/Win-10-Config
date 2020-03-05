Get-WindowsEdition -Online

$sls = Get-WmiObject -Query 'SELECT * FROM SoftwareLicensingService' 
@($sls).foreach({
    $_.InstallProductKey('xxxxx-xxxxx-xxxxx-xxxxx-xxxxx')
    $_.RefreshLicenseStatus()
})
