param(
    [string]$RepoRoot = (Split-Path -Parent $PSScriptRoot)
)

$ErrorActionPreference = "Stop"
Set-Location $RepoRoot

function Fail([string]$Stage, [string]$Evidence) {
    Write-Host ""
    Write-Host "PUBLICATION FAILED"
    Write-Host "Stage: $Stage"
    Write-Host "Evidence: $Evidence"
    exit 1
}

$latest = Join-Path $RepoRoot "data\reddit-tech-radar\latest.json"
$archiveDir = Join-Path $RepoRoot "data\reddit-tech-radar\archive"

if (!(Test-Path $latest)) {
    Fail "Locate latest.json" "File does not exist: $latest"
}

if (!(Test-Path $archiveDir)) {
    Fail "Locate archive directory" "Directory does not exist: $archiveDir"
}

# ------------------------------------------------------------
# 1. Validate latest.json
# ------------------------------------------------------------

try {
    $report = Get-Content $latest -Raw | ConvertFrom-Json
}
catch {
    Fail "Validate JSON" $_.Exception.Message
}

$today = (Get-Date).ToUniversalTime().ToString("yyyy-MM-dd")
$archive = Join-Path $archiveDir "$today.json"

if (Test-Path $archive) {
    Fail "Archive safety" "Today's archive already exists: $archive"
}

if ($report.publicationDate -ne $today) {
    Fail "Validate publication date" "publicationDate=$($report.publicationDate), expected=$today"
}

if ([string]::IsNullOrWhiteSpace([string]$report.generatedTimestamp)) {
    Fail "Validate generated timestamp" "generatedTimestamp is missing"
}

$requiredSections = @(
    "summary",
    "biggestDiscussions",
    "aiWatch",
    "cybersecurityWatch",
    "awsCloudWatch",
    "toolsPeopleAreTalkingAbout",
    "cloudItCareerSignals",
    "worthWatching",
    "awsLearningOpportunity",
    "verificationInformation",
    "researchQuality"
)

foreach ($section in $requiredSections) {
    if ($null -eq $report.$section) {
        Fail "Validate report structure" "Missing required section: $section"
    }
}

# ------------------------------------------------------------
# 2. Defence-in-depth quality checks
# ------------------------------------------------------------

$q = $report.researchQuality

if ($null -eq $q) {
    Fail "Quality gate" "researchQuality section missing"
}

$verified = [int]$q.verifiedFindings
$unverified = [int]$q.unverifiedFindings

if (($verified + $unverified) -le 0) {
    Fail "Quality gate" "No verified or unverified findings recorded"
}

if ($verified -lt 1) {
    Fail "Quality gate" "No verified findings"
}

# ------------------------------------------------------------
# 3. Git working-tree safety check BEFORE publication
# ------------------------------------------------------------

$status = @(git status --porcelain)

$allowedExisting = @(
    " M data/reddit-tech-radar/latest.json",
    "?? data/reddit-tech-radar/archive/$today.json"
)

foreach ($line in $status) {
    if ($line -notin $allowedExisting) {
        Fail "Unexpected Git changes" "Unexpected working-tree entry: $line"
    }
}

# ------------------------------------------------------------
# 4. Create archive as EXACT copy of latest.json
# ------------------------------------------------------------

try {
    Copy-Item -LiteralPath $latest -Destination $archive -Force
}
catch {
    Fail "Create archive" $_.Exception.Message
}

# ------------------------------------------------------------
# 5. Validate both files independently
# ------------------------------------------------------------

foreach ($file in @($latest, $archive)) {
    try {
        $null = Get-Content $file -Raw | ConvertFrom-Json
    }
    catch {
        Fail "Validate published JSON" "$file : $($_.Exception.Message)"
    }
}

# ------------------------------------------------------------
# 6. Verify byte-for-byte identity
# ------------------------------------------------------------

$latestHash = (Get-FileHash $latest -Algorithm SHA256).Hash
$archiveHash = (Get-FileHash $archive -Algorithm SHA256).Hash

if ($latestHash -ne $archiveHash) {
    Fail "Archive integrity" "latest SHA256=$latestHash ; archive SHA256=$archiveHash"
}

Write-Host "Archive integrity verified: SHA256=$latestHash"

# ------------------------------------------------------------
# 7. Check Git diff
# ------------------------------------------------------------

$statusAfterArchive = @(git status --porcelain)

foreach ($line in $statusAfterArchive) {
    if ($line -notin @(
        " M data/reddit-tech-radar/latest.json",
        "?? data/reddit-tech-radar/archive/$today.json"
    )) {
        Fail "Git diff safety" "Unexpected change after archive creation: $line"
    }
}

# ------------------------------------------------------------
# 8. Stage ONLY the two intended files
# ------------------------------------------------------------

git add -- data/reddit-tech-radar/latest.json "data/reddit-tech-radar/archive/$today.json"

if ($LASTEXITCODE -ne 0) {
    Fail "Git stage" "git add returned exit code $LASTEXITCODE"
}

$staged = @(git diff --cached --name-only)

$expected = @(
    "data/reddit-tech-radar/archive/$today.json",
    "data/reddit-tech-radar/latest.json"
)

if (($staged | Sort-Object) -join "`n" -ne ($expected | Sort-Object) -join "`n") {
    Fail "Staged-file verification" "Staged files were: $($staged -join ', ')"
}

# ------------------------------------------------------------
# 9. Commit
# ------------------------------------------------------------

$commitMessage = "Update Reddit Tech Radar - $today"

git diff --cached --check
if ($LASTEXITCODE -ne 0) {
    Fail "Staged diff validation" "git diff --cached --check failed"
}

git commit -m $commitMessage

if ($LASTEXITCODE -ne 0) {
    Fail "Git commit" "git commit returned exit code $LASTEXITCODE"
}

# ------------------------------------------------------------
# 10. Verify commit contents and exact message
# ------------------------------------------------------------

$head = (git rev-parse HEAD).Trim()
$actualMessage = (git log -1 --format=%s).Trim()

if ($actualMessage -ne $commitMessage) {
    Fail "Commit verification" "Commit message was '$actualMessage'"
}

$commitFiles = @(git diff-tree --no-commit-id --name-only -r HEAD)

if (($commitFiles | Sort-Object) -join "`n" -ne ($expected | Sort-Object) -join "`n") {
    Fail "Commit verification" "Commit contains: $($commitFiles -join ', ')"
}

# ------------------------------------------------------------
# 11. Push
# ------------------------------------------------------------

git push origin master

if ($LASTEXITCODE -ne 0) {
    Fail "Git push" "git push returned exit code $LASTEXITCODE"
}

# ------------------------------------------------------------
# 12. Verify remote and clean working tree
# ------------------------------------------------------------

git fetch origin master

if ($LASTEXITCODE -ne 0) {
    Fail "Remote verification" "git fetch returned exit code $LASTEXITCODE"
}

$localHead = (git rev-parse HEAD).Trim()
$remoteHead = (git rev-parse origin/master).Trim()

if ($localHead -ne $remoteHead) {
    Fail "Remote verification" "HEAD=$localHead ; origin/master=$remoteHead"
}

$finalStatus = @(git status --porcelain)

if ($finalStatus.Count -ne 0) {
    Fail "Final working-tree verification" "Working tree is not clean: $($finalStatus -join ' | ')"
}

Write-Host ""
Write-Host "PUBLICATION COMPLETE"
Write-Host "Date: $today"
Write-Host "Commit: $head"
Write-Host "Archive: $archive"
Write-Host "SHA256: $latestHash"
Write-Host "HEAD == origin/master: YES"
Write-Host "Working tree: CLEAN"
