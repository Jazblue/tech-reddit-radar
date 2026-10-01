Reddit Tech Radar
Purpose

Run the daily Reddit Tech Radar for this repository.

The goal is to identify genuinely useful, current technology discussions and developments, then verify them against authoritative sources before publishing the report.

This is a technology intelligence workflow, not a Reddit scraper.

Working Directory

Always work from:

C:\Users\Administrator\tech-reddit-radar

The repository is the source of truth for this skill.

MANDATORY EXECUTION CONTRACT

This skill is an executable repository workflow, not a report-writing task.

The final report shown in the Hermes response is NOT the deliverable.

The deliverable is the physically updated Git repository.

After research and the quality gate, you MUST continue executing the repository workflow using the available shell/filesystem/Git tools.

You MUST NOT finish the run immediately after displaying the research report.

The execution sequence is mandatory:

1. Build the candidate report.
2. Run the quality gate.
3. If the quality gate fails:
   - DO NOT modify latest.json.
   - DO NOT create a new archive.
   - DO NOT commit or push.
   - Report the failure and stop.
4. If the quality gate passes:
   - Physically write data/reddit-tech-radar/latest.json.
   - Physically create data/reddit-tech-radar/archive/YYYY-MM-DD.json.
   - Validate both JSON files.
   - Physically update index.html if the repository workflow requires it.
   - Run git status.
   - Run git diff and inspect the changes.
   - Check that no secrets were introduced.
   - git add the intended files.
   - git commit using the required commit message.
   - git push.
   - Verify that the push succeeded.
   - Verify the repository working tree/state after publication.

A report is NOT considered successfully published unless the corresponding filesystem operations and Git operations actually succeed.

NEVER claim that a file was saved, updated, archived, committed, or pushed unless the corresponding command/tool operation actually succeeded.

NEVER describe a simulated, hypothetical, or intended file operation as a completed operation.

NEVER write phrases such as:
"simulated path"
"would save"
"would use"
"actual save would"
"publication would"
when reporting a completed run.

If a required filesystem, shell, or Git capability is unavailable, report:
"Publication failed: required repository operation was unavailable."

Do not pretend the operation succeeded.

The final response must distinguish clearly between:

RESEARCH COMPLETE
and
PUBLICATION COMPLETE

Only report "PUBLICATION COMPLETE" after the repository and Git verification steps have actually succeeded.

Before claiming successful completion, the final response MUST contain evidence from the actual execution that:
- latest.json was written
- the dated archive was written
- the intended Git changes were committed
- git push succeeded

If any of these cannot be verified, the run is NOT a successful publication.

VERIFICATION EVIDENCE RULE

A finding may only be marked VERIFIED when the primary or authoritative source was actually accessed and checked during this run.

A URL merely appearing in a search result, snippet, community post, or another article does NOT count as primary-source verification.

If the underlying event is confirmed but the specific Reddit/X claim is not fully confirmed, use PARTIALLY VERIFIED.

Do not invent verification evidence.

Topics

Research across:

AI / LLMs
Cybersecurity
AWS / Cloud
DevOps / Infrastructure
Developer Tools
Cloud / IT Careers
Emerging Technology

Do not force every topic into the final report.

Follow the strongest current signals.

Critical Restrictions
Do NOT use agent-reach.
Do NOT install agent-reach.
Do NOT require the user to log into Reddit.
Do NOT require interactive authentication during scheduled execution.
Do NOT ask the user questions during unattended execution.
Do NOT invent findings, dates, statistics, sources, or verification.
Reddit and X/Twitter posts are discovery signals, not automatically proof.
Do not treat old Reddit or X posts as current without checking their actual publication date.
Do not publish weak research simply to reach a target item count.
Do not claim a source was checked unless it was actually checked.
Research Budget

Maximum: 12 searches per run.

Use the budget intelligently.

Discovery

Normally allocate up to:

5–6 Reddit searches
2–3 X/Twitter searches
Verification

Reserve approximately:

3–4 searches for verification

The exact allocation can change depending on the strength of the initial findings.

Never exceed 12 total searches.

Stop searching early when sufficient high-quality evidence has been collected.

The target is normally 8–12 useful final findings.

