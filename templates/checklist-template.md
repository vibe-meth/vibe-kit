# Quality Checklist Template

Use this to track quality criteria throughout phases. Referenced by `/vibekit.review`.

---

## Phase [#] Quality Checklist

### Code Quality
- [ ] Code follows team style guide
- [ ] No console.logs or debug statements
- [ ] Proper error handling
- [ ] No obvious performance issues
- [ ] Variables are descriptive

### Testing
- [ ] Unit tests written
- [ ] Happy path tested
- [ ] Edge cases covered
- [ ] Tests pass locally
- [ ] Test coverage > 80%

### Documentation
- [ ] README updated
- [ ] Code comments added for complex logic
- [ ] API documentation updated
- [ ] Architecture decisions logged
- [ ] Known issues documented

### Security
- [ ] No hardcoded secrets
- [ ] Input validation implemented
- [ ] SQL injection prevention (if applicable)
- [ ] CORS configured properly (if applicable)
- [ ] Rate limiting considered

### Performance
- [ ] Load times acceptable
- [ ] Database queries optimized
- [ ] No memory leaks
- [ ] Response times < threshold
- [ ] Caching implemented (if applicable)

### Integration
- [ ] Works with dependent systems
- [ ] API contracts honored
- [ ] No breaking changes
- [ ] Backward compatible (if applicable)
- [ ] Tested in staging environment

---

## Completion Criteria

**Phase Complete When:**
- [ ] All must-have items checked
- [ ] All tests passing
- [ ] Code reviewed and approved
- [ ] Documentation complete
- [ ] Ready for next phase

---

**Status**: [Started / In Progress / Complete]
**Confidence**: [X/10]
**Blockers**: [Any issues?]
