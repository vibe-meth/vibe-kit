---
description: "Create a vibe plan — high-level direction, phases, and confidence assessment"
scripts:
  sh: scripts/bash/setup-vibe.sh --json
  ps: scripts/powershell/setup-vibe.ps1 -Json
agent_scripts:
  sh: scripts/bash/update-agent-context.sh __AGENT__
  ps: scripts/powershell/update-agent-context.ps1 -AgentType __AGENT__
handoffs:
  - label: Generate Tasks
    agent: vibekit.tasks
    prompt: Break this plan into actionable tasks
    send: true
  - label: Clarify Details
    agent: vibekit.clarify
    prompt: Ask clarifying questions before we execute
    send: false
---

## User Input

```text
$ARGUMENTS
```

You **MUST** consider the user input before proceeding (if not empty).

## Outline

1. **Setup**: Run `{SCRIPT}` from repo root to create vibe plan file structure and get paths
2. **Understand Context**: Read `/memory/vibe-guidelines.md` and `/memory/vibe-context.md`
3. **Create Vibe Plan**: Generate plan.md with phases, unknowns, and success criteria
4. **Update Agent Context**: Run agent script to sync plan context with your AI assistant
5. **Report**: Show plan structure and next steps

## Vibe Plan Structure

Create `plan.md` with:

### 1. Vision & Scope
- **What we're building**: 1-2 sentence description
- **Why it matters**: User value, business reason
- **Success metric**: How do we know this worked?

### 2. Key Phases (3-5 max)
For each phase:
- **Name & description**: What's happening
- **Key work**: Main things to do
- **Assumptions**: What we're assuming to be true
- **Success signal**: How do we know this phase is done?
- **Confidence**: 1-10 on feasibility

### 3. Technical Context
- **Tech stack decisions**: What we're using and why
- **Dependencies**: External systems, APIs, data
- **Unknowns**: NEEDS CLARIFICATION items
- **Constraints**: Time, scope, performance, security

### 4. Execution Flow
- **Execution order**: Phases happen sequentially or in parallel?
- **Blockers**: What could stop us?
- **Pivots**: When do we reassess?

### 5. Confidence Assessment
- **High confidence (8-10)**: We know how to do this
- **Medium confidence (5-7)**: We have a direction, need validation
- **Low confidence (1-4)**: We need more research

## Phase Template

```markdown
## Phase [#]: [Name]

### What
[What we're doing in 2-3 sentences]

### Why
[Why this phase matters]

### Work Items
- [Main work]
- [Main work]
- [Main work]

### Key Decisions
| Decision | Choice | Rationale |
|----------|--------|-----------|
| [What] | [Decision] | [Why] |

### Assumptions
- [Assumption #1 — Risk if wrong]
- [Assumption #2 — Risk if wrong]

### Success Signal
- [How do we know this is done?]
- [What validation do we need?]

### Confidence: [X/10]
[Why this score]
```

## Key Rules

- **Stay flexible** — Plans can and will change
- **Document assumptions** — Make unknowns visible
- **Be honest about confidence** — Don't fake certainty
- **Think in phases** — Not individual tasks yet
- **Focus on flow** — Will execution be smooth?
