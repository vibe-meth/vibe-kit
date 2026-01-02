# AGENTS.md

## About VibeCoder and VibeCoder CLI

**VibeCoder** is a flow-first toolkit for developers who use AI to code faster. It provides a 3-step workflow (plan, tasks, execute) that keeps you and your AI assistant in sync, with confidence-based shipping instead of exhaustive specs.

**VibeCoder CLI** is the command-line interface that bootstraps VibeCoder projects. It sets up the necessary directory structures, command templates, and AI agent integrations to support the Vibe-Driven Development workflow.

The toolkit supports 19+ AI coding assistants, allowing developers to use their preferred tools while maintaining consistent project structure and vibe-driven practices.

---

## General Practices

- Any changes to `src/vibe_cli/__init__.py` for the VibeCoder CLI require:
  - Version bump in `pyproject.toml`
  - Entry in `CHANGELOG.md`
  - Update to `AGENTS.md` if agent support changed

---

## Adding New Agent Support

This section explains how to add support for new AI agents/assistants to the VibeCoder CLI. Use this guide as a reference when integrating new AI tools into the Vibe-Driven Development workflow.

### Overview

VibeCoder supports multiple AI agents by generating agent-specific command files and directory structures when initializing projects. Each agent has its own conventions for:

- **Command file formats** (Markdown, TOML, etc.)
- **Directory structures** (`.claude/commands/`, `.windsurf/workflows/`, etc.)
- **Command invocation patterns** (slash commands, CLI tools, etc.)
- **Argument passing conventions** (`$ARGUMENTS`, `{{args}}`, etc.)

### Current Supported Agents

| Agent                      | Directory              | Format   | CLI Tool        | Requires CLI | Description                 |
| -------------------------- | ---------------------- | -------- | --------------- | ------------ | --------------------------- |
| **Claude Code**            | `.claude/commands/`    | Markdown | `claude`        | Yes          | Anthropic's Claude Code CLI |
| **Gemini CLI**             | `.gemini/commands/`    | TOML     | `gemini`        | Yes          | Google's Gemini CLI         |
| **GitHub Copilot**         | `.github/agents/`      | Markdown | N/A             | No           | GitHub Copilot in VS Code   |
| **Cursor**                 | `.cursor/commands/`    | Markdown | `cursor-agent`  | No           | Cursor IDE                  |
| **Qwen Code**              | `.qwen/commands/`      | TOML     | `qwen`          | Yes          | Alibaba's Qwen Code CLI     |
| **opencode**               | `.opencode/commands/`  | Markdown | `opencode`      | Yes          | opencode CLI                |
| **Codex CLI**              | `.codex/commands/`     | Markdown | `codex`         | Yes          | OpenAI Codex CLI            |
| **Windsurf**               | `.windsurf/workflows/` | Markdown | N/A             | No           | Windsurf IDE                |
| **Kilo Code**              | `.kilocode/rules/`     | Markdown | N/A             | No           | Kilo Code IDE               |
| **Auggie CLI**             | `.augment/rules/`      | Markdown | `auggie`        | Yes          | Augmented development       |
| **Roo Code**               | `.roo/rules/`          | Markdown | N/A             | No           | Roo Code IDE                |
| **CodeBuddy CLI**          | `.codebuddy/commands/` | Markdown | `codebuddy`     | Yes          | CodeBuddy CLI               |
| **Qoder CLI**              | `.qoder/commands/`     | Markdown | `qoder`         | Yes          | Qoder CLI                   |
| **Amazon Q Developer**     | `.amazonq/prompts/`    | Markdown | `q`             | Yes          | AWS Q Developer CLI         |
| **Amp**                    | `.agents/commands/`    | Markdown | `amp`           | Yes          | Amp CLI                     |
| **SHAI**                   | `.shai/commands/`      | Markdown | `shai`          | Yes          | SHAI CLI                    |
| **IBM Bob**                | `.bob/commands/`       | Markdown | N/A             | No           | IBM Bob IDE                 |

---

## Step-by-Step Integration Guide

Follow these steps to add a new agent (using a hypothetical new agent as an example):

### 1. Add to AGENT_CONFIG

**IMPORTANT**: Use the actual CLI tool name as the key, not a shortened version.

Add the new agent to the `AGENT_CONFIG` dictionary in `src/vibe_cli/__init__.py`. This is the **single source of truth** for all agent metadata:

```python
AGENT_CONFIG = {
    # ... existing agents ...
    "new-agent-cli": {  # Use the ACTUAL CLI tool name (what users type in terminal)
        "name": "New Agent Display Name",
        "folder": ".newagent/",  # Directory for agent files
        "install_url": "https://example.com/install",  # URL for installation docs (or None if IDE-based)
        "requires_cli": True,  # True if CLI tool required, False for IDE-based agents
    },
}
```

