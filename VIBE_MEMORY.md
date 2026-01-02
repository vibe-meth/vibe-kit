# 🎵 VibeCoder Methodology

**VibeCoder: Flow-first, intuition-driven development with AI as your co-pilot.**

---

## Core Philosophy

Vibe-Driven Development (VDD) flips the script on how we plan and build. Instead of exhaustive specifications and rigid processes, we embrace intuition, track confidence honestly, and keep developers in flow.

### The Four Pillars

#### 1. **Flow Over Friction**
Keep developers in momentum; AI handles bookkeeping.
- Plan in phases, not procedures
- Let intuition guide initial direction
- AI monitors dependencies, logs blockers, suggests next moves

#### 2. **Confidence Over Certainty**
Score every task honestly; pivot when trends drop.
- 8-10: We know this. Ship it.
- 5-7: Mostly right, needs validation.
- 1-4: Risky. Research or pivot.
- Track confidence trends across phases to spot problems early

#### 3. **Phases Over Specs**
Plan in high-level phases; allow natural iterations.
- 3-5 major phases instead of 50 micro-tasks
- Document assumptions, not exhaustive requirements
- Phases can pivot as we learn

#### 4. **Flexibility Over Rigidity**
Treat blockers as signals, not failures.
- Blockers trigger fast reassessment, not process escalation
- Plans change when reality demands it
- Quick pivots are wins, not deviations

---

## The Workflow

```
┌──────────────────────────────────────────────────────────┐
│                    VIBE-DRIVEN CYCLE                      │
└──────────────────────────────────────────────────────────┘

    PLAN (Phases)
         ↓
    [Document Assumptions, Score Confidence 1-10]
         ↓
    TASKS (Dependencies)
         ↓
    [Map execution order, identify parallels]
         ↓
    EXECUTE (Real-time)
         ↓
    [Mark done ✓, Score Confidence, Log Blockers]
         ↓
    [Confidence trend drops? → CLARIFY / REASSESS]
    [Want perspective? → INSIGHT / REVIEW (optional)]
         ↓
    Next Phase
```

### What AI Does

- **Planning**: Structures your vibe into phases; calls out assumptions
- **Tasks**: Breaks phases into actionable work; identifies dependencies
- **Execution**: Tracks progress, scores confidence, flags blockers
- **Real-time**: Monitors trends; suggests pivots if confidence dips
- **Bookkeeping**: Logs decisions, learnings, changes — you focus on code

---

## Confidence Scoring

Confidence is the heartbeat of VibeCoder. Score honestly at every phase:

```
Phase 1: Auth Module
├─ Database design: 8/10 (we've done this before)
├─ OAuth flow: 6/10 (need API validation)
└─ Testing strategy: 5/10 (new tool choice)

Trend: Medium → Keep going, validate OAuth early
```

**Confidence Rules:**
- Score after each task or phase
- Use trends, not snapshots (9 → 6 is a signal)
- Low confidence (<5)? Stop and clarify, don't push forward
- High confidence (8+)? Ship faster, iterate post-launch

---

## When to Use Each Command

### Core Workflow (Sequential)

**`/vibekit.plan`** — Start here
- Create phases, assumptions, success metrics
- Output: `plan.md`
- Confidence: Be honest about unknowns

**`/vibekit.tasks`** — After plan is solid
- Break phases into actionable tasks
- Map dependencies, identify parallels
- Output: `tasks.md`

**`/vibekit.execute`** — During development
- Mark tasks complete [X]
- Update confidence scores
- Log blockers and decisions
- Output: Updated `tasks.md`

### Optional Advisory (Anytime)

**`/vibekit.clarify`** — Pre-execution, if uncertain
- Surface hidden assumptions
- De-risk the plan
- Ask critical questions

**`/vibekit.insight`** — Mid-phase checkpoint
- Analyze progress patterns
- Spot risks early
- Recommend course adjustments

**`/vibekit.review`** — After phases or milestones
- Assess quality and completeness
- Identify improvement areas
- Plan next iterations

---

## VibeCoder vs Spec-Driven Development

| Dimension | VibeCoder | Spec-Kit |
|-----------|-----------|----------|
| **Philosophy** | Flow first, intuition-driven | Specification-driven, predictable |
| **Planning** | 3-5 high-level phases | Exhaustive specs & contracts |
| **Timeline** | Days to weeks | Weeks to months |
| **Confidence** | Scored & tracked (1-10) | Assumed after spec approval |
| **Adjustment** | Fast, continuous | Formal change control |
| **Best for** | Fast teams, clear direction | Complex systems, high-stakes work |
| **Overhead** | Minimal | Structured, thorough |

**Choose VibeCoder if:**
- Your team knows how to code and trust intuition
- You need to move fast and iterate
- You're comfortable with honest uncertainty
- You want AI as a co-pilot, not a process engine

**Choose Spec-Kit if:**
- You need exhaustive specification before coding
- Multiple teams need to coordinate tightly
- Risk/compliance requires detailed documentation
- You're building mission-critical systems

---

## Core Values

1. **Shipping > Perfection** — Move fast, iterate in production
2. **Honesty > Confidence** — A 5/10 confident task is useful data
3. **Flow > Process** — Minimize friction; let developers code
4. **Learning > Planning** — Build and learn, don't plan and guess
5. **Pragmatism > Purity** — Use what works; abandon what doesn't

---

## Example: Confidence Trending

```
Feature: User Dashboard

Phase 1 (Auth & Data)
  Task 1.1: Database schema → [X] 9/10 (standard patterns)
  Task 1.2: Auth service → [X] 7/10 (needs API testing)
  Task 1.3: Data models → [X] 8/10 (clear requirements)
  Phase confidence: 8/10

Phase 2 (UI & Integration)
  Task 2.1: Component setup → [X] 8/10
  Task 2.2: Form validation → [X] 5/10 ← Dropped! Need clarify
  Task 2.3: API integration → [→] 6/10
  
  SIGNAL: Confidence dropped from 8 → 5 on validation
  ACTION: Clarify requirements; consider research spike
```

---

## The Vibe

VibeCoder is for developers who:
- Trust their instincts but track their confidence
- Want structure without process bureaucracy
- Move fast and learn from shipping
- See blockers as feedback, not failure
- Use AI as a thinking partner, not a process engine

**Make decisions. Track confidence. Adjust. Ship. Repeat.**

🎵
