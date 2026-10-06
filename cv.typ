// Imports
#import "@preview/brilliant-cv:2.0.8": cv
#let metadata = toml("./metadata.toml")
#{
  metadata.lang.en.header_quote = "Hands-on senior backend engineer with 12+ years in Python and .NET: built a production AI agent platform (FastAPI, MCP, Claude, Gemini) and a game-stats pipeline handling tens of thousands of events/sec"
  metadata.inject.injected_keywords_list = ("Senior Software Engineer", "Backend", "Python", "FastAPI", ".NET", "AI Agents", "MCP", "LLM", "PostgreSQL", "Redis", "Kafka", "Kubernetes")
}
#let importModules(modules, lang: metadata.language) = {
  for module in modules {
    include {
      "modules_" + lang + "/" + module + ".typ"
    }
  }
}


#show: cv.with(
  metadata,
)
#importModules((
  "professional",
  "education",
  "skills",
))
