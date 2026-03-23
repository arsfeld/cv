---
name: job-search
description: Automated job search workflow that finds, scores, and exports matching positions from multiple platforms. Use when the user wants to find job listings matching their resume.
---

You are an expert job search automation agent. Your job is to find real job listings across multiple platforms, score them against the user's resume, and output a ranked CSV.

## GOAL

Search 8 job platforms in parallel, extract listings, score each one against the user's resume, deduplicate, and write a ranked CSV file. Zero input required — preferences are hardcoded below.

## REQUIRED FILES TO READ

Read these files to build the candidate profile:

- `metadata.toml` — personal info, header quote, injected keywords
- `modules_en/professional.typ` — work history, titles, seniority signals
- `modules_en/skills.typ` — languages, frameworks, DevOps tools
- `modules_en/education.typ` — education background

**Privacy rule:** NEVER use personal identifiers (email, phone, real name) in search queries. Only use tech stack, role keywords, and seniority level.

## HARDCODED PREFERENCES

```
Seniority: Senior, Lead, Staff, Principal, Architect
Role types: Software Architect, Engineering Lead, Tech Lead, Senior Engineer, DevOps Lead
Key technologies: .NET, C#, Python, TypeScript, Kubernetes, Docker, AWS
Work style: Remote-friendly, contractor/B2B/freelance preferred
Regions: Canada, US, Europe (remote)
Exclude from search: Junior, Intern, Entry-level
```

## WORKFLOW

### Step 1: Analyze the Resume

Read the resume files listed above and extract:

- **Tech Stack**: Programming languages, frameworks, and tools (from `skills.typ` and bolded terms in `professional.typ`)
- **Seniority**: Determine level from job titles and years of experience
- **Role Keywords**: Key job titles and domain roles
- **Certifications**: Any relevant certifications (e.g., AWS)

Combine these with the hardcoded preferences to form the search profile.

### Step 2: Search Platforms in Parallel

Launch **8 agents in parallel** using the Agent tool. Each agent targets one platform. All agents run concurrently for speed.

**Important:** Launch ALL 8 agents in a SINGLE message with multiple Agent tool calls. Do NOT launch them sequentially.

Each agent receives the same prompt template (customized per platform):

```
You are a job search agent for [PLATFORM_NAME].

## Candidate Profile
[Insert extracted profile: tech stack, seniority, role keywords from Step 1]

## Your Task

1. Use WebSearch to find job listings on [PLATFORM_DOMAIN] matching this profile.

   Run 2-3 searches combining:
   - Platform scope: site:[PLATFORM_DOMAIN]
   - Role keywords: "Software Architect" OR "Senior Engineer" OR "Tech Lead" OR "Engineering Lead" OR "DevOps Lead"
   - Tech signals: .NET OR C# OR Kubernetes OR Python OR TypeScript
   - Remote filter: remote OR "work from home" OR "work remotely"
   - Exclude: -intern -junior -"entry level"

2. From the search results, pick up to 10 most relevant listings.

3. For each listing, try to use WebFetch to get the full job description page.
   - If WebFetch returns useful content (job title, requirements, tech stack), use that for scoring.
   - If WebFetch fails or returns empty/unusable content (common with JS-heavy pages), use the search result snippet instead. This is fine — snippets contain enough signal.

4. Score each listing 1-5 against the candidate profile using this rubric:

   | Score | Meaning |
   |-------|---------|
   | 5 | Perfect match — matching tech stack, senior+ level, remote, contractor-friendly |
   | 4 | Strong match — good tech overlap, senior level, remote, possibly full-time |
   | 3 | Good match — partial tech overlap, senior role, remote |
   | 2 | Weak match — some tech overlap but wrong level, or not remote |
   | 1 | Marginal — tangentially related |

   Scoring weights:
   - Tech stack overlap: 40%
   - Seniority alignment: 25%
   - Remote/location fit: 20%
   - Contract-friendliness: 15%

   Non-remote or full-time roles are NOT excluded — they just score lower.

5. Return your results as a JSON array (one object per listing):

   ```json
   [
     {
       "title": "Senior .NET Architect",
       "company": "Acme Corp",
       "location": "Remote (US)",
       "url": "https://boards.greenhouse.io/acme/jobs/12345",
       "source": "[PLATFORM_NAME]",
       "match_score": 5,
       "match_reasons": "Strong C#/.NET match; Architect-level; Remote; Contract-friendly",
       "tech_stack": "C#, .NET, Kubernetes, Docker, AWS",
       "posted_date": "2026-03-20"
     }
   ]
   ```

   If posted_date is not available, use an empty string.
   If you find zero results, return an empty array [].

DO NOT fabricate or hallucinate job listings. Only return real positions found via WebSearch.
```

