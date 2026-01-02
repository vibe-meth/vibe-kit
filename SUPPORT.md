# Support

Need help with VibeCoder? Here's where to find answers.

## Quick Help

### "How do I get started?"
→ See [Quick Start](./docs/quickstart.md)

### "How do I install VibeCoder?"
→ See [Installation Guide](./docs/installation.md)

### "What's the difference between VibeCoder and Spec-Kit?"
→ See [VibeCoder vs Spec-Kit](./docs/vibe-vs-spec.md)

### "How does confidence scoring work?"
→ See [VIBE_MEMORY.md](./VIBE_MEMORY.md#confidence-scoring)

### "What should I do when blocked?"
→ See [Vibe Guidelines](./memory/vibe-guidelines.md#blockers)

---

## Getting Help

### 📖 Documentation

- [README](./README.md) — Overview and features
- [Quick Start](./docs/quickstart.md) — Get started in 5 minutes
- [Installation Guide](./docs/installation.md) — Install VibeCoder
- [VIBE_MEMORY.md](./VIBE_MEMORY.md) — Core methodology
- [Vibe Guidelines](./memory/vibe-guidelines.md) — Development principles

### 💬 Discussions

Have a question? Start a discussion:
- Ideas and features
- Best practices
- Methodology questions
- General discussion

### 🐛 Report a Bug

Found a bug? Open an issue with:
- Clear description of the problem
- Steps to reproduce
- Your OS and Python version
- Expected vs actual behavior

### 💡 Suggest a Feature

Have an idea? Open an issue with:
- What problem you're solving
- Why it matters
- How you'd implement it

---

## Common Issues

### VibeCoder won't install

**Solution**: Check Python version:
```bash
python3 --version
# Should be 3.11 or higher
```

If Python is too old, upgrade it.

### AI agent CLI not found

**Solution**: Install the agent CLI:
```bash
# For Claude
npm install -g @anthropic-ai/claude-code@latest

# For Amp
npm install -g @amp/cli@latest

# Or use a different agent
vibe init . --ai <other-agent>
```

### Scripts not executable

**Solution**: Make scripts executable:
```bash
chmod +x scripts/bash/*.sh
chmod +x scripts/powershell/*.ps1
```

### Can't find plan.md or tasks.md

**Solution**: Generate them:
```bash
/vibekit.plan
/vibekit.tasks
```

---

## Community

We're a friendly community. Feel free to:
- Ask questions
- Share your workflow
- Suggest improvements
- Help others

---

## Contact

- 📧 Email: [contact info coming soon]
- 🐦 Twitter: [@VibeCoder](https://twitter.com)
- 💬 Discord: [Coming soon]

---

## FAQ

**Q: Is VibeCoder free?**
A: Yes! VibeCoder is open source under MIT license.

**Q: Can I use VibeCoder with my team?**
A: Yes! See [Vibe Guidelines — Team Coordination](./memory/vibe-guidelines.md#team-coordination)

**Q: Does VibeCoder work offline?**
A: The CLI works offline. Commands need an active AI assistant, which typically requires internet.

**Q: Can I export my plans and tasks?**
A: Yes! Everything is in markdown, so you can export, share, and version control easily.

**Q: Does VibeCoder require git?**
A: Git is optional, but recommended. VibeCoder works in non-git projects too.

**Q: Can I use VibeCoder with my favorite AI agent?**
A: VibeCoder supports 19+ AI agents. If your agent isn't listed, open an issue!

---

## Still Need Help?

1. **Check the docs** — Most answers are there
2. **Search issues** — Your question might be answered
3. **Ask in discussions** — We're happy to help
4. **Open an issue** — If it's a bug or feature request

---

**We're here to help. Don't hesitate to reach out!** 🎵
