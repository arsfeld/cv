#import "@preview/modern-cv:0.8.0": *

#show: resume.with(
  author: (
    firstname: "Alexandre",
    lastname: "Rosenfeld",
    email: sys.inputs.at("EMAIL", default: "your-email@example.com"),
    homepage: "https://arsfeld.dev",
    phone: sys.inputs.at("PHONE", default: "+1 (XXX) XXX-XXXX"),
    github: "arsfeld",
    linkedin: "a-rosenfeld",
    address: "Montreal, Canada",
    positions: (
      "Software Architect",
      "Technical Lead",
      "Engineering Manager",
    ),
  ),
  profile-picture: none,
  date: datetime.today().display(),
  language: "en",
  colored-headers: true,
  show-footer: false,
  paper-size: "us-letter",
)

= Summary

Software Architect and Engineering Leader with 12+ years building scalable systems and leading teams. Proven track record modernizing architectures and implementing DevOps practices across gaming, healthcare, and fintech.

= Experience

#resume-entry(
  title: "Senior Software Architect",
  location: "Montreal, Canada",
  date: "December 2024 - Present",
  description: "ACCESS Newswire",
)

#resume-item[
  - Implementing AI-powered features including #strong("MCP servers") and agentic architecture to enhance platform capabilities
  - Designing scalable backend services with #strong(".NET") and #strong("Laravel"), establishing DevOps best practices
]

#resume-entry(
  title: "Programming & DevOps Team Lead",
  location: "Montreal, Canada",
  date: "November 2020 - December 2024",
  description: "Ubisoft (Rainbow Six Mobile & Online Services)",
)

#resume-item[
  - Established and led a 5-person DevOps team, implementing observability and deployment pipelines with #strong("ArgoCD") and #strong("Kubernetes")
  - Led migration from #strong("Node.js") to #strong(".NET") and transitioned #strong("Kafka")-based systems to cloud-native architecture
]

#resume-entry(
  title: "Technical Lead",
  location: "Montreal, Canada",
  date: "December 2019 - November 2020",
  description: "Valital",
)

#resume-item[
  - Implemented agile methodologies and established CI/CD pipelines using #strong("GitHub Actions"), reducing deployment friction
  - Developed full-stack healthcare solutions using #strong("Django")/#strong("Python") and #strong("React") for regulatory compliance
]

#resume-entry(
  title: "Engineering Manager / Team Lead",
  location: "Montreal, Canada",
  date: "September 2017 - August 2019",
  description: "AlayaCare",
)

#resume-item[
  - Managed two engineering teams (8+ developers), delivering critical client features and improving retention
  - Established the scheduling team from scratch, recruiting and mentoring developers working with #strong("Python") and #strong("Vue")
]

#resume-entry(
  title: "Lead Developer → Senior Consultant",
  location: "Montreal, Canada",
  date: "October 2014 - September 2017",
  description: "Mentel, Inc / Capgemini",
)

#resume-item[
  - Developed full-stack solutions using #strong("Laravel 5"), #strong("AngularJS"), #strong("TypeScript"), and #strong("Docker")
  - Progressed from contractor (Mentel) to full-time consultant at Capgemini, delivering enterprise solutions
]

#resume-entry(
  title: "Coordinator of Education Games | Web & Mobile Developer",
  location: "São Carlos, Brazil",
  date: "January 2013 - September 2014",
  description: "Aptor Software, LTDA",
)

#resume-item[
  - Developed an educational portal using #strong("PHP")/#strong("Symfony 2") and #strong("AngularJS"), leading a team to deliver 10+ educational games
]

= Education

#resume-entry(
  title: "University of São Paulo, USP",
  location: "São Carlos, Brazil",
  date: "2006 - 2014",
  description: "Bachelor of Computer Engineering",
)

#resume-item[
  - International exchange program in Bolivia (1 year) focusing on software development and cultural immersion
  - Active member of AIESEC (1 year), organizing international internship exchanges and developing leadership skills
]

= Skills

#resume-skill-item(
  "Languages",
  (strong("C#"), strong("Python"), strong("TypeScript"), strong("PHP"), strong("Kotlin"), strong("Go")),
)

#resume-skill-item(
  "Frameworks",
  (strong(".NET"), strong("Django"), strong("Laravel"), strong("React"), strong("Vue"), strong("Node.js")),
)

#resume-skill-item(
  "DevOps & Cloud",
  (strong("Kubernetes"), strong("Docker"), strong("ArgoCD"), strong("GitHub Actions"), strong("AWS"), strong("Kafka")),
)

#resume-skill-item(
  "Spoken Languages",
  (strong("Portuguese"), strong("English"), strong("French"), strong("Spanish"), strong("German")),
)