**Key Design Principle**: The dictionary key should match the actual executable name that users install. For example:

- ✅ Use `"cursor-agent"` because the CLI tool is literally called `cursor-agent`
- ❌ Don't use `"cursor"` as a shortcut if the tool is `cursor-agent`

This eliminates the need for special-case mappings throughout the codebase.

**Field Explanations**:

- `name`: Human-readable display name shown to users
- `folder`: Directory where agent-specific files are stored (relative to project root)
- `install_url`: Installation documentation URL (set to `None` for IDE-based agents)
- `requires_cli`: Whether the agent requires a CLI tool check during initialization

### 2. Update CLI Help Text

Update the `--ai` parameter help text in the `init()` command to include the new agent:

```python
ai: Optional[str] = typer.Option(None, "--ai", help="AI agent: claude, gemini, copilot, cursor-agent, qwen, opencode, codex, windsurf, kilocode, auggie, codebuddy, new-agent-cli, q, or amp"),
```

Also update any function docstrings, examples, and error messages that list available agents.

### 3. Update README Documentation

Update the **Supported AI Agents** section in `README.md` to include the new agent:

- Add the new agent to the quick reference section
- Include the agent's official website/documentation link
- Add any relevant notes about the agent's implementation
- Ensure the information remains accurate and helpful

### 4. Update This Documentation

Add the new agent to:
- **Current Supported Agents table** (above)
- **Agent Categories** section (below)
- **Troubleshooting** section (if agent-specific issues are known)

### 5. Update Devcontainer Files (Optional)

For agents that have VS Code extensions or require CLI installation, update the devcontainer configuration files:

#### VS Code Extension-based Agents

For agents available as VS Code extensions, add them to `.devcontainer/devcontainer.json`:

```json
{
  "customizations": {
    "vscode": {
      "extensions": [
        // ... existing extensions ...
        // [New Agent Name]
        "[New Agent Extension ID]"
      ]
    }
  }
}
```

#### CLI-based Agents

For agents that require CLI tools, add installation commands to `.devcontainer/post-create.sh`:

```bash
#!/bin/bash

# Existing installations...

echo -e "\nInstalling [New Agent Name] CLI..."
run_command "npm install -g [agent-cli-package]@latest" # Example for node-based CLI
# or other installation instructions (must be non-interactive and compatible with Linux Debian)...
echo "✅ Done"
```

**Quick Tips:**

- **Extension-based agents**: Add to the `extensions` array in `devcontainer.json`
- **CLI-based agents**: Add installation scripts to `post-create.sh`
- **Hybrid agents**: May require both extension and CLI installation
- **Test thoroughly**: Ensure installations work in the devcontainer environment

---

## Important Design Decisions

### Using Actual CLI Tool Names as Keys

**CRITICAL**: When adding a new agent to AGENT_CONFIG, always use the **actual executable name** as the dictionary key, not a shortened or convenient version.

**Why this matters:**

- The `check_tool()` function uses `shutil.which(tool)` to find executables in the system PATH
- If the key doesn't match the actual CLI tool name, you'll need special-case mappings throughout the codebase
- This creates unnecessary complexity and maintenance burden

**Example - The Cursor Lesson:**

❌ **Wrong approach** (requires special-case mapping):

```python
AGENT_CONFIG = {
    "cursor": {  # Shorthand that doesn't match the actual tool
        "name": "Cursor",
        # ...
    }
}

# Then you need special cases everywhere:
cli_tool = agent_key
if agent_key == "cursor":
    cli_tool = "cursor-agent"  # Map to the real tool name
```

✅ **Correct approach** (no mapping needed):

```python
AGENT_CONFIG = {
    "cursor-agent": {  # Matches the actual executable name
        "name": "Cursor",
        # ...
    }
}

# No special cases needed - just use agent_key directly!
```

**Benefits of this approach:**

- Eliminates special-case logic scattered throughout the codebase
- Makes the code more maintainable and easier to understand
- Reduces the chance of bugs when adding new agents
- Tool checking "just works" without additional mappings

---

## Agent Categories

### CLI-Based Agents

Require a command-line tool to be installed:

- **Claude Code**: `claude` CLI
- **Gemini CLI**: `gemini` CLI
- **Cursor**: `cursor-agent` CLI
- **Qwen Code**: `qwen` CLI
- **opencode**: `opencode` CLI
- **Amazon Q Developer**: `q` CLI
- **CodeBuddy CLI**: `codebuddy` CLI
- **Qoder CLI**: `qoder` CLI
- **Codex CLI**: `codex` CLI
- **Auggie CLI**: `auggie` CLI
- **Amp**: `amp` CLI
- **SHAI**: `shai` CLI

### IDE-Based Agents

