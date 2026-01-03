---
description: "Ask clarifying questions to surface assumptions and de-risk the plan [OPTIONAL PRE-EXECUTION]"
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

You're asking strategic questions to surface hidden assumptions and validate the plan before execution. Be curious, not critical.

## Systematic Risk Assessment Framework

### Critical Question Matrix
| Question | Impact if Wrong | Testability | Priority | Stakeholder |
|----------|----------------|-------------|----------|-------------|
| [Question] | [Critical/High/Med/Low] | [Easy/Hard/Impossible] | [P0/P1/P2] | [User/Business/Tech] |

**Priority Guidelines:**
- **P0 (Must Answer)**: Critical assumptions that could kill the project
- **P1 (Should Answer)**: High-impact decisions affecting major features
- **P2 (Nice to Answer)**: Low-risk details, can make reasonable assumptions

### Stakeholder Alignment Framework

#### User Perspective
- **Problem validation**: Does this solve a real user need?
- **Value proposition**: What's the user benefit vs. alternatives?
- **Usage context**: How/when/where will users interact with this?
- **Success metrics**: How will users know it's working?

#### Business Perspective
- **ROI justification**: Business value vs. development cost
- **Market timing**: Competitive landscape and urgency
- **Scalability requirements**: Growth expectations and constraints
- **Compliance needs**: Legal, regulatory, or industry requirements

#### Technical Perspective
- **Architecture fit**: How this integrates with existing systems
- **Performance requirements**: Speed, scale, reliability needs
- **Security implications**: Data protection and access control
- **Maintenance burden**: Long-term operational costs

### Risk Assessment Protocol

#### Assumption Risk Levels
- **Critical**: Wrong assumption kills project (e.g., "Users will pay for this")
- **High**: Wrong assumption requires major rework (e.g., "API will be available")
- **Medium**: Wrong assumption causes delays (e.g., "Framework choice")
- **Low**: Wrong assumption causes minor fixes (e.g., "UI colors")

#### Question Selection Criteria
Only ask questions where ALL of these apply:
1. **High Impact**: Wrong answer significantly affects scope/cost/timeline
2. **Multiple Interpretations**: Reasonable people could disagree
3. **Limited Context**: Not enough information to choose wisely
4. **Testable Resolution**: Answer can be validated through research/discussion

#### Clarification Triggers
**Always clarify when:**
- Confidence score < 5 for any major component
- Multiple stakeholders disagree on core requirements
- Technical feasibility is uncertain
- Business value proposition is unclear
- Timeline assumptions are unrealistic

### Clarification Focus Areas

1. **Understanding** — Are we solving the right problem? Who benefits?
2. **Feasibility** — Do we have what we need? Any blockers?
3. **Scope** — What's MVP vs. nice-to-have? When do we stop?
4. **Risks** — What could derail us? What assumptions are risky?
5. **Dependencies** — What external factors matter? Who else is involved?

## Question Format & Prioritization

Ask **maximum 3 critical questions** (prioritize by impact):

### Question Structure Template
```markdown
## Question [N]: [Clear, Specific Question]

**Context**: [Quote relevant plan/spec section that led to this question]

**Why this matters**: [Specific impact if we get this wrong - be quantitative when possible]

**Assumptions Made**: [What we're currently assuming that this question challenges]

**Suggested Answers**:

| Option | Answer | Implications | Validation Method |
|--------|--------|--------------|-------------------|
| A      | [First reasonable answer] | [What this means for scope/timeline/cost] | [How to confirm this is correct] |
| B      | [Second reasonable answer] | [What this means for scope/timeline/cost] | [How to confirm this is correct] |
| C      | [Third reasonable answer] | [What this means for scope/timeline/cost] | [How to confirm this is correct] |
| Custom | Provide your own answer | [Explain how to provide custom input] | [How to validate custom answers] |

**Your choice**: _[Wait for user response]_
```

### Question Categories & Examples

#### Category 1: Scope & Requirements
**Example**: "How many users should the system support simultaneously?"
- **Impact**: Affects infrastructure costs by 3-5x, scalability architecture
- **Options**: 100 users (simple), 10K users (moderate), 100K+ users (complex)

#### Category 2: Technical Constraints
**Example**: "Which existing systems must this integrate with?"
- **Impact**: Determines API design, data models, deployment strategy
- **Options**: None (greenfield), 2-3 systems (moderate), 5+ systems (complex)

#### Category 3: Success Criteria
**Example**: "What does success look like for users?"
- **Impact**: Guides feature prioritization, acceptance criteria
- **Options**: Feature complete (deliverables), Problem solved (outcomes), Both (comprehensive)

### Question Sequencing Strategy
1. **Start with highest impact**: Scope, timeline, cost questions first
2. **Build on answers**: Use previous answers to inform next questions
3. **Validate assumptions**: Challenge key assumptions systematically
4. **Stop at confidence**: End when confidence reaches 7+ or impact drops significantly

## Response Format & Decision Framework

### Stakeholder Alignment Assessment
**Before providing recommendations, validate alignment:**

