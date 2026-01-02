<div align="center">
    <img src="./media/vibekit.png" alt="VibeCoder Logo" width="400" height="400"/>
    <h1>🎵 VibeCoder</h1>
    <h3>Ship faster with AI. No specs. No perfection. Just momentum.</h3>
</div>

<p align="center">
    <strong>For developers who use AI to code faster. Plan in phases, track confidence, ship with confidence.</strong>
</p>

<p align="center">
    <a href="https://github.com/vibe-meth/vibe-kit/blob/main/LICENSE"><img src="https://img.shields.io/badge/license-MIT-9d4edd?style=for-the-badge" alt="MIT License"/></a>
    <a href="https://github.com/vibe-meth/vibe-kit"><img src="https://img.shields.io/badge/python-3.11+-7209b7?style=for-the-badge" alt="Python 3.11+"/></a>
    <a href="https://github.com/vibe-meth/vibe-kit"><img src="https://img.shields.io/badge/status-production%20ready-06a77d?style=for-the-badge" alt="Production Ready"/></a>
    <a href="https://github.com/vibe-meth/vibe-kit"><img src="https://img.shields.io/badge/vibe-driven%20development-3c096c?style=for-the-badge" alt="Vibe-Driven Development"/></a>
    <a href="https://github.com/vibe-meth/vibe-kit"><img src="https://img.shields.io/badge/19%2B-AI%20Agents-5a189a?style=for-the-badge" alt="19+ AI Agents"/></a>
    <a href="https://github.com/vibe-meth/vibe-kit"><img src="https://img.shields.io/badge/contributions-welcome-f72585?style=for-the-badge" alt="Contributions Welcome"/></a>
</p>

---

## Why VibeCoder?

You're using AI to code. That's smart. But without a workflow, it becomes:

- ❌ Endless back-and-forth with your AI
- ❌ Lost context between conversations
- ❌ Unclear what needs doing next
- ❌ Shipping broken because you didn't validate

**VibeCoder fixes this.** It gives you a 3-step workflow that keeps you and your AI in sync, tracks what actually works, and lets you ship when confidence is high.

### The Problem VibeCoder Solves

**Without VibeCoder:**
```
Tell AI → Get code → Run it → Confused what to do next
→ Tell AI again → Repeat → Lost 2 hours
```

**With VibeCoder:**
```
PLAN (3-5 phases) → TASKS (AI breaks it down) → EXECUTE (track confidence)
→ Done, shipped, confident
```

---

## Who Uses VibeCoder?

- **Solo developers** speeding up with Claude/Copilot
- **Bootstrappers** shipping fast, not perfect
- **Teams** moving quickly with shared confidence scores
- **Anyone** who wants to code faster with AI, not slower

---

## How It Works (5 Minutes)

### Step 1: Install
```bash
uv tool install vibe-cli --from git+https://github.com/vibe-meth/vibe-kit.git
vibe init my-project --ai claude
```

### Step 2: Plan (Tell Your AI What to Build)
Open Claude/Copilot/Amp and use:
```
/vibekit.plan

Build a user dashboard that shows:
- Recent activity (last 7 days)
- Performance metrics (charts)
- Settings panel (dark mode, notifications)

Tech: React, Node.js, PostgreSQL
Timeline: 2 weeks
```

Your AI creates a **plan.md** with phases, assumptions, and confidence scores.

### Step 3: Break Down (Get Task List)
```
/vibekit.tasks
```

Your AI maps out the work, dependencies, and execution order. Now you know exactly what's next.

### Step 4: Execute (Track Confidence)
```
/vibekit.execute

Task: Set up auth database
Status: Done
Confidence: 8/10 (OAuth works, but validation needed)
Blockers: None
```

Track progress. When confidence drops (5/10 or lower), stop and clarify. Ship when confidence is high (8+).

---

## The Core Insight

**You don't need perfect specs. You need honest confidence.**

- **8-10 confidence** = Ship it. Iterate later if needed.
- **5-7 confidence** = Validate before shipping. Something's unsure.
- **1-4 confidence** = Stop. Clarify. Don't push forward confused.

This is how real developers work. VibeCoder just makes it explicit.

---

## What You Get

### 1. Workflow That Matches Your Brain
- Plan in **phases**, not micro-tasks (3-5 things at a time)
- AI stays in context (not new conversation every time)
- Clear next steps (no "what do I do now?")

