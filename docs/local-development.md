# Local Development

Set up a VibeCoder development environment.

## Prerequisites

- **Python** 3.11 or higher
- **Git**
- **uv** package manager ([install here](https://docs.astral.sh/uv/getting-started/))
- **Docker** (optional, for dev container)

## Clone the Repository

```bash
git clone https://github.com/vibe-meth/vibe-kit.git
cd vibe-kit
```

## Option 1: Dev Container (Recommended)

Dev containers include all dependencies pre-installed.

### In VS Code

1. Install the **Dev Containers** extension
2. Open the repository in VS Code
3. Click "Reopen in Container" when prompted
4. Wait for the container to build (2-5 minutes)

### In GitHub Codespaces

1. Click **Code** > **Codespaces** > **Create codespace on main**
2. Wait for the environment to build
3. Start developing

## Option 2: Local Setup

### Install Dependencies

```bash
uv sync
```

This installs all development dependencies including:
- `typer` — CLI framework
- `rich` — Terminal UI
- `pytest` — Testing
- `black` — Code formatting
- `ruff` — Linting

### Activate Virtual Environment

```bash
source .venv/bin/activate  # macOS/Linux
# or
.venv\Scripts\activate  # Windows
```

## Running VibeCoder Locally

### Test the CLI

```bash
# From the repo root
uvx --from ./src vibe --help
uvx --from ./src vibe version
```

### Initialize a Test Project

```bash
# Create a test project
uvx --from ./src vibe init test-project

# Initialize in current directory
uvx --from ./src vibe init . --ai claude
```

## Testing

```bash
# Run all tests
pytest

# Run with coverage
pytest --cov=src/vibe_cli

# Run specific test file
pytest tests/test_init.py
```

## Code Style

We use **Black** and **Ruff** for code formatting and linting.

### Format Code

```bash
black src/ tests/
```

### Lint Code

```bash
ruff check src/ tests/
```

### Type Check

```bash
mypy src/
```

## Making Changes

1. Create a feature branch: `git checkout -b feature/your-feature`
2. Make your changes
3. Run tests: `pytest`
4. Format code: `black src/`
5. Lint: `ruff check src/`
6. Commit: `git commit -m "Add your feature"`
7. Push: `git push origin feature/your-feature`
8. Open a Pull Request on GitHub

## Project Structure

```
vibe-kit/
├── src/vibe_cli/           # CLI source code
│   └── __init__.py         # Main CLI module
├── tests/                  # Test files
├── templates/              # Command templates
├── scripts/                # Setup and utility scripts
├── docs/                   # Documentation
├── memory/                 # VibeCoder guidelines
└── .devcontainer/          # Dev container config
```

## Common Tasks

### Add a New Command Template

1. Create `templates/commands/new-command.md`
2. Add metadata (description, scripts, handoffs)
3. Write the command logic
4. Test with: `uvx --from ./src vibe init . --ai claude`

### Update Documentation

1. Edit files in `docs/` or `memory/`
2. Check rendering: `markdownlint **/*.md`
3. Commit and push

### Add a New Script

1. Create bash version: `scripts/bash/my-script.sh`
2. Create PowerShell version: `scripts/powershell/my-script.ps1`
3. Make both executable
4. Test on your OS

## Troubleshooting

### uv not found

Install uv: `curl -LsSf https://astral.sh/uv/install.sh | sh`

### Import errors when running tests

Make sure you're in the virtual environment:
```bash
source .venv/bin/activate  # macOS/Linux
.venv\Scripts\activate     # Windows
```

### Dev container won't start

Try rebuilding:
```bash
# In VS Code command palette:
Dev Containers: Rebuild Container
```

### Tests fail locally but pass in CI

The CI uses a clean environment. Try:
```bash
rm -rf .venv
uv sync
pytest
```

## Getting Help

- **Documentation** — See [docs/](./docs/)
- **Issues** — Found a bug? [Report it](https://github.com/vibe-meth/vibe-kit/issues)
- **Discussions** — Have a question? [Ask here](https://github.com/vibe-meth/vibe-kit/discussions)

---

**Happy developing!** 🎵
