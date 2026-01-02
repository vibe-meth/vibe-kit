# VibeCoder Guidelines

These guidelines shape how your project works with AI. Reference these during planning and execution.

## Development Principles

1. **Move Fast** — Shipping beats perfection
2. **Be Honest** — Confidence scores tell the truth
3. **Flow Matters** — Minimize process overhead
4. **Learn by Building** — Iterate in code, not specs
5. **Adapt Quickly** — Pivots are wins, not failures

## Confidence Scoring

### 8-10: Ship It
- We understand the requirements
- We have patterns we've used before
- We're confident in the approach
- **Action**: Proceed at full speed

### 5-7: Mostly Ready
- We have a direction
- Some unknowns remain
- Needs validation or testing
- **Action**: Proceed, track carefully, validate early

### 1-4: Stop & Clarify
- Too many unknowns
- High risk of rework
- Need more research/questions
- **Action**: Use `/vibekit.clarify` before proceeding

## Phase Structure

**Typical phases:**
1. **Setup** — Infrastructure, dependencies, scaffolding
2. **Core** — Main features and business logic
3. **Integration** — Connect to external systems
4. **Polish** — Testing, optimization, documentation

**Phase expectations:**
- Each phase has clear success criteria
- Confidence is scored per phase
- Phases usually take 2-5 work days
- Blockers surface immediately

## Task Execution

**Small is good:**
- Tasks should take 1-4 hours
- Smaller tasks = faster feedback = better confidence
- Parallel tasks speed execution

**Mark progress:**
- Update `/vibekit.execute` after each task
- Include actual time vs estimate
- Log decisions and learnings
- Flag blockers immediately

## Blockers

**When blocked:**
1. Document the issue clearly
2. Note impact (critical / high / medium / low)
3. Propose a workaround or fix
4. Unblock within 24 hours if critical

**Blocker types:**
- **External** — Waiting for API, data, third party
- **Technical** — Missing knowledge, tool issue
- **Process** — Approval, access, environment
- **Design** — Unclear requirements, conflicting goals

**Action:** Use `/vibekit.insight` if blocker pattern emerges

## Handoffs Between Phases

Before moving to the next phase:

1. **Verify completion** — All tasks done?
2. **Review confidence** — Confidence trending up or down?
3. **Check blockers** — Any unresolved issues?
4. **Document learnings** — What did we discover?
5. **Update next phase** — Adjust plan based on learnings

## When to Use Each Command

| Situation | Command | Why |
|-----------|---------|-----|
| Starting work | `/vibekit.plan` | Create phases & assumptions |
| Planning phase | `/vibekit.tasks` | Break into actionable work |
| Uncertain about plan | `/vibekit.clarify` | Surface assumptions |
| Executing tasks | `/vibekit.execute` | Track progress & confidence |
| Mid-phase check-in | `/vibekit.insight` | Spot patterns & adjust |
| After phase complete | `/vibekit.review` | Assess quality & learnings |

## Team Coordination

**With distributed teams:**
- Keep confidence scores updated (daily)
- Log blockers in real-time
- Use `/vibekit.insight` for async standups
- Document decisions for context

**With co-located teams:**
- Plan together (sync)
- Execute independently (async)
- Check in during blockers or phase transitions
- Use `/vibekit.execute` as execution log

## Success Indicators

✅ **You're vibing well if:**
- Confidence scores are 6+ most of the time
- Blockers are caught early
- Tasks take predicted time
- You're shipping incremental value
- Team feels momentum

⚠️ **Adjust if:**
- Confidence consistently < 5 (need more clarification)
- Too many surprises (planning too ambitious)
- Tasks take 2x estimated time (break smaller)
- Too many blockers (dependencies unclear)
- Team feels bogged down (too much process)

## Remember

> **Vibe-Driven Development is not about being fast and loose. It's about being** ***honest, adaptive, and focused on flow*** **while shipping real value.**

Phase. Track. Adjust. Ship. Repeat.

🎵
