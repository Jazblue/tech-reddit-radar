# Hermes Gateway Watchdog
# Checks gateway cron ticker heartbeat and restarts if stalled.
# Runs every 5 minutes via cron job.

$ErrorActionPreference = "Continue"
$HermesExe = "C:\Users\Administrator\AppData\Local\hermes\bin\hermes.exe"
$LogPath = "C:\Users\Administrator\AppData\Local\hermes\logs\gateway-watchdog.log"
$MaxStallSeconds = 120  # Restart if no heartbeat for 2+ minutes

function Log($msg) {
    $ts = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    Add-Content -Path $LogPath -Value "$ts $msg"
}

# Check gateway status
$output = & $HermesExe -p default cron status 2>&1
$exitCode = $LASTEXITCODE

# Look for the heartbeat line
if ($output -match "no heartbeat for (\d+)s") {
    $stallSeconds = [int]$matches[1]
    Log "WARNING: Gateway ticker stalled for ${stallSeconds}s (threshold: ${MaxStallSeconds}s)"

    if ($stallSeconds -gt $MaxStallSeconds) {
        Log "ACTION: Stalled too long — restarting gateway"

        # Kill stale gateway
        $gwInfo = Get-Process | Where-Object { $_.ProcessName -like "*hermes*" -and $_.Id -ne $PID }
        if ($gwInfo) {
            foreach ($p in $gwInfo) {
                Log "Killing stale gateway PID $($p.Id)"
                Stop-Process -Id $p.Id -Force
                Start-Sleep -Seconds 3
            }
        }

        # Start fresh gateway
        Log "Starting fresh gateway..."
        Start-Process -FilePath $HermesExe -Argument "-p", "default", "gateway", "run" -RedirectStandardOutput "$LogPath.out" -RedirectStandardError "$LogPath.err" -NoNewWindow

        Start-Sleep -Seconds 5

        # Verify
        $verify = & $HermesExe -p default cron status 2>&1
        if ($verify -match "cron jobs will fire automatically") {
            Log "SUCCESS: Gateway restarted and healthy"
        } else {
            Log "ERROR: Gateway restart verification failed"
        }
    } else {
        Log "INFO: Stall within threshold, no action taken"
    }
} elseif ($output -match "cron jobs will fire automatically") {
    Log "OK: Gateway healthy"
} else {
    Log "WARNING: Could not parse gateway status output"
    Log "Raw output: $output"
}