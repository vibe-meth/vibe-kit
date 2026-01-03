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

### 8. Recovery Commands

#### Rollback & Recovery Commands
```markdown
### Create Recovery Point
**Usage**: `vibe checkpoint "Create API v2 integration"`
**Action**: Snapshots current state and creates recovery point ID-123

### Manual Rollback
**Usage**: `vibe rollback ID-123`
**Action**: Restores state from recovery point ID-123

### List Recovery Points
**Usage**: `vibe recovery list`
**Shows**: All available recovery points with timestamps and descriptions

### Auto-Recovery on Failure
**Usage**: `vibe auto-recovery on`
**Action**: When confidence drops >3 points automatically create recovery point and rollback
```

### Recovery System Integration
All recovery operations work with existing `{SCRIPT}` infrastructure and update `tasks.md` automatically with new recovery points and rollback information.

### Confidence Scoring Guide

- **8-10**: We're confident this is right and works
- **5-7**: Mostly confident, some unknowns or refinement needed
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

### 7. Recovery & Rollback System

#### Recovery Points Creation
For each significant task change or checkpoint:
```markdown
### Recovery Point [ID]: [Checkpoint Description]
- **Timestamp**: [Date/time of checkpoint]
- **State Snapshot**: [Files + confidence summary]
- **Rollback Command**: `vibe rollback [ID]` 
```

#### Automatic Recovery Triggers
- **Confidence drops > 3 points** between checkpoints
- **Task fails validation** (tests don't pass)
- **External dependency changes** (API updates, tool breaks)
- **Multiple blockers** triggered in same phase

#### Rollback Protocol
1. **Identify last stable recovery point** using recovery point logs
2. **Verify task state** matches expected pre-change condition
3. **Execute rollback** using appropriate script (setup-vibe, database migrations, etc.)
4. **Validate rollback** confirmed working state restored

## Agent-Specific Guidance & Smart Workflow Integration

### For Claude (Narrative Reasoning Agent)
**Strengths**: Complex blocker analysis, stakeholder communication, comprehensive progress reporting
**Best for**: Progress tracking, blocker resolution, stakeholder updates
**Workflow optimization**:
- Provide detailed analysis of progress blockers and their impacts
- Communicate progress clearly to diverse stakeholders
- Consider broader implications of execution decisions
- Maintain comprehensive execution narrative

### For Cursor (IDE Integration Agent)
**Strengths**: Code-level progress tracking, technical blocker resolution, immediate feedback
**Best for**: Task execution, technical debugging, code quality assurance
**Workflow optimization**:
- Track code-level progress with concrete metrics
- Provide immediate technical feedback on implementation
- Debug issues with direct code analysis
- Ensure high-quality, maintainable code delivery

### For Copilot (Code Generation Agent)
**Strengths**: Rapid implementation, pattern application, code generation assistance
**Best for**: Task completion, code generation, technical problem solving
**Workflow optimization**:
- Generate working code quickly for complex tasks
- Apply proven patterns and best practices
- Provide multiple implementation options
- Focus on practical, executable solutions

### For Gemini (Multi-modal Agent)
**Strengths**: Broad problem solving, creative debugging, comprehensive analysis
**Best for**: Blocker resolution, alternative approaches, complex problem solving
**Workflow optimization**:
- Consider multiple debugging strategies
- Provide comprehensive analysis of issues
- Explore creative solutions to blockers
- Synthesize diverse technical approaches

### Smart Workflow Integration

#### Automated Progress Tracking
- **Confidence monitoring**: Track confidence evolution throughout execution
- **Blocker pattern recognition**: Identify systemic issues vs. isolated problems
- **Progress prediction**: Estimate completion based on current velocity
- **Quality gate validation**: Ensure work meets acceptance criteria

#### Intelligent Assistance
- **Blocker resolution suggestions**: Provide specific solutions based on patterns
- **Resource optimization**: Suggest task reassignment for better flow
- **Risk monitoring**: Alert when execution risks increase
- **Recovery recommendations**: Suggest rollback or alternative approaches

#### Execution Intelligence
- **Velocity analysis**: Learn from execution patterns to improve estimates
- **Quality trend monitoring**: Track code quality and bug rates
- **Collaboration optimization**: Suggest communication improvements
- **Success prediction**: Forecast project completion based on current trends

## Progress Report
Include:
1. **Completed tasks** — What's done and confidence score
2. **In-progress** — Current task and progress %
3. **Blockers** — What's slowing us down with resolution strategies
4. **Decisions made** — Key pivots or choices with rationale
5. **Recovery points used** — Rollbacks and recoveries applied
6. **Confidence trends** — How certainty has evolved
7. **Next steps** — Recommended actions with confidence levels

## Key Rules

- **Mark tasks off immediately** — [X] when complete
- **Update confidence honestly** — Don't fake certainty
- **Log blockers fast** — Don't let them linger
- **Track time** — How long tasks actually take
- **Note pivots** — When we deviate from plan
