// Imports
#import "@preview/brilliant-cv:2.0.8": cvSection, cvEntry
#let metadata = toml("../metadata.toml")
#let cvSection = cvSection.with(metadata: metadata)
#let cvEntry = cvEntry.with(metadata: metadata)


#cvSection("Professional Experience")

#cvEntry(
  title: [Senior Software Architect],
  society: [ACCESS Newswire],
  date: [Dec 2024 - Oct 2026],
  location: [Montreal, Canada],
  description: list(
    [Designed and built, with one other developer, the company's *AI agent platform* in async *Python* (*FastAPI*, *PostgreSQL*, *Redis*): agent registry with per-agent permissions, tools, and *MCP servers*; *20–30 agents* in production on *Claude* and *Gemini*],
    [Instrumented agent runs with *Langfuse* evals and *OpenTelemetry* tracing to catch regressions and failures in production],
    [Wired agents into the core product through extension points, powering a *paid AI insights and analytics report* (\$200–300 per report) and letting non-developers ship new agents without code],
    [Built a *.NET* news-ingestion service (*thousands of articles/day*) and public agents that generated personalized AI reports for \~100 conference attendees],
  ),
)

#cvEntry(
  title: [Programming & DevOps Team Lead],
  society: [Ubisoft (Online Services & Rainbow Six Mobile)],
  date: [Nov 2020 - Nov 2024],
  location: [Montreal, Canada],
  description: list(
    [Rebuilt the game-stats pipeline ingesting *tens of thousands of events/sec*, replacing on-prem *Kafka* and *JavaScript Lambdas* (*DynamoDB*) with a horizontally scalable *.NET* container service; weekly hours-long incidents dropped to *zero* and all physical hardware was retired],
    [Built load tests simulating *hundreds of thousands of CCU* across several continents, including live mocks of services that changed every week],
    [Root-caused a soft-launch performance crisis with *Unity*: game servers sized thread pools from the physical host's CPU count instead of the *container CPU limit*],
    [Owned microservice deployment tooling on *Kubernetes*, started the move to *ArgoCD*, and guided service teams on *Prometheus/Grafana* instrumentation; team of 5],
  ),
)

#cvEntry(
  title: [Technical Lead],
  society: [Valital],
  date: [Dec 2019 - Nov 2020],
  location: [Montreal, Canada],
  description: list(
    [One of two engineers building an *ML compliance-screening platform* (*Django*, *Python*, *React*); productionized the data-science team's *ML pipeline* and built *CI/CD* with *GitHub Actions*],
  ),
)

#cvEntry(
  title: [Scheduling Team Lead → Director of Engineering Support],
  society: [AlayaCare],
  date: [Sep 2017 - Aug 2019],
  location: [Montreal, Canada],
  description: list(
    [Customer-escalation engineering for a home-care SaaS platform (*Python*, *Vue*): \~50 tickets/week triaged, *20–30 fixes shipped every sprint*; sped up QA and releases so fixes joined the regular release train],
  ),
)

#cvEntry(
  title: [Lead Developer → Senior Consultant],
  society: [Mentel, Inc / Capgemini],
  date: [Oct 2014 - Sep 2017],
  location: [Montreal, Canada],
  description: list(
    [Built full-stack apps for many clients (*Laravel*, *AngularJS*, *TypeScript*); ran a production *Rancher* cluster on early *Docker*],
  ),
)

#cvEntry(
  title: [Open Source Developer | Google Summer of Code (3 consecutive years)],
  description: [],
  society: [GNOME Foundation],
  date: [2008 - 2010],
  location: [Remote],
)
