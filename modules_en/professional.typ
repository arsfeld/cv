// Imports
#import "@preview/brilliant-cv:2.0.8": cvSection, cvEntry
#let metadata = toml("../metadata.toml")
#let cvSection = cvSection.with(metadata: metadata)
#let cvEntry = cvEntry.with(metadata: metadata)


#cvSection("Professional Experience")

#cvEntry(
  title: [Senior Software Architect],
  society: [ACCESS Newswire],
  date: [Dec 2024 - Present],
  location: [Montreal, Canada],
  description: list(
    [Implementing AI-powered features including *MCP servers* and agentic architecture to enhance platform capabilities],
    [Designing scalable backend services with *.NET* and *Laravel*, establishing DevOps best practices],
  ),
)

#cvEntry(
  title: [Programming & DevOps Team Lead],
  society: [Ubisoft (Rainbow Six Mobile & Online Services)],
  date: [Nov 2020 - Dec 2024],
  location: [Montreal, Canada],
  description: list(
    [Established and led a 5-person DevOps team, implementing observability and deployment pipelines with *ArgoCD* and *Kubernetes*],
    [Led migration from *Node.js* to *.NET* and transitioned *Kafka*-based systems to cloud-native architecture],
  ),
)

#cvEntry(
  title: [Technical Lead],
  society: [Valital],
  date: [Dec 2019 - Nov 2020],
  location: [Montreal, Canada],
  description: list(
    [Implemented agile methodologies and established CI/CD pipelines using *GitHub Actions*, reducing deployment friction],
    [Developed full-stack healthcare solutions using *Django* and *Python* with *React* for regulatory compliance],
  ),
)

#cvEntry(
  title: [Engineering Manager / Team Lead],
  society: [AlayaCare],
  date: [Sep 2017 - Aug 2019],
  location: [Montreal, Canada],
  description: list(
    [Managed two engineering teams (8+ developers), delivering critical client features and improving retention],
    [Established the scheduling team from scratch, recruiting and mentoring developers working with *Python* and *Vue*],
  ),
)

#cvEntry(
  title: [Lead Developer → Senior Consultant],
  society: [Mentel, Inc / Capgemini],
  date: [Oct 2014 - Sep 2017],
  location: [Montreal, Canada],
  description: list(
    [Developed full-stack solutions using *Laravel 5*, *AngularJS*, *TypeScript*, and *Docker*],
    [Progressed from contractor (Mentel) to full-time consultant at Capgemini, delivering enterprise solutions],
  ),
)

#cvEntry(
  title: [Coordinator of Education Games | Web & Mobile Developer],
  society: [Aptor Software, LTDA],
  date: [Jan 2013 - Sep 2014],
  location: [São Carlos, Brazil],
  description: list(
    [Developed an educational portal using *PHP* and *Symfony 2* with *AngularJS*, leading a team to deliver 10+ games],
  ),
)
