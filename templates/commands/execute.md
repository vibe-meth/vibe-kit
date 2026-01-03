---
description: "Track task execution, update progress, log work, score confidence, and manage blockers"
scripts:
  sh: scripts/bash/create-new-task.sh --json --status
  ps: scripts/powershell/create-new-task.ps1 -Json -Status
---

## User Input

```text
$ARGUMENTS
```

You **MUST** consider the user input before proceeding (if not empty).

## Outline

1. **Load context**: Read `tasks.md` to get current task definitions and dependencies
2. **Parse status update**: Extract what was completed, blockers, decisions made
3. **Update tasks.md**: Mark completed tasks [X], update in-progress status, log blockers
4. **Score confidence**: Assess confidence on completed and in-progress work (1-10)
5. **Report status**: Show progress, blockers, and recommended next steps

## Execution Tracking

Update `tasks.md` with:

### Task Status Markers
- `[ ]` — Not started
- `[→]` — In progress
- `[X]` — Complete
- `[!]` — Blocked (with reason)

### Execution Log Format

```markdown
### [PHASE]-[#]: [Title]
- **Status**: Complete / In Progress / Blocked
- **Confidence**: [X/10] — [Why this score]
- **Completed**: [Date/time] in [duration]
- **Blockers**: [If any]
- **Notes**: [Key decisions, learnings, changes from plan]
```

### Context-Aware Confidence System

#### Multi-Task Confidence Tracking
```markdown
### Phase Confidence Summary
| Phase | Task Count | Average Confidence | Risk Level | Status |
|-------|------------|-------------------|------------|--------|
| [Phase] | [Number] | [Score/10] | [Low/Med/High] | [Green/Yellow/Red] |
```

#### Confidence Adjustment Rules
When completing tasks, adjust confidence based on:
- **Task complexity vs. estimated**: If actual > estimate, reduce future estimates for similar tasks
- **Unknown discovery**: If multiple unknowns encountered, increase uncertainty for related tasks
- **External dependencies**: If third-party issues arise, adjust confidence for integration tasks

### Confidence Scoring Guide
- **10**: Done this exact thing before, patterns well-understood
- **8-9**: Similar patterns, familiar tech stack, minor adaptations
- **5-7**: Good approach, some validation needed
- **1-4**: High uncertainty, needs rework or validation

**When confidence drops more than 3 points** from initial assessment, **PAUSE** and reassess approach.

- **8-10**: We're confident this is right and works
- **5-7**: Mostly confident, some unknowns or refinement needed
- **1-4**: High uncertainty, needs rework or validation

### Blocker Tracking

```markdown
**Blocked: [Task ID]**
- **Issue**: [What's stopping us]
- **Impact**: [Critical / High / Medium / Low]
- **Proposed Fix**: [How to unblock]
- **Owner**: [Who's working on it]
```

## Progress Report

Include:
1. **Completed tasks** — What's done and confidence score
2. **In-progress** — Current task and progress %
3. **Blockers** — What's slowing us down
4. **Decisions made** — Key pivots or choices
5. **Next steps** — Recommended actions

## Key Rules

- **Mark tasks off immediately** — [X] when complete
- **Update confidence honestly** — Don't fake certainty
- **Log blockers fast** — Don't let them linger
- **Track time** — How long tasks actually take
- **Note pivots** — When we deviate from plan
