---
description: "Break vibe plan into actionable tasks with clear dependencies and execution order"
scripts:
  sh: scripts/bash/create-new-task.sh --json
  ps: scripts/powershell/create-new-task.ps1 -Json
---

## User Input

```text
$ARGUMENTS
```

You **MUST** consider the user input before proceeding (if not empty).

## Outline

1. **Load context**: Read `plan.md` for phases, decisions, and dependencies
2. **Parse dependencies**: Identify task order, parallels, and blockers
3. **Generate tasks.md**: Create structured task breakdown with execution flow
4. **Validate**: Confirm tasks map to all plan items and dependencies are clear
5. **Report**: Show execution order and initial task queue

## Task Breakdown Structure

Create `tasks.md` with:

### 1. Execution Overview
- **Task count**: Total number of tasks
- **Critical path**: Which tasks form the longest dependency chain
- **Parallel opportunities**: Tasks that can run simultaneously
- **Estimated duration**: Rough timeline

### 2. Task List by Phase
For each plan phase, generate tasks:
- **Task ID**: [Phase]-[#] (e.g., SETUP-1, CORE-2)
- **Title**: Action verb + object ("Implement user auth", not "Work on auth")
- **Description**: What we're doing and why
- **Acceptance criteria**: How we know it's done
- **Depends on**: [TASK-ID] or "None"
- **Estimate**: XS (< 1 hour), S (1-2h), M (2-4h), L (4+ hours)
- **Priority**: High / Medium / Low

### 3. Dependency Graph
```
SETUP-1 → CORE-1
SETUP-1 → CORE-2
CORE-1 → CORE-3 [PARALLEL with CORE-2]
CORE-2 → CORE-3
CORE-3 → POLISH-1
```

### 4. Execution Queue
Ordered list of tasks with parallel markers:
```
1. SETUP-1 — Initialize project
2. CORE-1 [P] — Implement data model
   CORE-2 [P] — Setup database
   (Can run in parallel)
3. CORE-3 — API endpoints (depends on CORE-1, CORE-2)
4. POLISH-1 — Testing & validation
```

## Task Template

```markdown
### [PHASE]-[#]: [Title]

**Description**: [2-3 sentences on what we're doing]

**Acceptance Criteria**:
- [ ] [Measurable outcome]
- [ ] [Measurable outcome]
- [ ] [Measurable outcome]

**Depends on**: [TASK-ID] or None

**Estimate**: [XS / S / M / L]

**Unknowns**:
- [What might surprise us]
- [What needs validation]
```

## Key Rules

- **Task = 1-4 hours of work max**
- **One responsibility per task**
- **Clear acceptance criteria**
- **Document all dependencies**
- **Identify research/spike tasks separately**
- **Mark parallel-ready tasks [P]**
