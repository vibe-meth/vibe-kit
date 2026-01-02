# Upgrade Guide

Keep VibeCoder up to date with the latest features and bug fixes.

## Check Your Version

```bash
vibe version
```

## Upgrade from Older Versions

### From 0.1.0 to 0.2.0+

VibeCoder follows semantic versioning:
- **Patch** (0.1.X) — Bug fixes, no breaking changes
- **Minor** (0.X.0) — New features, backward compatible
- **Major** (X.0.0) — Breaking changes (rare)

Most upgrades are safe and automatic.

## Update Methods

### Method 1: uv tool upgrade (Recommended)

```bash
uv tool upgrade vibe-cli
```

This upgrades to the latest version automatically.

### Method 2: Force reinstall

```bash
uv tool install vibe-cli --force --from git+https://github.com/vibe-meth/vibe-kit.git
```

### Method 3: One-time latest version

```bash
uvx --from git+https://github.com/vibe-meth/vibe-kit.git vibe version
```

## What's Included in Each Release

See [CHANGELOG.md](../CHANGELOG.md) for:
- ✨ New features
- 🐛 Bug fixes
- 🔄 Breaking changes
- 📚 Documentation updates

## Troubleshooting Upgrades

### "Command not found" after upgrade

Try reinstalling:

```bash
uv tool uninstall vibe-cli
uv tool install vibe-cli --from git+https://github.com/vibe-meth/vibe-kit.git
```

### Old command still runs

Your shell may have cached the old version:

```bash
hash -r  # Clear bash cache
```

### Compatibility issues

Ensure your Python version is supported:

```bash
python3 --version
# Should be 3.11 or higher
```

If you're on Python 3.10 or lower, upgrade Python first.

## Beta Versions

To try unreleased features:

```bash
uv tool install vibe-cli --from git+https://github.com/vibe-meth/vibe-kit.git@develop
```

> ⚠️ Beta versions may have bugs. Use at your own risk.

## Rollback to Previous Version

If you need to downgrade:

```bash
# Uninstall current version
uv tool uninstall vibe-cli

# Install specific version (if available on PyPI)
uv tool install vibe-cli==0.1.0
```

## Breaking Changes

Breaking changes only happen in major versions (X.0.0). When they occur:

1. **Announcement** — Posted in [CHANGELOG.md](../CHANGELOG.md)
2. **Migration Guide** — Instructions provided in release notes
3. **Grace Period** — Old version still available for 30 days

## Stay Updated

### Subscribe to Releases

On GitHub:
1. Click **Watch** on the [repo](https://github.com/vibe-meth/vibe-kit)
2. Select **Custom** > **Releases**
3. Get notified of new versions

### Check for Updates

```bash
# Check installed version
vibe version

# Compare with latest
# (Coming soon: vibe update --check)
```

## Support

- **Issues** — [Report problems](https://github.com/vibe-meth/vibe-kit/issues)
- **Discussions** — [Ask questions](https://github.com/vibe-meth/vibe-kit/discussions)
- **Docs** — [Read the guide](./index.md)

---

**Keep VibeCoder up to date for the best experience!** 🎵
