# Brainstorm: Full-Featured Job Search Workflow

**Date:** 2026-03-23
**Status:** Complete

## What We're Building

A Claude Code skill (`/job-search`) that automates the entire job discovery pipeline — from searching multiple platforms to delivering a scored, deduplicated CSV of matching positions. Zero input required; the skill reads the user's resume and runs end-to-end.

### The Problem

The current `/job-search-dorks` skill generates Google search queries but leaves the user to manually:
- Copy-paste dorks into a browser
- Click through dozens of results across 23 platforms
- Mentally filter relevant positions
- Track findings somewhere

### The Solution

A single skill invocation that:
1. **Reads the resume** — Parses `metadata.toml` and `modules_en/*.typ` to extract tech stack, seniority, role keywords, and preferences
2. **Searches in parallel** — Launches multiple agents, each targeting a different job board or ATS platform
3. **Fetches and parses listings** — Each agent uses `WebSearch` to find listings, then `WebFetch` to extract job details from result pages
4. **Scores against resume** — Uses LLM judgment to rate each listing's match quality (tech stack overlap, seniority fit, role alignment)
5. **Deduplicates and ranks** — Merges results from all agents, removes duplicates, sorts by match score
6. **Outputs CSV** — Writes a structured CSV file ready for sorting, filtering, and tracking

## Why This Approach

**Parallel agents** — Claude Code's agent model naturally supports launching independent searches concurrently. Each agent can be specialized for a platform's search syntax and page structure without blocking others.

**Web search + scrape over APIs** — Most job boards don't offer public APIs. Web search gives the broadest coverage across ATS platforms (Greenhouse, Lever, Ashby, etc.) and job boards (Wellfound, RemoteOK, etc.) without needing API keys or authentication.

**Smart matching over raw dumps** — With 12+ years of experience across a broad tech stack (C#, Python, TypeScript, Kubernetes, .NET, Django, React), raw search results would be overwhelming. LLM-based scoring adds real value by filtering noise.

**Zero-input design** — The resume already contains all the context needed. Hardcode preferences (remote, senior+, contractor-friendly) to minimize friction. Just run `/job-search` and get results.

## Key Decisions

| Decision | Choice | Rationale |
|----------|--------|-----------|
| Retrieval method | Web search + page scraping | Broadest coverage without API keys |
| Architecture | Parallel agents per platform | Speed; natural fit for Claude Code |
| Filtering | LLM-scored smart match | Eliminates noise from broad searches |
| Output format | CSV file | Sortable, filterable, trackable in any spreadsheet |
| Input parameters | None (zero-input) | Resume provides all context; preferences hardcoded |
| State tracking | None (fresh each run) | Simpler; user manages dedup in spreadsheet |

## Target Platforms (v1)

### ATS Platforms (public job board pages)
- Greenhouse (`boards.greenhouse.io`)
- Lever (`jobs.lever.co`)
- Ashby (`jobs.ashby.io`)

### Job Boards
- Wellfound (AngelList)
- RemoteOK
- WeWorkRemotely
- LinkedIn Jobs (via web search)

### General Search
- Google search across all other platforms

## CSV Schema

| Column | Description |
|--------|-------------|
| `title` | Job title |
| `company` | Company name |
| `location` | Location / remote status |
| `url` | Direct link to listing |
| `source` | Platform where found |
| `match_score` | 1-5 rating against resume |
| `match_reasons` | Brief explanation of why it matches |
| `tech_stack` | Technologies mentioned in listing |
| `posted_date` | When posted (if available) |

## Hardcoded Preferences

Based on resume analysis:
- **Seniority:** Senior, Lead, Staff, Principal, Architect
- **Role types:** Software Architect, Engineering Lead, Tech Lead, Senior Engineer, DevOps Lead
- **Key technologies:** .NET/C#, Python, TypeScript, Kubernetes, Docker, AWS
- **Work style:** Remote-friendly, contractor/B2B/freelance
- **Regions:** Canada, US, Europe (remote)
- **Exclude:** Junior roles, internships

## Resolved Questions

1. **CSV location** — Write to `output/jobs-YYYY-MM-DD.csv` inside the CV repo. Add `output/` to `.gitignore`.
2. **Results per platform** — Top 10 per platform (~70 total across 7 platforms before dedup/scoring).
3. **Existing dorks skill** — Keep `/job-search-dorks` as a lightweight fallback for quick manual searches.
4. **Rate limiting** — Graceful degradation: if a platform blocks or times out, skip it and note it in the output. Don't retry aggressively.
