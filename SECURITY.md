# Security Policy

## Reporting Security Vulnerabilities

VibeCoder takes security seriously. If you discover a security vulnerability, please email security@vibekit.dev instead of using the public issue tracker.

**Do not open GitHub issues for security vulnerabilities.** Please disclose them responsibly by emailing the security team.

### Reporting Guidelines

When reporting a security issue, please include:

1. **Description** — What is the vulnerability?
2. **Impact** — How could it be exploited?
3. **Steps to Reproduce** — How can we verify it?
4. **Affected Versions** — Which versions are affected?
5. **Suggested Fix** — Do you have a fix?

We will:
- Acknowledge receipt within 48 hours
- Provide a timeline for the fix
- Credit you in the security advisory (unless you prefer anonymity)
- Release a patch version with a fix

## Security Best Practices

### For Users

1. **Keep VibeCoder Updated** — Run `vibe update` regularly
2. **Authenticate AI Agents** — Use official agent integrations only
3. **Review Generated Code** — Always review AI-generated code before committing
4. **Protect API Keys** — Never commit `.env` files or credentials
5. **Use Dev Containers** — Run VibeCoder in isolated dev containers when possible

### For Developers

1. **Dependency Updates** — Check for security updates in `pyproject.toml` dependencies
2. **Code Review** — All pull requests require review before merge
3. **No Hardcoded Secrets** — Never commit secrets or credentials
4. **HTTPS Only** — Use HTTPS for all network communication
5. **Input Validation** — Validate all user inputs and agent outputs

## Vulnerability Disclosure Timeline

- **Day 0** — Vulnerability reported
- **Day 1** — Acknowledgement and initial assessment
- **Day 7** — Security advisory drafted
- **Day 14** — Patch version released (target)
- **Day 21** — Public disclosure

Emergency vulnerabilities may be expedited.

## Security Dependencies

VibeCoder depends on these critical libraries. We monitor them for security updates:

- **Python** — Runtime environment
- **uv** — Package manager
- **Click** — CLI framework
- **YAML** — Configuration parsing

All dependencies are pinned in `pyproject.toml` and reviewed for security issues.

## Past Security Issues

Currently no known vulnerabilities. Please report any issues to the security team.

## Third-Party Security Audits

If you'd like to conduct a security audit of VibeCoder, please contact security@vibekit.dev first.

## Contact

- **Security Email** — security@vibekit.dev
- **GitHub Issues** — For non-security bugs only
- **Discussions** — For general questions