It is better to publish fewer strong findings than pad the report with weak, repetitive, old, or unverified material.

Phase 1 — Reddit Discovery

Reddit is the primary community discovery source.

Look for:

recent discussions
technical problems
incidents
emerging technologies
tools people are adopting
new projects
security concerns
AI/LLM developments
AWS/cloud developments
DevOps trends
career/skills discussions

Prioritise recent material.

For each candidate record:

title/topic
category
Reddit source
actual publication date where available
what people are discussing
why it may matter
possible verification source

Do not assume a search-result snippet proves the claim.

Do not use old evergreen Reddit posts as evidence of today's activity.

Phase 2 — X / Twitter Discovery

Use X/Twitter as a secondary real-time discovery source when available.

Look for:

breaking technology developments
AI/LLM developments
cybersecurity incidents
AWS/cloud announcements and discussion
open-source releases
developer tools
technical project launches
engineers discussing emerging issues
security researchers reporting new activity
maintainers discussing releases or changes

Prefer signals from:

project maintainers
engineers
security researchers
company/vendor accounts
recognised technical practitioners
official project accounts

An individual X post is not proof of a claim.

Use X primarily to discover signals that can then be verified through authoritative sources.

If X access is unavailable, do not fail the run.

Continue using Reddit and web research.

Record X sources separately where appropriate.

Phase 3 — Candidate Selection

After Reddit and X discovery:

Remove duplicates.
Remove obviously old material.
Remove low-value discussions.
Remove unsupported sensational claims.
Prioritise developments with practical technology relevance.
Select the strongest candidates for verification.

Do not spend the entire research budget collecting candidates.

The goal is to leave enough searches for verification.

Phase 4 — Verification

Verification is mandatory for significant findings.

Use remaining search budget to check candidates against:

official vendor announcements
official documentation
GitHub repositories and releases
security advisories
CISA or equivalent government/security sources
AWS official sources
Microsoft official sources
OpenAI official sources
Google official sources
other relevant primary sources
reputable technical journalism

For every significant finding determine whether it is:

VERIFIED

Supported by a primary or authoritative source.

PARTIALLY VERIFIED

The underlying event, tool, vulnerability, release, or development is confirmed, but the specific Reddit/X claim or scale is not fully confirmed.

COMMUNITY REPORTED

An interesting community signal where no authoritative confirmation was found.

Community-reported material must never be presented as established fact.

If a candidate cannot be verified, either:

clearly label it as a community signal, or
exclude it.
Date Validation

Current/recent claims must have their dates checked.

Never describe a Reddit or X post as:

"today"
"within 24 hours"
"recent"
"this week"

unless its actual publication date supports that description.

Old posts may still be useful as background information, but they must not be presented as today's trend.

Source Quality

Prioritise sources in this order:

Official / primary source
Official GitHub/project source
Government/security authority
Reputable technical publication
Reddit/X community evidence

A community source can identify something worth investigating.

It should not automatically establish that something is true.

Quality Gate

Before writing latest.json, calculate:

primarySourcesChecked
secondarySourcesChecked
communitySourcesChecked
verifiedFindings
partiallyVerifiedFindings
unverifiedFindings

A successful publication should normally contain:

at least 5 adequately verified or partially verified findings
preferably 8–12 useful findings
clear distinction between verified information and community signals
current/relevant evidence
no fabricated dates
no fabricated statistics
valid source links

If fewer than 5 adequately verified or partially verified findings exist:

DO NOT overwrite a valid existing latest.json.

Preserve the previous published report.

Explain why the quality gate failed.

Progress Reporting

During execution provide concise progress updates.

Use this style:

[Reddit Tech Radar]
→ Starting discovery
→ Searching Reddit
→ Searching X / Twitter
→ Reviewing candidate signals
→ Removing duplicates and old material
→ Starting verification
→ Verifying current findings
→ Building report
→ Running quality gate
→ Publishing report
→ Updating archive
→ Git commit/push
✓ Complete

More detailed progress is acceptable when useful, for example:

→ Reddit discovery: 6 candidates
→ X discovery: 3 candidates
→ Verification: 5 confirmed

Do not falsely report a stage as complete.

If a search fails:

