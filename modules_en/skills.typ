// Imports
#import "@preview/brilliant-cv:2.0.8": cvSection, cvSkill, hBar
#let metadata = toml("../metadata.toml")
#let cvSection = cvSection.with(metadata: metadata)


#cvSection("Skills")

#cvSkill(
  type: [Languages],
  info: [Python (FastAPI, Django, asyncio) #hBar() C\# (.NET) #hBar() TypeScript (React, Vue, Node.js) #hBar() PHP (Laravel)],
)

#cvSkill(
  type: [AI & LLMs],
  info: [Agent Platforms #hBar() MCP #hBar() Tool Use #hBar() Anthropic Claude #hBar() Google Gemini #hBar() LLM Evals (Langfuse) #hBar() RAG],
)

#cvSkill(
  type: [Data & Infra],
  info: [PostgreSQL #hBar() Redis #hBar() Kafka #hBar() Kubernetes #hBar() ArgoCD #hBar() AWS #hBar() OpenTelemetry #hBar() Prometheus],
)

#cvSkill(
  type: [Spoken Languages],
  info: [Portuguese #hBar() English #hBar() French #hBar() Spanish #hBar() German],
)
