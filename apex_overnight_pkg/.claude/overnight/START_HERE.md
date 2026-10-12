# Overnight run — setup (5 min)

Unzip into the repo root: `C:\Apex\Product & Engineering\revit-mcp-server\`
It creates/updates `.claude\settings.local.json` and `.claude\overnight\`.
If `settings.local.json` already existed, merge its allow/deny arrays instead of overwriting.

1. **Power** — admin PowerShell:
   `powershell -ExecutionPolicy Bypass -File .claude\overnight\prep_power.ps1`
   Plug in. Lid open.
2. **Subcommand names** — in `settings.local.json`, check the `grok_team.py` entries
   (`lock`, `status`, `worker ps`, `worker start`, `advance`) against
   `python scripts/grok_team.py --help`. Fix any that differ.
3. **Start Claude Code** in the repo:
   `claude --permission-mode acceptEdits`
   Run `/permissions` and confirm the rules loaded.
4. **Dry run** — ask it to run `git status`, `python -m pytest -q`, and a lock take/release.
   Any approval prompt = missing rule. Add it, retry.
5. **Launch** — paste:
   `Read .claude/overnight/LOOP_UNTIL_0630.md and execute it now. Start the clock with this message.`
6. **Morning** — read `docs/review_team/MORNING_REVIEW.md`, then `HANDOFF_2026-10-12.md`.
