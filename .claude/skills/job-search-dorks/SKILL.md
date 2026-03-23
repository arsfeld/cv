---
name: job-search-dorks
description: Generate Google Job Search Dorks based on resume content. Use when the user wants to find job listings via Google dorking.
argument-hint: [contract_type] [regions]
---

You are an expert in Google dorking for job search.

## GOAL

Generate advanced Google search dorks to find remote software developer roles based on the user's resume in this repository, specific contract types, and regions.

## INPUT

- `$0`: The desired contract type (e.g., contractor, freelance, 1099, B2B). If not provided, ask the user.
- Remaining `$ARGUMENTS`: Target regions or locations (e.g., US, Europe, LATAM, Canada). If not provided, ask the user.

## REQUIRED FILES TO READ

Read these files to extract tech stack, seniority, and role keywords:

- `metadata.toml` — personal info, header quote, injected keywords
- `modules_en/professional.typ` — work history, titles, seniority signals
- `modules_en/skills.typ` — languages, frameworks, DevOps tools
- `modules_en/education.typ` — education background (if relevant)

## WORKFLOW

### Step 1: Analyze the Resume

Read the resume files listed above and extract:

- **Tech Stack**: Programming languages, frameworks, and tools (from `skills.typ` and bolded terms in `professional.typ`)
- **Seniority**: Determine level from job titles and years of experience (e.g., Senior, Lead, Architect)
- **Role Keywords**: Key job titles and domain roles (e.g., Software Architect, Engineering Leader, DevOps, Team Lead)

### Step 2: Generate Google Dorks

Using the extracted Tech Stack, Seniority, and Role Keywords, along with the provided contract_type and regions, generate optimized Google dorks.

1. Generate optimized Google dorks for EACH of the following ATS platforms:
   - Greenhouse (boards.greenhouse.io)
   - Lever (jobs.lever.co)
   - Ashby (jobs.ashbyhq.com)
   - Workday (myworkdayjobs.com / wd1.myworkdayjobs.com)
   - SmartRecruiters (careers.smartrecruiters.com)
   - BambooHR (jobs.bamboohr.com)
   - iCIMS (careers.icims.com)
   - Jobvite (jobs.jobvite.com)
   - Teamtailor (career.teamtailor.com)
   - Personio (jobs.personio.de)
   - Comeet (jobs.comeet.co)
   - Recruitee (jobs.recruitee.com)

2. Generate optimized Google dorks for these job boards:
   - Wellfound (wellfound.com)
   - RemoteOK (remoteok.com)
   - WeWorkRemotely (weworkremotely.com)
   - Remotive (remotive.com)
   - Working Nomads (workingnomads.com)
   - Jobspresso (jobspresso.co)
   - Authentic Jobs (authenticjobs.com)
   - FlexJobs (flexjobs.com)
   - Arc (arc.dev)
   - Indeed (indeed.com)
   - LinkedIn Jobs (linkedin.com/jobs)

### Step 3: Dork Requirements

Each dork must:
- Include "remote" and the locations defined in regions.
- Include contract-related terms from contract_type (e.g., contract, contractor, freelance, 1099).
- Include the extracted Tech Stack and Role Keywords.
- Exclude internships and junior roles unless the extracted Seniority explicitly suggests otherwise.
- Be optimized for Google search (use OR, parentheses, intitle:, inurl:, site:, etc.).

### Step 4: Output Format

- Group by ATS platforms.
- Group by Job Boards.
- Provide at least 2 strong variations per platform.
- Use clean markdown code block formatting for the generated dorks so they can be easily copied.
- Do not explain anything — only output the dorks.

IMPORTANT: Observe high signal, low noise. Use boolean operators properly. Avoid generic searches.
