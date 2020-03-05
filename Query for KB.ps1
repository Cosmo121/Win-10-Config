$updatesinstalled = Get-HotFix 'KB3191566' -ErrorAction SilentlyContinue; if ($updatesinstalled) {
    Write-Host "Installed"
}