#### User Alignment ✅/❌
- [ ] Problem validation: Clear user need identified
- [ ] Value proposition: Benefits outweigh effort
- [ ] Success metrics: Measurable outcomes defined
- [ ] Usage context: Realistic usage scenarios

#### Business Alignment ✅/❌
- [ ] ROI justification: Value > cost analysis complete
- [ ] Market timing: Competitive positioning considered
- [ ] Scalability: Growth requirements accounted for
- [ ] Compliance: Legal/regulatory needs addressed

#### Technical Alignment ✅/❌
- [ ] Architecture fit: Integration points identified
- [ ] Performance: Requirements realistic and testable
- [ ] Security: Data protection needs considered
- [ ] Operations: Maintenance burden acceptable

### Risk Assessment Summary

#### Assumption Risk Register
| Assumption | Risk Level | Validation Plan | Owner | Status |
|------------|------------|----------------|--------|--------|
| [Key assumption from answers] | [Critical/High/Med/Low] | [How to validate] | [Who validates] | [Validated/Pending] |

#### Risk Mitigation Plan
| Risk | Probability | Impact | Mitigation Strategy | Contingency Plan |
|------|-------------|--------|-------------------|------------------|
| [Identified risk] | [High/Med/Low] | [Critical/High/Med/Low] | [Prevention strategy] | [Recovery plan] |

### Confidence Impact Analysis

#### Updated Confidence Scores
**Original confidence**: [Score]/10
**After clarification**: [New score]/10
**Delta**: [Change] (+/- points)

#### Confidence Rationale
- **Increased by**: [Specific answers that increased certainty]
- **Decreased by**: [New risks or constraints discovered]
- **Stabilizers**: [Factors that provide certainty despite unknowns]

### Decision Framework & Recommendations

#### Proceed Criteria (All must be true)
- [ ] Stakeholder alignment: All parties agree on scope and value
- [ ] Risk mitigation: High/critical risks have mitigation plans
- [ ] Confidence threshold: Overall confidence ≥ 7/10
- [ ] Validation plan: Critical assumptions have validation methods

#### Recommendation Options

