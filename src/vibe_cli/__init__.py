#!/usr/bin/env python3
# /// script
# requires-python = ">=3.11"
# dependencies = [
#     "typer",
#     "rich",
#     "platformdirs",
#     "readchar",
#     "httpx",
# ]
# ///
"""
VibeCoder CLI - AI workflow tool for vibe coders

Usage:
    uvx vibe-cli.py init <project-name>
    uvx vibe-cli.py init .
    uvx vibe-cli.py init --here

Or install globally:
    uv tool install --from vibe-cli.py vibe-cli
    vibe init <project-name>
    vibe init .
    vibe init --here
"""

import os
import subprocess
import sys
import zipfile
import tempfile
import shutil
import shlex
import json
from pathlib import Path
from typing import Optional, Tuple

import typer
import httpx
from rich.console import Console
from rich.panel import Panel
from rich.progress import Progress, SpinnerColumn, TextColumn
from rich.text import Text
from rich.live import Live
from rich.align import Align
from rich.table import Table
from rich.tree import Tree
from typer.core import TyperGroup

# For cross-platform keyboard input
import readchar
import ssl
import truststore
from datetime import datetime, timezone

ssl_context = truststore.SSLContext(ssl.PROTOCOL_TLS_CLIENT)
client = httpx.Client(verify=ssl_context)

def _github_token(cli_token: str | None = None) -> str | None:
    """Return sanitized GitHub token (cli arg takes precedence) or None."""
    return ((cli_token or os.getenv("GH_TOKEN") or os.getenv("GITHUB_TOKEN") or "").strip()) or None

def _github_auth_headers(cli_token: str | None = None) -> dict:
    """Return Authorization header dict only when a non-empty token exists."""
    token = _github_token(cli_token)
    return {"Authorization": f"Bearer {token}"} if token else {}

def _parse_rate_limit_headers(headers: httpx.Headers) -> dict:
    """Extract and parse GitHub rate-limit headers."""
    info = {}
    
    # Standard GitHub rate-limit headers
    if "X-RateLimit-Limit" in headers:
        info["limit"] = headers.get("X-RateLimit-Limit")
    if "X-RateLimit-Remaining" in headers:
        info["remaining"] = headers.get("X-RateLimit-Remaining")
    if "X-RateLimit-Reset" in headers:
        reset_epoch = int(headers.get("X-RateLimit-Reset", "0"))
        if reset_epoch:
            reset_time = datetime.fromtimestamp(reset_epoch, tz=timezone.utc)
            info["reset_epoch"] = reset_epoch
            info["reset_time"] = reset_time
            info["reset_local"] = reset_time.astimezone()
    
    # Retry-After header (seconds or HTTP-date)
    if "Retry-After" in headers:
        retry_after = headers.get("Retry-After")
        try:
            info["retry_after_seconds"] = int(retry_after)
        except ValueError:
            # HTTP-date format - not implemented, just store as string
            info["retry_after"] = retry_after
    
    return info

def _format_rate_limit_error(status_code: int, headers: httpx.Headers, url: str) -> str:
    """Format a user-friendly error message with rate-limit information."""
    rate_info = _parse_rate_limit_headers(headers)
    
    lines = [f"GitHub API returned status {status_code} for {url}"]
    lines.append("")
    
    if rate_info:
        lines.append("[bold]Rate Limit Information:[/bold]")
        if "limit" in rate_info:
            lines.append(f"  • Rate Limit: {rate_info['limit']} requests/hour")
        if "remaining" in rate_info:
            lines.append(f"  • Remaining: {rate_info['remaining']}")
        if "reset_local" in rate_info:
            reset_str = rate_info["reset_local"].strftime("%Y-%m-%d %H:%M:%S %Z")
            lines.append(f"  • Resets at: {reset_str}")
        if "retry_after_seconds" in rate_info:
            lines.append(f"  • Retry after: {rate_info['retry_after_seconds']} seconds")
        lines.append("")
    
    # Add troubleshooting guidance
    lines.append("[bold]Troubleshooting Tips:[/bold]")
    lines.append("  • If you're on a shared CI or corporate environment, you may be rate-limited.")
    lines.append("  • Consider using a GitHub token via --github-token or the GH_TOKEN/GITHUB_TOKEN")
    lines.append("    environment variable to increase rate limits.")
    lines.append("  • Authenticated requests have a limit of 5,000/hour vs 60/hour for unauthenticated.")
    
    return "\n".join(lines)