⚠ Search failed: <reason>
→ Continuing with remaining research budget

Do not stop the entire run merely because an optional source is unavailable.

Report Output

Write:

data/reddit-tech-radar/latest.json

Archive successful reports as:

data/reddit-tech-radar/archive/YYYY-MM-DD.json

The JSON must remain compatible with the existing website.

Retain the existing structure where possible.

Include:

publicationDate
generatedTimestamp
researchVersion
summary
biggestDiscussions
aiWatch
cybersecurityWatch
awsCloudWatch
toolsPeopleAreTalkingAbout
cloudItCareerSignals
worthWatching
awsLearningOpportunity
verificationInformation
researchQuality
lastUpdated
researchDate
Biggest Discussions

Each major discussion should include:

title
category
shortSummary
whyItMatters
redditSignal
verificationStatus
confidence
sourceLinks
redditLinks

Where X contributed significantly, also include an appropriate X/Twitter source field without breaking the existing website schema.

Use actual source URLs.

Do not fabricate URLs.

Verification Information

The verificationInformation section should document important verification work.

Where applicable include:

claim
verification status
primary source
secondary source
explanation
limitations

This allows the website/report to distinguish community chatter from confirmed information.

Research Quality

The researchQuality object should accurately report:

number of primary sources checked
number of secondary sources checked
number of Reddit/community sources checked
number of X/Twitter sources checked where supported
verified findings
partially verified findings
unverified findings
important limitations

Never inflate these numbers.

EXECUTION METHOD  NO GENERATED AUTOMATION

The agent MUST execute this workflow directly. Do NOT create Python, PowerShell, Bash, batch, JavaScript, or any other helper/automation scripts to perform research, publication, archiving, validation, Git operations, or verification.

Do NOT create files such as update_*.py, run_*.py, automation scripts, workflow records, backup copies, temporary files, or generated documentation unless SKILL.md explicitly requires that exact file.

If direct execution of any required operation is not possible, STOP and report PUBLICATION FAILED. Never work around an instruction by generating a script that performs the prohibited operation.

During publication, the ONLY repository data files permitted to be created or modified are:
- data/reddit-tech-radar/latest.json
- data/reddit-tech-radar/archive/YYYY-MM-DD.json

The agent MUST NOT invent or reconstruct an alternative publication workflow from memory, previous runs, existing scripts, or prior reports. SKILL.md is the sole authoritative workflow.

STRICT PUBLICATION CONTRACT

The repository itself is the source of truth. Do not create temporary automation programs, helper scripts, generated Python files, wrapper scripts, or other executable files in the repository in order to perform this workflow unless such a file already exists in the repository and SKILL.md explicitly requires it.

The final report in the Hermes response is NOT the deliverable. The deliverable is the physically updated repository.

After the quality gate passes, the publication sequence MUST be:

1. Generate the complete report in memory.
2. Validate the report JSON before touching the existing published file.
3. Confirm publicationDate equals today's UTC date.
4. Confirm generatedTimestamp is current for this run.
5. Confirm required sections and source URLs exist.
6. Confirm the quality gate passes.
7. Write data/reddit-tech-radar/latest.json.
8. Immediately create data/reddit-tech-radar/archive/YYYY-MM-DD.json as an exact copy of that newly written latest.json.
9. Validate both JSON files independently.
10. Compare SHA-256 hashes of latest.json and the dated archive. They MUST be identical.
11. Confirm both files contain today's publicationDate and the same generatedTimestamp.
12. Run git status --short.
13. Inspect git diff -- data/reddit-tech-radar/latest.json data/reddit-tech-radar/archive/YYYY-MM-DD.json.
14. Confirm ONLY the intended latest.json and dated archive are changed by this publication. Unexpected generated files, helper scripts, temporary files, or unrelated modifications MUST cause publication to fail.
15. Check the intended files for secrets or credentials.
16. Stage ONLY the intended latest.json and dated archive.
17. Verify the staged diff.
18. Commit using EXACTLY: Update Reddit Tech Radar - YYYY-MM-DD
19. Verify the commit succeeded and contains the intended files.
20. Push to the configured GitHub remote.
21. Verify the push succeeded.
22. Run git status --short again.
23. Verify HEAD and origin point to the same commit.
24. Only then report PUBLICATION COMPLETE.