#### Platform-Specific Agent Configurations

| Agent | Platform | Domain for `site:` |
|-------|----------|---------------------|
| 1 | Greenhouse | `boards.greenhouse.io` |
| 2 | Lever | `jobs.lever.co` |
| 3 | Ashby | `jobs.ashbyhq.com` |
| 4 | Wellfound | `wellfound.com/jobs` |
| 5 | RemoteOK | `remoteok.com` |
| 6 | WeWorkRemotely | `weworkremotely.com` |
| 7 | LinkedIn | `linkedin.com/jobs` |
| 8 | Google (broad) | No `site:` restriction. Search broadly but exclude domains already covered by agents 1-7. Use `-site:boards.greenhouse.io -site:jobs.lever.co -site:jobs.ashbyhq.com -site:wellfound.com -site:remoteok.com -site:weworkremotely.com -site:linkedin.com` |

### Step 3: Collect and Deduplicate Results

After all agents return:

1. **Parse** each agent's JSON results into a combined list.
2. **Handle failures**: If an agent returned an error or empty results, note the platform as "failed" but continue with other results.
3. **Deduplicate**:
   - Normalize: lowercase company name, strip suffixes (Inc, Ltd, Corp, LLC), lowercase title
   - If two listings have the same normalized (company + title), keep the one with the higher match_score
   - Note alternate source in match_reasons (e.g., "Also found on: Lever")
4. **Sort** by match_score descending, then by company name alphabetically.

### Step 4: Write CSV Output

1. Create the `output/` directory if it doesn't exist: `mkdir -p output`
2. Generate filename with timestamp: `output/jobs-YYYY-MM-DD-HHMMSS.csv`
3. Write CSV with these columns (in order):

```
title,company,location,url,source,match_score,match_reasons,tech_stack,posted_date
```

**CSV rules:**
- UTF-8 encoding
- RFC 4180 compliant: fields containing commas, quotes, or newlines must be double-quoted
- Escape quotes by doubling them: `"` becomes `""`
- `match_reasons`: semicolon-separated phrases, double-quoted (e.g., `"Strong C#/.NET match; Senior-level; Remote"`)
- `tech_stack`: comma-separated inside double-quotes (e.g., `"C#, .NET, Kubernetes"`)
- `posted_date`: ISO 8601 (`YYYY-MM-DD`) or empty string if unknown

### Step 5: Print Terminal Summary

After writing the CSV, print a summary to the terminal:

```markdown
## Job Search Results

**Platforms searched:** 8
**Platforms with results:** [N] | **Failed:** [list of failed platforms or "none"]
**Total listings found:** [N] (before dedup) -> [N] (after dedup)
**CSV written to:** output/jobs-YYYY-MM-DD-HHMMSS.csv

### Top 10 Matches

| Score | Title | Company | Location | Source |
|-------|-------|---------|----------|--------|
| 5 | Senior .NET Architect | Acme Corp | Remote (US) | Greenhouse |
| 4 | Tech Lead, Platform | Beta Inc | Remote (EU) | Lever |
| ... | ... | ... | ... | ... |

[Full results in CSV file]
```

## IMPORTANT NOTES

- **Do NOT fabricate listings.** Only include real positions found via WebSearch.
- **Privacy first.** Never include personal info (email, phone, name) in search queries.
- **Graceful degradation.** If a platform fails or returns nothing, continue with other platforms. Never abort the entire run because one platform failed.
- **WebFetch fallback.** Many job sites are JS-heavy. If WebFetch returns empty content, score from the search snippet instead. This is expected and acceptable.
- **Speed over perfection.** Launch all 8 agents in parallel. Don't wait for one to finish before starting the next.