# Agent configuration with name, folder, install URL, and CLI tool requirement
AGENT_CONFIG = {
    "copilot": {
        "name": "GitHub Copilot",
        "folder": ".github/",
        "install_url": None,  # IDE-based, no CLI check needed
        "requires_cli": False,
    },
    "claude": {
        "name": "Claude Code",
        "folder": ".claude/",
        "install_url": "https://docs.anthropic.com/en/docs/claude-code/setup",
        "requires_cli": True,
    },
    "gemini": {
        "name": "Gemini CLI",
        "folder": ".gemini/",
        "install_url": "https://github.com/google-gemini/gemini-cli",
        "requires_cli": True,
    },
    "cursor-agent": {
        "name": "Cursor",
        "folder": ".cursor/",
        "install_url": None,  # IDE-based
        "requires_cli": False,
    },
    "qwen": {
        "name": "Qwen Code",
        "folder": ".qwen/",
        "install_url": "https://github.com/QwenLM/qwen-code",
        "requires_cli": True,
    },
    "opencode": {
        "name": "opencode",
        "folder": ".opencode/",
        "install_url": "https://opencode.ai",
        "requires_cli": True,
    },
    "codex": {
        "name": "Codex CLI",
        "folder": ".codex/",
        "install_url": "https://github.com/openai/codex",
        "requires_cli": True,
    },
    "windsurf": {
        "name": "Windsurf",
        "folder": ".windsurf/",
        "install_url": None,  # IDE-based
        "requires_cli": False,
    },
    "kilocode": {
        "name": "Kilo Code",
        "folder": ".kilocode/",
        "install_url": None,  # IDE-based
        "requires_cli": False,
    },
    "auggie": {
        "name": "Auggie CLI",
        "folder": ".augment/",
        "install_url": "https://docs.augmentcode.com/cli/setup-auggie/install-auggie-cli",
        "requires_cli": True,
    },
    "codebuddy": {
        "name": "CodeBuddy",
        "folder": ".codebuddy/",
        "install_url": "https://www.codebuddy.ai/cli",
        "requires_cli": True,
    },
    "qoder": {
        "name": "Qoder CLI",
        "folder": ".qoder/",
        "install_url": "https://qoder.com/cli",
        "requires_cli": True,
    },
    "roo": {
        "name": "Roo Code",
        "folder": ".roo/",
        "install_url": None,  # IDE-based
        "requires_cli": False,
    },
    "q": {
        "name": "Amazon Q Developer CLI",
        "folder": ".amazonq/",
        "install_url": "https://aws.amazon.com/developer/learning/q-developer-cli/",
        "requires_cli": True,
    },
    "amp": {
        "name": "Amp",
        "folder": ".agents/",
        "install_url": "https://ampcode.com/manual#install",
        "requires_cli": True,
    },
    "shai": {
        "name": "SHAI",
        "folder": ".shai/",
        "install_url": "https://github.com/ovh/shai",
        "requires_cli": True,
    },
    "bob": {
        "name": "IBM Bob",
        "folder": ".bob/",
        "install_url": None,  # IDE-based
        "requires_cli": False,
    },
}

SCRIPT_TYPE_CHOICES = {"sh": "POSIX Shell (bash/zsh)", "ps": "PowerShell"}

CLAUDE_LOCAL_PATH = Path.home() / ".claude" / "local" / "claude"

BANNER = """
██╗   ██╗██╗██████╗ ███████╗ ██████╗ ██████╗ ██████╗ ███████╗██████╗ 
██║   ██║██║██╔══██╗██╔════╝██╔════╝██╔════╝██╔═══██╗██╔════╝██╔══██╗
██║   ██║██║██████╔╝█████╗  ██║     ██║     ██║   ██║█████╗  ██████╔╝
╚██╗ ██╔╝██║██╔══██╗██╔══╝  ██║     ██║     ██║   ██║██╔══╝  ██╔══██╗
 ╚████╔╝ ██║██████╔╝███████╗╚██████╗╚██████╗╚██████╔╝███████╗██║  ██║
  ╚═══╝  ╚═╝╚═════╝ ╚══════╝ ╚═════╝ ╚═════╝ ╚═════╝ ╚══════╝╚═╝  ╚═╝
"""

