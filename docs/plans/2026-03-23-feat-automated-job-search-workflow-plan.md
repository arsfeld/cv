---
title: "feat: Automated Job Search Workflow"
type: feat
status: completed
date: 2026-03-23
origin: docs/brainstorms/2026-03-23-job-search-workflow-brainstorm.md
---

# feat: Automated Job Search Workflow

## Overview

Create a `/job-search` Claude Code skill that automates the entire job discovery pipeline — from searching multiple platforms to delivering a scored, deduplicated CSV of matching positions. Zero input required; the skill reads the user's resume and runs end-to-end.

This replaces the manual copy-paste workflow of the existing `/job-search-dorks` skill (which is kept as a lightweight fallback) with full automation: search, fetch, score, and export.

## Problem Statement / Motivation

The current `/job-search-dorks` skill generates Google search queries but stops there. The user must manually:
- Copy-paste dorks into a browser
- Click through dozens of results across 23 platforms
- Mentally filter relevant positions
- Track findings somewhere

The core value of Claude Code is automation. The skill should do the work, not generate instructions for the user to do the work. (see brainstorm: `docs/brainstorms/2026-03-23-job-search-workflow-brainstorm.md`)

## Proposed Solution

A single skill (`/job-search`) that:

1. **Reads the resume** — Parses `metadata.toml`, `modules_en/professional.typ`, `modules_en/skills.typ`, `modules_en/education.typ` to extract profile
2. **Searches in parallel** — Launches multiple agents, each targeting a different platform via WebSearch
3. **Extracts listings** — Each agent uses WebFetch to parse job listing pages (with fallback to search snippets for JS-heavy pages)
4. **Scores against resume** — Rates each listing 1-5 using a defined rubric
5. **Deduplicates and ranks** — Merges results, removes duplicates by normalized company+title
6. **Outputs CSV + terminal summary** — Writes `output/jobs-YYYY-MM-DD-HHMMSS.csv` and prints a top-10 summary

### Architecture

```
/job-search (orchestrator)
    │
    ├── Read resume files (metadata.toml + modules_en/*.typ)
    ├── Extract profile: tech stack, seniority, role keywords
    │
    ├── Launch parallel agents ─────────────────────────────────┐
    │   ├── Agent: Greenhouse (site:boards.greenhouse.io)       │
    │   ├── Agent: Lever (site:jobs.lever.co)                   │
    │   ├── Agent: Ashby (site:jobs.ashbyhq.com)                │
    │   ├── Agent: Wellfound (site:wellfound.com/jobs)          │
    │   ├── Agent: RemoteOK (site:remoteok.com)                 │
    │   ├── Agent: WeWorkRemotely (site:weworkremotely.com)     │
    │   ├── Agent: LinkedIn (site:linkedin.com/jobs)            │
    │   └── Agent: Google (broad search, no site: restriction)  │
    │                                                           │
    │   Each agent:                                             │
    │   1. WebSearch with platform-specific queries             │
    │   2. WebFetch top 10 result URLs                          │
    │   3. Extract: title, company, location, url, tech_stack   │
    │   4. Score 1-5 against resume profile                     │
    │   5. Return structured results                            │
    ├───────────────────────────────────────────────────────────┘
    │
    ├── Collect all agent results
    ├── Deduplicate (normalized company + title)
    ├── Sort by match_score descending
    ├── Write CSV to output/jobs-YYYY-MM-DD-HHMMSS.csv
    └── Print terminal summary (top 10 + platform status)
```

## Technical Considerations

### WebFetch and JS-Heavy Pages (Critical Risk)

Many ATS platforms (Greenhouse, Lever, Ashby) use React/JS-heavy frontends. WebFetch does not execute JavaScript and may return empty or partial content.

**Mitigation strategy — two-tier extraction:**
1. **Primary:** Use WebFetch on listing URLs. If it returns structured content (title, company, requirements), use that.
2. **Fallback:** If WebFetch returns empty/unusable content, score the listing from the WebSearch snippet alone (title, URL, description snippet). This still provides enough signal for a match score.

This means the skill works even if no single WebFetch call succeeds — WebSearch snippets alone provide title, company, and a description.

### Search Query Strategy

Each agent constructs 2-3 search queries combining:
- **Platform scope:** `site:boards.greenhouse.io` (or equivalent)
- **Role keywords:** `"Software Architect" OR "Senior Engineer" OR "Tech Lead" OR "Engineering Lead"`
- **Tech signals:** `.NET OR Kubernetes OR Python OR TypeScript`
- **Filters:** `remote OR "work from home"`, exclude `intern OR junior`

The Google fallback agent uses broad queries without `site:` restrictions, excluding domains already covered by dedicated agents.

### Scoring Rubric

| Score | Meaning | Example |
|-------|---------|---------|
| 5 | Perfect match | Senior .NET Architect, remote, contractor-friendly |
| 4 | Strong match | Tech Lead with matching stack, remote, full-time |
| 3 | Good match | Senior role, partial tech overlap, remote |
| 2 | Weak match | Matching tech but junior/mid-level, or no remote |
| 1 | Marginal | Tangentially related role or tech stack |

**Scoring dimensions and weights:**
- Tech stack overlap (40%) — How many of the user's core technologies are mentioned?
- Seniority alignment (25%) — Senior, Lead, Staff, Principal, Architect?
- Remote/location fit (20%) — Remote-friendly? Canada/US/Europe?
- Contract-friendliness (15%) — Mentions contractor, freelance, B2B, or is ambiguous (not explicitly W2-only)?

**Important:** Non-remote or explicitly W2-only roles are NOT excluded — they receive lower scores on those dimensions but remain in the output for user review.

### Deduplication Strategy