Work within integrated development environments (no CLI tool required):

- **GitHub Copilot**: Built into VS Code
- **Cursor**: Standalone IDE
- **Windsurf**: Standalone IDE
- **Roo Code**: Browser-based
- **Kilo Code**: IDE integration
- **IBM Bob**: IBM IDE

---

## Command File Formats

VibeCoder templates use Markdown format with YAML frontmatter metadata:

```markdown
---
description: "Command description"
scripts:
  sh: scripts/bash/setup-vibe.sh --json
  ps: scripts/powershell/setup-vibe.ps1 -Json
agent_scripts:
  sh: scripts/bash/update-agent-context.sh __AGENT__
  ps: scripts/powershell/update-agent-context.ps1 -AgentType __AGENT__
handoffs:
  - label: Next Command
    agent: vibekit.next-command
    prompt: Description of what happens next
    send: true
---

Command content with {SCRIPT} and $ARGUMENTS placeholders.
```

**Key metadata fields:**

- `description`: What this command does
- `scripts`: Shell scripts for setup (sh for Bash, ps for PowerShell)
- `agent_scripts`: Scripts to sync agent context
- `handoffs`: Next commands to suggest (for multi-step workflows)

---

## Quick Setup by Agent

### Using Claude Code

```bash
vibe init my-project --ai claude
```

Then in Claude:
```
/vibekit.plan
/vibekit.tasks
/vibekit.execute
```

### Using Cursor

```bash
vibe init my-project --ai cursor-agent
```

Templates auto-load in Cursor's command palette. Use:
```
/vibekit.plan → /vibekit.tasks → /vibekit.execute
```

### Using GitHub Copilot

```bash
vibe init . --ai copilot
```

In VS Code Copilot chat:
```
/vibekit.plan
/vibekit.tasks
/vibekit.execute
```

### Using Amp

```bash
vibe init my-project --ai amp
amp
```

In Amp:
```
/vibekit.plan
/vibekit.tasks
/vibekit.execute
```

---

## Best Practices by Agent

### For Fast Planning
- **Claude Code** — Best narrative structure and phase breakdown
- **Cursor** — Excellent IDE integration and visual feedback
- **Amp** — Best for dependency analysis

### For Task Generation
- **Amp** — Excellent dependency analysis and ordering
- **Claude Code** — Clear hierarchical task structure
- **Cursor** — Visual tree view of work breakdown

### For Execution Tracking
All agents support confidence scoring and blocker logging equally well.

---

## Troubleshooting

### Agent Not Recognized

```bash
vibe check
```

Verify your agent is installed and in PATH.

### CLI Tool Not Found

If you get an error like "`claude` not found":

```bash
# Install the agent CLI
npm install -g @anthropic-ai/claude-code@latest

# Or verify installation
which claude
```

### Templates Not Loading

Ensure VibeCoder is properly initialized:

```bash
vibe init . --ai <agent-name>
ls .vibekit/config.json  # Should exist
```

### Interactive Selection Not Working

If interactive menus don't appear:
- Check that your terminal supports TTY mode
- Use flags instead: `vibe init . --ai claude --script sh`

---

## Testing New Agent Integration

When adding a new agent, test:

1. **CLI integration**: `vibe init --ai <new-agent>`
2. **Interactive selection**: Choose agent from menu
3. **File generation**: Verify correct directory structure
4. **Command loading**: Ensure agent can load `/vibekit.plan` command
5. **Execution**: Run full workflow (plan → tasks → execute)
6. **Devcontainer**: If added, test in dev container

---

## Common Pitfalls

1. **Using shorthand keys**: Always use actual CLI tool names as AGENT_CONFIG keys (e.g., `"cursor-agent"` not `"cursor"`).
2. **Wrong `requires_cli` value**: Set to `True` only for CLI tools; `False` for IDE-based agents.
3. **Inconsistent documentation**: Update README, AGENTS.md, and help text together.
4. **Missing devcontainer setup**: Add installation commands if adding a new CLI agent.
5. **Incorrect install URLs**: Verify URLs point to actual installation documentation.
6. **Forgetting CHANGELOG entry**: Always document new agent support in CHANGELOG.md.

---

## Future Considerations

When adding new agents:

- Consider the agent's native command/workflow patterns
- Ensure compatibility with Vibe-Driven Development process
- Document any special requirements or limitations
- Update this guide with lessons learned
- Verify the actual CLI tool name before adding to AGENT_CONFIG
- Test in both interactive and CI/CD (non-interactive) environments

---

## Support

- [Documentation](./docs/)
- [Report Issues](https://github.com/vibe-meth/vibe-kit/issues)
- [Discussions](https://github.com/vibe-meth/vibe-kit/discussions)

---

*This documentation should be updated whenever new agents are added to maintain accuracy and completeness.*
