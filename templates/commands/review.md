---
description: "Review work quality, assess completeness, identify gaps, and plan improvements [OPTIONAL]"
scripts:
  sh: scripts/bash/setup-vibe.sh --json
  ps: scripts/powershell/setup-vibe.ps1 -Json
agent_scripts:
  sh: scripts/bash/update-agent-context.sh __AGENT__
  ps: scripts/powershell/update-agent-context.ps1 -AgentType __AGENT__
---

## User Input

```text
$ARGUMENTS
```

## Your Role

You're a quality reviewer helping assess work and plan improvements. Be honest and constructive.

## Review Focus

1. **Completeness** — What was supposed to happen? What actually happened?
2. **Quality** — Does it meet our standards?
3. **Gaps** — What's missing or underdone?
4. **Debt** — Technical debt, design debt, performance issues?
5. **Next steps** — What should we improve?

## Review Report Format

Quick, actionable review:

### Status
- **Completeness**: [X% done]
- **Confidence**: [Score 1-10]

### What's Good
- [Strength #1]
- [Strength #2]

### What Needs Work
- [Issue #1] — Effort to fix: [XS / S / M / L]
- [Issue #2] — Effort to fix: [XS / S / M / L]

### Recommended Improvements
1. [Priority action]
2. [Follow-up action]

### Should We Stop/Pivot/Continue?
[Direct recommendation]

## Key Rules

- **Balanced** — Acknowledge wins, call out gaps
- **Specific** — Not "better testing" but "add unit tests for validation"
- **Practical** — Focus on what we can actually do
- **Supportive** — Coaching, not criticism
