# Installation Guide

Get VibeCoder installed and ready to use.

## Requirements

- **Python** 3.11 or higher
- **Git** (optional, but recommended)
- **uv** package manager ([install here](https://docs.astral.sh/uv/getting-started/))

## Option 1: Persistent Installation (Recommended)

Install VibeCoder globally so you can use it anywhere:

```bash
uv tool install vibe-cli --from git+https://github.com/vibekit/vibe-kit.git
```

Then use it directly:

```bash
vibe init my-project
vibe check
vibe version
```

### Upgrade

To upgrade to the latest version:

```bash
uv tool install vibe-cli --force --from git+https://github.com/vibekit/vibe-kit.git
```

Or:

```bash
uv tool upgrade vibe-cli
```

### Uninstall

```bash
uv tool uninstall vibe-cli
```

---

## Option 2: One-Time Usage

Run VibeCoder without installing (requires uv):

```bash
uvx --from git+https://github.com/vibekit/vibe-kit.git vibe init my-project
```

---

## Verify Installation

Check that VibeCoder is properly installed:

```bash
vibe check
```

This will verify:
- Python installation
- Git (if applicable)
- Your system environment

---

## Choose Your AI Agent

When you run `vibe init`, you'll specify which AI agent to use:

```bash
vibe init my-project --ai claude
vibe init my-project --ai amp
vibe init my-project --ai copilot
# ... or others
```

### Supported Agents

- **Claude Code** (`claude`) — Anthropic's Claude
- **Amp** (`amp`) — Amp CLI
- **GitHub Copilot** (`copilot`) — GitHub Copilot
- **Cursor** (`cursor-agent`) — Cursor IDE
- **Windsurf** (`windsurf`) — Windsurf IDE
- **Amazon Q Developer** (`q`) — Amazon Q
- **Gemini** (`gemini`) — Google Gemini
- And [15+ more](../README.md#-supported-ai-agents)

### Installing AI Agents

Most agents require CLI installation. VibeCoder will tell you if one is missing:

**Claude Code:**
```bash
npm install -g @anthropic-ai/claude-code@latest
```

**Amp:**
```bash
# Via npm
npm install -g @amp/cli@latest

# Or follow https://ampcode.com/manual#install
```

**Amazon Q Developer:**
```bash
# Follow https://aws.amazon.com/developer/learning/q-developer-cli/
```

Check the agent's documentation for other installation methods.

---

## Troubleshooting

### "vibe: command not found"

**Solution**: Make sure uv tool installation completed:

```bash
uv tool list
# Should show: vibe-cli
```

If not shown, try installing again:

```bash
uv tool install vibe-cli --from git+https://github.com/vibekit/vibe-kit.git
```

### "Python 3.11+ not found"

**Solution**: Install Python 3.11 or higher:

- macOS: `brew install python@3.11`
- Linux: `apt-get install python3.11`
- Windows: Download from [python.org](https://www.python.org/downloads/)

### "Git repository not detected"

VibeCoder works in non-git projects too. If you want git integration:

```bash
git init
git add .
git commit -m "Initial commit"
```

### Agent CLI not found

If your AI agent CLI isn't installed, VibeCoder will show an error. Install the agent or use a different one:

```bash
vibe init . --ai <agent-name>
```

---

## Next Steps

Once installed:

1. **Initialize your project**: `vibe init my-project`
2. **Read the Quick Start**: See [quickstart.md](./quickstart.md)
3. **Create your first plan**: `/vibekit.plan` in your AI assistant

Happy vibing! 🎵