TAGLINE = "VibeCoder - AI workflow tool for vibe coders"

console = Console()

class StepTracker:
    """Track and render hierarchical steps for VibeCoder initialization."""
    def __init__(self, title: str):
        self.title = title
        self.steps = {}
        self.order = []

    def add(self, step_id: str, label: str):
        """Add a step to track."""
        self.steps[step_id] = {"label": label, "status": "pending", "message": ""}
        self.order.append(step_id)

    def start(self, step_id: str):
        """Mark a step as in progress."""
        if step_id in self.steps:
            self.steps[step_id]["status"] = "in_progress"

    def complete(self, step_id: str, message: str = ""):
        """Mark a step as complete."""
        if step_id in self.steps:
            self.steps[step_id]["status"] = "complete"
            self.steps[step_id]["message"] = message

    def error(self, step_id: str, message: str = ""):
        """Mark a step as errored."""
        if step_id in self.steps:
            self.steps[step_id]["status"] = "error"
            self.steps[step_id]["message"] = message

    def skip(self, step_id: str, message: str = ""):
        """Mark a step as skipped."""
        if step_id in self.steps:
            self.steps[step_id]["status"] = "skip"
            self.steps[step_id]["message"] = message

    def render(self) -> Panel:
        """Render the tracker as a Panel."""
        lines = []
        for step_id in self.order:
            step = self.steps[step_id]
            label = step["label"]
            status = step["status"]
            message = step["message"]
            
            if status == "complete":
                symbol = "✓"
                style = "green"
            elif status == "in_progress":
                symbol = "◐"
                style = "yellow"
            elif status == "error":
                symbol = "✗"
                style = "red"
            elif status == "skip":
                symbol = "⊘"
                style = "dim"
            else:
                symbol = "○"
                style = "dim"
            
            msg = f" ({message})" if message else ""
            lines.append(f"[{style}]{symbol}[/{style}] {label}{msg}")
        
        return Panel("\n".join(lines), title=self.title, border_style="cyan", padding=(1, 2))

    def attach_refresh(self, callback):
        """Attach a refresh callback (for Live updates)."""
        self.refresh_callback = callback

def get_key() -> str:
    """Get keyboard input (arrow keys, enter, escape)."""
    key = readchar.readchar()
    if key == '\x1b':  # Escape sequence
        next_char = readchar.readchar()
        if next_char == '[':
            direction = readchar.readchar()
            if direction == 'A': return 'up'
            if direction == 'B': return 'down'
        return 'escape'
    if key in ('\r', '\n'): return 'enter'
    if key == '\x1b': return 'escape'
    return key

def select_with_arrows(options: dict, prompt_text: str = "Select an option", default_key: str = None) -> str:
    """
    Interactive selection using arrow keys with Rich Live display.
    
    Args:
        options: Dict with keys as option keys and values as descriptions
        prompt_text: Text to show above the options
        default_key: Default option key to start with
        
    Returns:
        Selected option key
    """
    option_keys = list(options.keys())
    if default_key and default_key in option_keys:
        selected_index = option_keys.index(default_key)
    else:
        selected_index = 0

    selected_key = None

    def create_selection_panel():
        """Create the selection panel with current selection highlighted."""
        table = Table.grid(padding=(0, 2))
        table.add_column(style="cyan", justify="left", width=3)
        table.add_column(style="white", justify="left")

        for i, key in enumerate(option_keys):
            if i == selected_index:
                table.add_row("▶", f"[cyan]{key}[/cyan] [dim]({options[key]})[/dim]")
            else:
                table.add_row(" ", f"[cyan]{key}[/cyan] [dim]({options[key]})[/dim]")

        table.add_row("", "")
        table.add_row("", "[dim]Use ↑/↓ to navigate, Enter to select, Esc to cancel[/dim]")

        return Panel(
            table,
            title=f"[bold]{prompt_text}[/bold]",
            border_style="cyan",
            padding=(1, 2)
        )

    console.print()

    def run_selection_loop():
        nonlocal selected_key, selected_index
        with Live(create_selection_panel(), console=console, transient=True, auto_refresh=False) as live:
            while True:
                try:
                    key = get_key()
                    if key == 'up':
                        selected_index = (selected_index - 1) % len(option_keys)
                    elif key == 'down':
                        selected_index = (selected_index + 1) % len(option_keys)
                    elif key == 'enter':
                        selected_key = option_keys[selected_index]
                        break
                    elif key == 'escape':
                        console.print("\n[yellow]Selection cancelled[/yellow]")
                        raise typer.Exit(1)

                    live.update(create_selection_panel(), refresh=True)

                except KeyboardInterrupt:
                    console.print("\n[yellow]Selection cancelled[/yellow]")
                    raise typer.Exit(1)

    run_selection_loop()

    if selected_key is None:
        console.print("\n[red]Selection failed.[/red]")
        raise typer.Exit(1)

    return selected_key

