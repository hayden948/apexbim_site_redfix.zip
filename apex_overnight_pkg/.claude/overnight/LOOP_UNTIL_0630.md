# Unattended run until 06:30 — relay tag path F1–F9, then whole-surface hardening

**Ruling (Hayden, 2026-10-11 23:18):** Run continuously and unattended until **06:30 local** with no input from Hayden. No loop cap and no early stop. When a situation would normally escalate, apply the **default ruling** below, log it, and keep working. Check your work after every action. Each loop audits the one before it.

## Never (these are safety rails, not stops)
- `--no-verify`, force-push, history rewrite, `git reset --hard` on main, deleting branches.
- Power or system settings, committing the INBOX, Grok or other paid network calls (stub the network in all tests).
- Shipping unverified code: a commit lands only after the per-action check plus a green full suite.
- **Safety floor:** the E2 superset pin (0 of 1541 old refusals sent) runs after every commit. If it fails → `git revert` that commit at once, log it, and continue.

## Default rulings (use these instead of asking)
- **Design choice with two options:** pick the **fail-closed / stricter** one. Log it as `DEFAULT RULING: <choice> — <why>` in `docs/review_team/MORNING_REVIEW.md`.
- **Same finding reopens twice:** stop patching that case. Refuse the whole input class (fail closed), pin it, log it as `DEFAULT RULING`, and move on.
- **A loop finds ≥ as many findings as the last loop:** switch strategy for the next loop. Pick the single largest finding class and build one structural fix (a validator or choke point) instead of point patches.
- **Fix breaks unrelated tests and can't be resolved in 15 min:** revert, record it as open with a repro, and move to the next item.
- **Ambiguous ownership or a peer's file outside the team paths:** don't touch it. Record it.
- **Tool or permission failure:** retry once. Then record it and route around it to the next item.

## Crash/compaction resilience
Write `docs/review_team/RUN_STATE.md`, and **commit it, trailered**, after every loop and every 30 min. Contents: current loop, `BASE_Ln`, HEAD, open-finding list, the last completed step, and the next step. On any restart or context loss: read `RUN_STATE.md` first and resume from the next step. Never redo committed work.

## Per-action self-check (after EVERY action)
1. **Edit:** `git diff` the file. Confirm only the intended lines changed and no def/class/const disappeared. If anything else changed, restore it.
2. **Code change:** `py_compile`, then the affected test file. Red → fix before the next action.
3. **Commit:** confirm the trailer is present, the lock is held, the full suite is green, and the E2 superset pin is green.
4. **Claim:** a "fixed", "passed" or "done" claim needs the command and its output from this session. No output, no claim.

## Loop (repeat until 06:30)
**L0 — Start.** Take the lock, set `APEX_SESSION_ID`, record `BASE_Ln`. Confirm no worker or daemon is running and the V3 baseline is clean. Load the open list from `RUN_STATE.md`.

**L1 — Audit the previous loop.** Every pin the previous loop added must:
- pass at HEAD;
- fail at `BASE_L(n-1)` at its own assertion, with 0 wrong-reason failures;
- drive the **real CLI entry**, with no flags that bypass derivation.

Hollow pins go onto the fix list. Every "fixed" claim in the last handoff must have a matching pin.

**L2 — Fix, in priority order:**
1. **F1:** canonicalize the packet file name, then derive domain/prefix from the `Canonical`, then scan raw + canonical before any network call. Explicit `--domain` and `--prefix` take the same path.
2. **`preflight()`:** validates every arg, path, URL, timeout and inbox parent before any network call. Pin: any preflight failure means 0 network calls and no traceback. This closes F2/F3/F7/F8 as a class.
3. **F4–F6, F9:** never log or echo untrusted text. Log a fixed category plus a sha.
4. **Sweep** for values derived from raw input before canonicalization.
5. Fix anything the verifier found last loop.

Every fix gets a real-CLI pin that fails first at `BASE_Ln`.

**L3 — Re-evaluate every 30 min by the clock.** Append 5 lines to `RUN_STATE.md`: elapsed time, closed/open counts, convergence check, strategy, next step.

**L4 — Verify three times.**
- **V1:** full suite plus the E2 pin.
- **V2:** fresh blind verifier, given only `BASE_Ln..HEAD` and this charge:
  > "Drive the real CLI. Find any input (file name, arg, env, network response) that reaches the network, inbox, or log in a form the gate would refuse raw or canonical; any traceback or error after a paid call; any untrusted text logged verbatim; any pin that doesn't drive the real entry path; any regression vs BASE_Ln."

  Bounce every finding with failing-first pins. Run up to 3 passes per loop; leftovers carry into the next loop.
- **V3:** gate script plus independent PowerShell confirmation, after the lock is released.

**L5 — Close the loop.** Write a handoff line, update and commit `RUN_STATE.md`, release the lock, run V3. Then start the next loop immediately.

## Scope escalation (when F1–F9 are clean)
Once a V2 comes back clean on HEAD with an empty open list, widen the charge to the **whole review-team surface** (`grok_team.py`, `canon.py`, gate, guard, hooks, relay), with fresh blind passes. Keep looping until 06:30, or until **two consecutive** whole-surface V2 passes are clean. In that case, finish early and idle.

## Final close (start by 06:15, done by 06:30)
- If a loop is mid-flight at 06:15: revert any uncommitted work. Committed work stays.
- Write **one** INBOX line: headline, final HEAD, open count, default-ruling count.
- `HANDOFF_2026-10-12.md` contains a per-loop table (loop, BASE, HEAD, findings in/closed/open, hollow pins, passes, active min). It also lists every `DEFAULT RULING` and every revert.
- Final V3 plus PowerShell confirmation with the lock released. Report sleep events (42/506/507/1) and active vs wall time.
- Headline: `DONE` (two clean whole-surface passes) / `CLEAN_F1-F9` / `PARTIAL` (open list attached).
