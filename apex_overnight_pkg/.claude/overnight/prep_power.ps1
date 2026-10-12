# Run ONCE in an ADMIN PowerShell before the overnight loop.
# Stops sleep/hibernate on AC and keeps the machine awake with the lid closed.
powercfg /change standby-timeout-ac 0
powercfg /change hibernate-timeout-ac 0
powercfg /setacvalueindex SCHEME_CURRENT SUB_BUTTONS LIDACTION 0
powercfg /setactive SCHEME_CURRENT
Write-Host "Power set: no sleep/hibernate on AC, lid close = do nothing. Keep it plugged in."