1. Normalize: lowercase company name, strip common suffixes (Inc, Ltd, Corp), lowercase title, strip seniority prefixes
2. Match: If normalized (company + title) match >80% similarity, treat as duplicate
3. Keep: The entry with the higher match_score; note alternate source URLs in `match_reasons`

### CSV Contract

- **Encoding:** UTF-8 with BOM for Excel compatibility
- **Escaping:** RFC 4180 compliant (fields containing commas, quotes, or newlines are double-quoted)
- **Date format:** ISO 8601 (`YYYY-MM-DD`), empty string for unknown
- **`match_reasons`:** Semicolon-separated human-readable phrases, double-quoted in CSV (e.g., `"Strong C#/.NET match; Senior-level; Remote"`)
- **`tech_stack`:** Comma-separated inside double-quotes (e.g., `"C#, .NET, Kubernetes, Docker"`)
- **Same-day reruns:** Use timestamp suffix `jobs-YYYY-MM-DD-HHMMSS.csv` to avoid overwriting

### Privacy

The skill MUST NOT include personal identifiers (email, phone, real name) in search queries. Only use tech stack, role keywords, and seniority level for searches.

### Performance Budget

- **Per-agent timeout:** 90 seconds (after which the agent returns whatever it has)
- **Target total execution:** Under 5 minutes
- **Results per agent:** Top 10 listings (cap at first page of WebSearch results)

### Hardcoded Preferences (in SKILL.md)

```
Seniority: Senior, Lead, Staff, Principal, Architect
Role types: Software Architect, Engineering Lead, Tech Lead, Senior Engineer, DevOps Lead
Work style: Remote-friendly, contractor/B2B/freelance preferred
Regions: Canada, US, Europe (remote)
Exclude from search: Junior, Intern, Entry-level
```

These are hardcoded in the skill definition. To change preferences, edit the SKILL.md file.

## Acceptance Criteria

### Functional

- [x] Invoking `/job-search` reads resume files and searches 8 platforms in parallel
- [x] Each agent uses WebSearch with platform-specific queries derived from resume content
- [x] Each agent attempts WebFetch on listing URLs; falls back to search snippets if fetch fails
- [x] Each listing is scored 1-5 using the defined rubric
- [x] Results are deduplicated by normalized company+title
- [x] CSV is written to `output/jobs-YYYY-MM-DD-HHMMSS.csv` with all schema columns
- [x] Terminal output shows: platforms queried, platforms failed, total listings found, top-10 summary table
- [x] `output/` directory is created if it doesn't exist
- [x] `output/` is added to `.gitignore`
- [x] Existing `/job-search-dorks` skill is preserved as a fallback

### Non-Functional

- [ ] Total execution completes in under 5 minutes
- [x] No personal identifiers (email, phone) appear in search queries
- [x] Graceful degradation: platform failures don't abort the entire run
- [x] CSV is RFC 4180 compliant (proper quoting and escaping)

## Success Metrics

- Produces 20-50 deduplicated, scored listings per run
- At least 5 of 8 platforms return results on a typical run
- Top-10 scored listings are genuinely relevant to the user's profile (manual verification)

## Dependencies & Risks

| Risk | Impact | Mitigation |
|------|--------|------------|
| WebFetch fails on JS-heavy ATS pages | Reduced listing detail | Fall back to WebSearch snippets for scoring |
| Platforms rate-limit or block | Fewer results from that platform | Graceful skip + user notification |
| WebSearch returns irrelevant results | Low-quality matches | Tight search queries + LLM scoring filter |
| Total execution exceeds 5 min | Poor UX | Per-agent timeout of 90s; reduce to top 5 per platform if needed |
| LinkedIn blocks all scraping | Missing a major platform | Google fallback covers LinkedIn listings via `site:linkedin.com/jobs` |

## Implementation Phases

### Phase 1: Skill Skeleton + Single Platform

- Create `.claude/skills/job-search/SKILL.md` with full structure
- Implement resume parsing (read 4 files, extract profile)
- Build one agent (Greenhouse) end-to-end: search, fetch, score
- Write CSV output logic
- Test and measure: execution time, token usage, result quality
- Add `output/` to `.gitignore`

### Phase 2: Parallel Multi-Platform

- Add remaining 7 platform agents
- Implement parallel execution via Agent tool
- Add deduplication logic
- Add terminal summary output
- Test full pipeline end-to-end

### Phase 3: Polish

- Tune search queries based on result quality
- Adjust scoring rubric weights if needed
- Handle edge cases (empty results, all platforms fail)
- Verify CSV compatibility with Google Sheets / Excel

## Files to Create/Modify

| File | Action | Purpose |
|------|--------|---------|
| `.claude/skills/job-search/SKILL.md` | Create | New skill definition |
| `.gitignore` | Modify | Add `output/` directory |

## Sources & References

### Origin

- **Brainstorm document:** [docs/brainstorms/2026-03-23-job-search-workflow-brainstorm.md](docs/brainstorms/2026-03-23-job-search-workflow-brainstorm.md) — Key decisions carried forward: parallel agent architecture, web search + scrape retrieval, zero-input design with hardcoded preferences, CSV output to `output/`, smart match scoring.

### Internal References

- Existing skill pattern: `.claude/skills/job-search-dorks/SKILL.md`
- Resume data: `metadata.toml`, `modules_en/professional.typ`, `modules_en/skills.typ`, `modules_en/education.typ`
- Parallel agent patterns: Proven in Claude Code plugins (code-review uses 5 parallel agents, feature-dev uses 2-3)

### Tools Used

- `WebSearch` — Platform-scoped job searches
- `WebFetch` — Listing page parsing (with snippet fallback)
- `Agent` — Parallel platform agents
- `Write` — CSV output
- `Read` — Resume file parsing