ARCHIVE INTEGRITY RULE

The dated archive MUST represent the exact report published in latest.json for that run.

Do not copy an existing archive into the new date.
Do not preserve an old archive merely because it already exists.
Do not create the archive before latest.json has been successfully written.

If the archive cannot be written, validated, or matched to latest.json:

- publication has failed
- do not claim success
- report the failure
- do not continue to commit/push

GIT INTEGRITY RULE

A successful git commit or push does NOT by itself prove that the report workflow succeeded.

The exact commit message MUST be:

Update Reddit Tech Radar - YYYY-MM-DD

Replace YYYY-MM-DD with the actual publication date.

Before claiming publication complete, verify:

- the commit exists
- the commit contains the intended latest.json
- the commit contains the intended dated archive
- the push succeeded
- local HEAD matches origin
- no unexpected generated files were introduced

If any of these checks fail, report:

PUBLICATION FAILED

Do not describe the run as successfully published.

UNEXPECTED FILE RULE

If git status shows an unexpected file such as run_automation.py, *.tmp, *.bak, temporary research files, generated scripts, credentials, or unrelated working-tree changes, do not add it merely to make the working tree clean.

Do not delete an unexpected pre-existing user file automatically.

Instead, stop publication and report the unexpected file.

A backup file that existed before the run is not part of the publication and must never be staged.

PROGRESS ACCURACY RULE

Do not announce Publishing report, Updating archive, Git commit/push, or Complete until the corresponding physical operation has actually succeeded.

The final response MUST contain two separate states:

RESEARCH COMPLETE

and

PUBLICATION COMPLETE

Only use PUBLICATION COMPLETE when all filesystem, archive, validation, Git, push, and post-push verification checks above have succeeded.

If research succeeds but publication fails, report:

RESEARCH COMPLETE
PUBLICATION FAILED

and include the exact failed stage and evidence.

Publishing Safety

Never destroy a valid published report because today's research failed.

Before publishing:

Validate the JSON.
Run the quality gate.
Confirm the report date.
Confirm source links.
Confirm verification information.
Confirm the report is not mostly old material.
Only then replace latest.json.
Create the dated archive.
Review the Git diff.

If validation or quality checks fail:

Preserve the existing published latest.json.

Do not publish a bad report merely because the scheduled run occurred.

Git Workflow

After a successful report:

Check git status.
Review the changed JSON.
Validate that no secrets were added.
Add the report/archive changes.
Commit with:

Update Reddit Tech Radar - YYYY-MM-DD

Push to the configured GitHub remote.

Never force push.

If GitHub push fails, do not claim publication succeeded.

Report the failure clearly.

Scheduled Execution

The skill must work unattended from Hermes cron.

It must never depend on:

interactive Reddit login
agent-reach
manual approval
user prompts
secrets stored in the repository

If Reddit or X/Twitter access is unavailable, continue using the other available discovery and verification sources.

The scheduled workflow must remain within the 12-search maximum.

Failure Behaviour

If research fails:

do not fabricate results
do not overwrite valid latest.json
preserve the previous report
explain the failure
leave enough information for the next run to recover

If verification is insufficient:

[Reddit Tech Radar]
⚠ Research completed but quality gate failed
✓ Existing latest.json preserved
- Verified findings: X
- Partially verified findings: Y
- Community-only findings: Z
- Reason: insufficient current verification
Successful Completion

A successful run should finish with something similar to:

[Reddit Tech Radar]
✓ Research complete
✓ 10 findings
✓ 6 verified
✓ 3 partially verified
✓ 1 community signal
✓ Quality gate passed
✓ latest.json updated
✓ Archive created
✓ GitHub push successful

If X/Twitter was unavailable:

ℹ X/Twitter unavailable — Reddit and web verification used instead

Do not treat optional source failure as total research failure.

Core Principle

The radar should answer:

"What technology developments are people talking about right now, and which of those signals can we actually substantiate?"

It should not simply answer:

"What Reddit posts did we find?"

Reddit and X discover the signal.

Authoritative sources establish the evidence.

The quality gate decides whether the evidence is good enough to publish.