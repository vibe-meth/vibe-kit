# Quick Start Guide

Get started with VibeCoder in 5 minutes.

> [!NOTE]
> All VibeCoder scripts work on macOS, Linux, and Windows. Scripts auto-detect your OS and use the appropriate shell (bash or PowerShell).

## The 3-Step Process

### Step 1: Install VibeCoder CLI

```bash
# Create a new project
uvx --from git+https://github.com/vibekit/vibe-kit.git vibe init <PROJECT_NAME>

# OR initialize in current directory
uvx --from git+https://github.com/vibekit/vibe-kit.git vibe init .
```

Or install persistently:

```bash
uv tool install vibe-cli --from git+https://github.com/vibekit/vibe-kit.git
vibe init <PROJECT_NAME>
```

### Step 2: Create Your Plan

Open your AI assistant and use the `/vibekit.plan` command:

```markdown
/vibekit.plan
Build a user dashboard that shows:
1. Recent activity (last 7 days)
2. Performance metrics (charts)
3. Settings panel (dark mode, notifications)

Tech: React frontend, Node.js backend, PostgreSQL
Timeline: 2 weeks
```

Your AI will create `plan.md` with:
- High-level phases (3-5 major chunks)
- Key assumptions you're making
- Confidence scores (1-10) on feasibility
- Success criteria for each phase

### Step 3: Break Into Tasks & Execute

```markdown
/vibekit.tasks
```

Your AI creates `tasks.md` with:
- Actionable tasks mapped to phases
- Dependencies and execution order
- Parallel opportunities
- Time estimates

Then execute:

```markdown
/vibekit.execute
I completed SETUP-1 (database setup), 9/10 confident.
Blocked on SETUP-2 (API key), unblocking tomorrow.
Proceeding with CORE-1 in parallel.
```

Your AI updates task status and tracks:
- ✓ Completed tasks
- → In-progress work
- ! Blockers
- Confidence scores (8/10 means proceed, 4/10 means clarify)

---

## Optional: Get Guidance

Before execution, ask questions:

```markdown
/vibekit.clarify
What are the riskiest assumptions in this plan?
Do we have the right dependencies?
```

Mid-phase, get perspective:

```markdown
/vibekit.insight
How's our progress? Any patterns to watch?
```

After phases, review quality:

```markdown
/vibekit.review
Did we meet our success criteria?
What should we improve next?
```

---

## Tips for Best Results

**✓ Plan in phases, not specs**
- 3-5 major phases instead of 50 micro-tasks
- Document what you're assuming, not what you know

**✓ Score confidence honestly**
- 8/10 confident = good, proceed
- 5/10 confident = needs validation
- 3/10 confident = stop, clarify

**✓ Log blockers immediately**
- Don't wait for status meetings
- Blockers trigger fast reassessment

**✓ Treat pivots as wins**
- Plans change; that's learning
- Adjust confidently based on what you discover

**✓ Let AI coordinate**
- You focus on code
- AI handles tracking, dependencies, trends

---

## Example: Building a Feature

```
/vibekit.plan
Build user authentication with OAuth2 and JWT tokens.
- Phase 1: Database schema + OAuth setup
- Phase 2: JWT token generation/validation
- Phase 3: User session management
- Phase 4: Testing & security audit

Confidence: 7/10 (OAuth integration needs validation)
```

↓

```
/vibekit.tasks
(AI generates SETUP-1, SETUP-2, CORE-1, CORE-2, POLISH-1, etc.)
```

↓

```
/vibekit.execute
Completed SETUP-1 ✓ 9/10
Completed SETUP-2 ✓ 8/10
In progress: CORE-1 [→] 7/10
Blocked: Waiting on OAuth API docs
```

↓

```
/vibekit.insight
Confidence trend: 8 → 7 (stable, good)
Blocker: OAuth docs delayed by 1 day
Recommendation: Start CORE-2 in parallel
```

↓

```
/vibekit.execute
Completed CORE-1 ✓ 8/10
Completed CORE-2 ✓ 7/10 (needs validation)
In progress: POLISH-1
```

↓

```
/vibekit.review
Phase 1-2 complete: 90% of spec met
Quality: Code solid, test coverage 85%
Recommendations: Add integration tests before Phase 3
```

Done. Ship it. Learn from production.

---

## Directory Structure

```
your-project/
├── .agents/              # AI agent configuration
├── plan.md              # Your vibe plan
├── tasks.md             # Task breakdown & execution log
├── memory/              # VibeCoder guidelines & context
├── templates/           # Command templates
└── scripts/             # Helper scripts
```

---

## Common Commands

```bash
# Check your setup
vibe check

# See version & system info
vibe version

# View help
vibe --help
```

---

**That's it. Start with plan, break into tasks, execute, track confidence, adjust, ship.**

🎵