### 2. Confidence-Based Shipping
- Score every task honestly (1-10)
- See trends (confidence 9 → 6? Something's wrong)
- Ship with confidence, not hope

### 3. AI That Actually Helps
- AI monitors dependencies
- AI suggests next moves
- AI handles the bookkeeping (you code)

### 4. Works With Your AI
- Claude Code, Copilot, Cursor, Amp, Gemini, and 14+ others
- Drop-in commands: `/vibekit.plan`, `/vibekit.tasks`, `/vibekit.execute`
- Works in any editor

### 5. Zero Overhead
- No lengthy processes
- No approval cycles
- No specs (just phases)
- Pivot when needed

---

## Real Workflow

```
Monday morning: /vibekit.plan → 15 minutes planning with Claude
Tuesday: /vibekit.tasks → Claude breaks it into 12 tasks
Wed-Thu: /vibekit.execute → You execute, mark done, score confidence
Friday: Confidence trending down? /vibekit.clarify → Course correct
Done by Friday. Shipped Monday.
```

Compare to traditional: Plan week 1, review week 2, code weeks 3-5, bugs week 6. Total: 6 weeks.

---

## Commands

### Initialize Project
```bash
vibe init my-project --ai claude
vibe init . --ai copilot          # Use in current directory
```

### Core Workflow (Use These)
```
/vibekit.plan      Plan your phases (do this first)
/vibekit.tasks     Break into tasks (AI does this)
/vibekit.execute   Track progress (do this daily)
```

### Optional Guidance (Use When Stuck)
```
/vibekit.clarify   Stuck? Ask clarifying questions
/vibekit.insight   Mid-phase? Analyze what's happening
/vibekit.review    Done? Review what you learned
```

---

## Supported AI Agents

Works with everything:

**CLI-based**: Claude Code • Gemini CLI • Amazon Q Developer • Amp • Codex CLI • Qwen Code • opencode • Auggie CLI • CodeBuddy • Qoder CLI • SHAI

**IDE-based**: GitHub Copilot (VS Code) • Cursor IDE • Windsurf • Roo Code • Kilo Code • IBM Bob

Don't see yours? [Add it](./CONTRIBUTING.md) or [request it](https://github.com/vibe-meth/vibe-kit/issues).

---

## Key Features

- **Phase-based Planning** — Plan in chunks (3-5), not 50 micro-tasks
- **Confidence Scoring** — Track confidence (1-10). Ship at 8+.
- **Real-time Execution Tracking** — Mark done, log blockers, spot issues early
- **Confidence Trending** — See patterns (9 → 6 = problem)
- **AI Co-piloting** — Your AI handles dependencies, you code
- **Multi-Agent Support** — Use any AI assistant
- **Low Overhead** — Minutes to set up, seconds to use
- **Dev Container Ready** — Full Docker setup with all agents pre-installed
- **Cross-platform** — macOS, Linux, Windows (automatic Bash/PowerShell)

---

## Confidence System

The heart of VibeCoder. Not hours, not story points. Just honest confidence.

```
Task: Implement OAuth2 flow
Confidence: 6/10
Why: I know the pattern, but haven't used this library before
Next: Research library docs, validate with AI

Task: Set up PostgreSQL
Confidence: 9/10
Why: I've done this 20 times
Next: Ship it
```

When confidence drops mid-phase (8 → 5), something changed. Stop. Clarify. Don't push through confused.

---

## FAQ

**Q: Is this for juniors or seniors?**  
A: Both. Juniors use it to ship faster with AI. Seniors use it to manage uncertainty on new tech.

**Q: What if I don't have an AI agent yet?**  
A: VibeCoder supports 19+ agents. Pick one: Claude is best for planning, Copilot is free, Cursor is best UX.

**Q: Do I have to use all 6 commands?**  
A: No. The 3 core commands (plan, tasks, execute) are enough. The others (clarify, insight, review) are optional.

**Q: How is this different from just using AI?**  
A: Without VibeCoder, you chat with AI. With VibeCoder, you have a workflow. AI stays in context. You don't repeat yourself.

**Q: Can teams use this?**  
A: Yes. Share plans, tasks, and confidence scores. CI/CD friendly. Works with git.

**Q: How long does it take to learn?**  
A: 5 minutes. Seriously. Three commands: plan, tasks, execute.

**Q: Will this slow me down?**  
A: No. Overhead is minimal. You spend 15 minutes planning, 5 minutes organizing, then just code. Less context switching than emailing specs.

---

## Getting Started

1. **Install**: `uv tool install vibe-cli --from git+https://github.com/vibe-meth/vibe-kit.git`
2. **Initialize**: `vibe init my-project --ai claude`
3. **Plan**: Open Claude, type `/vibekit.plan`, describe what you're building
4. **Ship**: Follow the tasks, track confidence, ship when confident

[Full Tutorial](./docs/quickstart.md)

---

## Documentation

- [Quick Start](./docs/quickstart.md) — 5-minute walkthrough
- [Installation Guide](./docs/installation.md) — Get it running
- [Full Methodology](./VIBE_MEMORY.md) — The philosophy behind VibeCoder
- [VibeCoder vs Spec-Kit](./docs/vibe-vs-spec.md) — Should you use this or Spec-Kit?
- [All Docs](./docs/index.md)

---

## Contributing

VibeCoder is open source. Contribute:

- [Report bugs](https://github.com/vibe-meth/vibe-kit/issues)
- [Suggest features](https://github.com/vibe-meth/vibe-kit/issues)
- [Submit code](./CONTRIBUTING.md)
- [Join discussions](https://github.com/vibe-meth/vibe-kit/discussions)

---

## Community

- [Issues & Feature Requests](https://github.com/vibe-meth/vibe-kit/issues)
- [Discussions](https://github.com/vibe-meth/vibe-kit/discussions)
- [Support](./SUPPORT.md)

---

## Project Structure

```
vibe-kit/
├── src/vibe_cli/           CLI implementation
├── templates/              Command templates (plan, tasks, execute, etc.)
├── scripts/                Setup and utility scripts
├── docs/                   Documentation
├── memory/                 VibeCoder guidelines
├── .devcontainer/          Dev container (AI agents pre-installed)
└── media/                  Logos and images
```

---

## License

MIT. Free to use, modify, distribute. See [LICENSE](./LICENSE).

---

## Code of Conduct

Community is important. See [CODE_OF_CONDUCT.md](./CODE_OF_CONDUCT.md).

---

## Security

Found a bug? Report it to security@vibekit.dev (not GitHub issues). [Policy](./SECURITY.md).

---

**Made with vibes by developers, for developers.** 🎵

For people who code with AI. For people who ship fast. For people who value momentum over perfection.