def show_banner():
    """Display the VibeCoder banner."""
    console.print(BANNER)
    console.print(f"[cyan]{TAGLINE}[/cyan]\n")

def check_tool(tool: str, install_url: str = None, tracker: StepTracker = None) -> bool:
    """Check if a tool is installed."""
    result = shutil.which(tool) is not None
    if tracker:
        if result:
            tracker.complete(tool, "found")
        else:
            if install_url:
                tracker.error(tool, f"not found - install from {install_url}")
            else:
                tracker.error(tool, "not found")
    return result

def is_git_repo(path: Path) -> bool:
    """Check if path is a git repository."""
    return (path / ".git").exists()

def init_git_repo(path: Path, quiet: bool = False) -> Tuple[bool, str]:
    """Initialize a git repository."""
    try:
        subprocess.run(["git", "init"], cwd=path, capture_output=quiet, check=True)
        return True, ""
    except subprocess.CalledProcessError as e:
        return False, str(e)

def ensure_executable_scripts(project_path: Path, tracker: StepTracker = None):
    """Ensure all shell scripts are executable."""
    for script_path in project_path.glob(".agents/scripts/bash/*.sh"):
        script_path.chmod(0o755)

app = typer.Typer()

@app.command()
def init(
    project_name: Optional[str] = typer.Argument(None, help="Project name or directory"),
    ai: Optional[str] = typer.Option(None, "--ai", help="AI agent: claude, gemini, copilot, cursor-agent, q, amp, or other"),
    script: Optional[str] = typer.Option(None, "--script", help="Script type: sh or ps"),
    here: bool = typer.Option(False, "--here", help="Initialize in current directory"),
    no_git: bool = typer.Option(False, "--no-git", help="Skip git initialization"),
    skip_tls: bool = typer.Option(False, "--skip-tls", help="Skip TLS verification"),
    debug: bool = typer.Option(False, "--debug", help="Enable debug output"),
    verbose: bool = typer.Option(False, "--verbose", help="Enable verbose output"),
    github_token: Optional[str] = typer.Option(None, "--github-token", help="GitHub token for API access"),
):
    """Initialize a new VibeCoder project."""
    show_banner()
    
    if not project_name and not here:
        console.print("[red]Error: Provide a project name or use --here[/red]")
        raise typer.Exit(1)
    
    project_path = Path(".") if here else Path(project_name)
    
    # Validate and select AI agent
    if ai:
        if ai not in AGENT_CONFIG:
            console.print(f"[red]Error:[/red] Invalid AI agent '{ai}'. Choose from: {', '.join(AGENT_CONFIG.keys())}")
            raise typer.Exit(1)
        selected_ai = ai
    else:
        # Interactive selection for AI agent
        ai_choices = {key: config["name"] for key, config in AGENT_CONFIG.items()}
        selected_ai = select_with_arrows(ai_choices, "Choose your AI assistant:", "claude")
    
    # Validate and select script type
    if script:
        if script not in SCRIPT_TYPE_CHOICES:
            console.print(f"[red]Error:[/red] Invalid script type '{script}'. Choose from: {', '.join(SCRIPT_TYPE_CHOICES.keys())}")
            raise typer.Exit(1)
        selected_script = script
    else:
        # Interactive selection for script type with smart default
        default_script = "ps" if os.name == "nt" else "sh"
        
        if sys.stdin.isatty():
            selected_script = select_with_arrows(SCRIPT_TYPE_CHOICES, "Choose script type:", default_script)
        else:
            selected_script = default_script
    
    console.print(f"[cyan]Selected AI agent:[/cyan] {selected_ai}")
    console.print(f"[cyan]Selected script type:[/cyan] {selected_script}")
    
    console.print(f"[cyan]Initializing VibeCoder project at {project_path}[/cyan]\n")
    
    # Create tracker
    tracker = StepTracker("VibeCoder Initialization")
    tracker.add("download", "Downloading template")
    tracker.add("structure", "Setting up structure")
    tracker.add("permissions", "Setting permissions")
    tracker.add("git", "Initializing git")
    tracker.add("final", "Finalizing")
    
    with Live(tracker.render(), console=console, refresh_per_second=8, transient=True) as live:
        try:
            tracker.start("download")
            tracker.complete("download", "template ready")
            
            tracker.start("structure")
            project_path.mkdir(parents=True, exist_ok=True)
            tracker.complete("structure", "created")
            
            tracker.start("permissions")
            ensure_executable_scripts(project_path, tracker=tracker)
            tracker.complete("permissions", "set")
            
            should_init_git = check_tool("git")
            if not no_git and should_init_git:
                tracker.start("git")
                if is_git_repo(project_path):
                    tracker.complete("git", "existing repo")
                else:
                    success, error_msg = init_git_repo(project_path, quiet=True)
                    if success:
                        tracker.complete("git", "initialized")
                    else:
                        tracker.error("git", "init failed")
            elif no_git:
                tracker.skip("git", "--no-git flag")
            else:
                tracker.skip("git", "git not installed")
            
            tracker.complete("final", "project ready")
        except Exception as e:
            tracker.error("final", str(e))
            console.print(Panel(f"Initialization failed: {e}", title="Failure", border_style="red"))
            raise typer.Exit(1)
    
    console.print(tracker.render())
    console.print("\n[bold green]VibeCoder project ready.[/bold green]")
    
    steps_panel = Panel(
        "1. Start vibing with your AI agent:\n"
        "   • /vibekit.plan - Create your plan\n"
        "   • /vibekit.tasks - Generate tasks\n"
        "   • /vibekit.execute - Execute implementation\n"
        "   • /vibekit.insight - Get insights\n"
        "   • /vibekit.review - Review progress",
        title="Next Steps",
        border_style="cyan",
        padding=(1, 2)
    )
    console.print()
    console.print(steps_panel)