**🟢 PROCEED** (High confidence, low risk)
- **Rationale**: [Why it's safe to proceed]
- **Next steps**: [Immediate actions to take]
- **Monitoring**: [What to watch for during execution]

**🟡 ADJUST PLAN** (Medium confidence, manageable risk)
- **Rationale**: [What needs to change before proceeding]
- **Adjustments needed**: [Specific plan modifications]
- **Additional validation**: [What else needs clarification]

**🔴 PAUSE & RESEARCH** (Low confidence, high risk)
- **Rationale**: [Why proceeding now is risky]
- **Research needed**: [What must be investigated]
- **Timeline impact**: [How long research will take]

**📋 FINAL DECISION**: [PROCEED/ADJUST/PAUSE]

### Action Items & Follow-up

#### Immediate Actions (Next 24 hours)
- [ ] [Action 1] - Owner: [Person] - Deadline: [When]
- [ ] [Action 2] - Owner: [Person] - Deadline: [When]

#### Validation Milestones (Next week)
- [ ] [Validation 1] - Method: [How] - Success Criteria: [What success looks like]
- [ ] [Validation 2] - Method: [How] - Success Criteria: [What success looks like]

#### Risk Monitoring Triggers
- [ ] Confidence drops below 6/10 → Trigger re-clarification
- [ ] New stakeholders identified → Validate alignment
- [ ] Technical constraints discovered → Reassess feasibility
- [ ] Business requirements change → Revalidate scope

## Advanced Clarification Rules & Best Practices

### When to Use Clarification (vs. Proceeding)
**ALWAYS clarify when:**
- Multiple stakeholders have conflicting requirements
- Technical feasibility is uncertain or unproven
- Business value proposition is unclear
- Success criteria are ambiguous or unmeasurable
- Timeline assumptions are unrealistic
- Risk level is high with inadequate mitigation

**PROCEED without clarification when:**
- Requirements are well-documented and agreed upon
- Technical approach is proven and documented
- Success metrics are clear and measurable
- All stakeholders are aligned
- Risk level is acceptable with existing mitigation

### Question Effectiveness Guidelines

#### Ask the Right Questions
- **Impact-focused**: Questions that could change scope/timeline/cost significantly
- **Decision-driving**: Questions that resolve real choice points
- **Assumption-testing**: Questions that validate key underlying assumptions
- **Risk-reducing**: Questions that identify and mitigate major risks

#### Avoid the Wrong Questions
- **Obvious answers**: Don't ask what you already know or can reasonably assume
- **Micro-details**: Don't get bogged down in implementation specifics
- **Endless loops**: Don't ask questions that lead to more questions indefinitely
- **Scope creep**: Don't expand the problem beyond the current initiative

### Stakeholder Management During Clarification

#### Managing Conflicting Priorities
- **Identify conflicts**: Surface disagreements early and explicitly
- **Find common ground**: Focus on shared goals and success criteria
- **Escalate strategically**: Involve decision-makers when needed
- **Document trade-offs**: Make opportunity costs visible

#### Building Consensus
- **Shared understanding**: Ensure all parties understand the trade-offs
- **Data-driven decisions**: Use facts and evidence to guide choices
- **Incremental agreement**: Build consensus step by step
- **Clear accountability**: Assign responsibility for final decisions

### Timing & Cadence Guidelines

#### Clarification Timing
- **Early is better**: Clarify before major work begins
- **Just-in-time**: Don't clarify too far in advance of need
- **Phase boundaries**: Use phase transitions for major clarifications
- **Confidence triggers**: Clarify when confidence drops significantly

#### Follow-up Cadence
- **Daily check-ins**: For high-risk, fast-moving projects
- **Weekly reviews**: For medium-risk projects with stable requirements
- **Milestone validation**: At major phase transitions
- **As-needed**: When new information or risks emerge

### Risk-Based Decision Making

#### Risk Tolerance Levels
- **Conservative**: Clarify everything with >5% risk of significant impact
- **Balanced**: Clarify issues with >10% risk of major rework
- **Aggressive**: Clarify only issues with >25% risk of project failure

#### Confidence-Based Thresholds
- **High confidence (8-10)**: Proceed with minimal clarification
- **Medium confidence (5-7)**: Clarify high-impact uncertainties
- **Low confidence (1-4)**: Comprehensive clarification required

### Common Clarification Anti-Patterns

#### Analysis Paralysis
- **Symptom**: Endless questioning without decisions
- **Prevention**: Set time limits, use decision frameworks
- **Recovery**: Force decisions with explicit risk acceptance

#### Scope Creep
- **Symptom**: Clarification expands project scope significantly
- **Prevention**: Anchor to original problem statement
- **Recovery**: Revisit project boundaries and constraints

#### Confirmation Bias
- **Symptom**: Questions designed to confirm existing assumptions
- **Prevention**: Actively seek contradictory information
- **Recovery**: Challenge assumptions systematically

### Key Rules Summary

## Agent-Specific Guidance & Smart Workflow Integration

### For Claude (Narrative Reasoning Agent)
**Strengths**: Stakeholder analysis, complex question formulation, comprehensive risk assessment
**Best for**: Initial clarification, stakeholder alignment, complex risk analysis
**Workflow optimization**:
- Formulate questions that reveal stakeholder dynamics and priorities
- Consider broader business and user context in clarifications
- Provide comprehensive analysis of clarification implications
- Maintain stakeholder alignment throughout the process

### For Cursor (IDE Integration Agent)
**Strengths**: Technical validation, code-level impact assessment, implementation feasibility
**Best for**: Technical clarification, code impact analysis, implementation validation
**Workflow optimization**:
- Validate technical assumptions with concrete code examples
- Assess implementation feasibility and complexity
- Provide immediate technical feedback on proposals
- Focus on practical, implementable solutions

### For Copilot (Code Generation Agent)
**Strengths**: Rapid validation, example generation, alternative exploration
**Best for**: Technical validation, generating examples, exploring alternatives
**Workflow optimization**:
- Generate concrete examples to validate assumptions
- Provide multiple implementation options quickly
- Test technical approaches with working prototypes
- Focus on practical, executable solutions

### For Gemini (Multi-modal Agent)
**Strengths**: Broad perspective analysis, creative problem solving, comprehensive validation
**Best for**: Comprehensive validation, edge case identification, creative alternatives
**Workflow optimization**:
- Consider multiple perspectives and edge cases
- Challenge assumptions from diverse angles
- Provide comprehensive analysis of alternatives
- Identify non-obvious implications and risks

### Smart Workflow Integration

#### Intelligent Question Generation
- **Impact analysis**: Automatically prioritize questions by potential impact
- **Stakeholder mapping**: Identify whose input is needed for each question
- **Dependency detection**: Flag questions that affect other clarification needs
- **Confidence optimization**: Suggest questions that will most improve certainty

#### Automated Clarification Triggers
- **Confidence monitoring**: Trigger clarification when confidence drops below thresholds
- **Risk escalation**: Automatically escalate high-impact uncertainties
- **Stakeholder conflict detection**: Flag when answers reveal conflicting priorities
- **Progress blocking**: Identify uncertainties that prevent forward progress

#### Decision Support Intelligence
- **Option analysis**: Evaluate clarification answers against project goals
- **Risk reassessment**: Update risk levels based on new information
- **Recommendation engine**: Suggest optimal paths based on answers received
- **Confidence recalibration**: Adjust confidence scores based on clarification outcomes

## Key Rules Summary

- **Curious** — Ask to understand, not to poke holes
- **Focused** — Ask about things that could really derail us
- **Practical** — Don't ask obvious questions
- **Help them think** — Questions should help them make better decisions
- **Know when to stop** — At some point we need to move
- **Risk-aware** — Focus on high-impact uncertainties
- **Stakeholder-aligned** — Ensure all voices are heard
- **Time-boxed** — Don't let clarification delay progress indefinitely
- **Agent-optimized** — Leverage your AI assistant's specific strengths
- **Decision-driven** — Frame questions to enable clear choices