@app.command()
def check():
    """Check that all required tools are installed."""
    show_banner()
    console.print("[bold]Checking for installed tools...[/bold]\n")
    
    tracker = StepTracker("Check Available Tools")
    
    tracker.add("git", "Git version control")
    git_ok = check_tool("git", tracker=tracker)
    
    agent_results = {}
    for agent_key, agent_config in AGENT_CONFIG.items():
        agent_name = agent_config["name"]
        requires_cli = agent_config["requires_cli"]
        
        tracker.add(agent_key, agent_name)
        
        if requires_cli:
            agent_results[agent_key] = check_tool(agent_key, tracker=tracker)
        else:
            tracker.skip(agent_key, "IDE-based")
            agent_results[agent_key] = False
    
    console.print(tracker.render())
    console.print("\n[bold green]VibeCoder is ready to use![/bold green]")

@app.command()
def version():
    """Display version and system information."""
    import platform
    import importlib.metadata
    
    show_banner()
    
    cli_version = "0.1.0"
    try:
        cli_version = importlib.metadata.version("vibe-cli")
    except Exception:
        pass
    
    info_table = Table(show_header=False, box=None, padding=(0, 2))
    info_table.add_column("Key", style="cyan", justify="right")
    info_table.add_column("Value", style="white")
    
    info_table.add_row("CLI Version", cli_version)
    info_table.add_row("Python", platform.python_version())
    info_table.add_row("Platform", platform.system())
    info_table.add_row("Architecture", platform.machine())
    
    panel = Panel(
        info_table,
        title="[bold cyan]VibeCoder Information[/bold cyan]",
        border_style="cyan",
        padding=(1, 2)
    )
    
    console.print(panel)

def main():
    app()

if __name__ == "__main__":
    main()
