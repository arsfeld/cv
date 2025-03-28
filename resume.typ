#import "@preview/modern-cv:0.8.0": *

#show: resume.with(
  author: (
    firstname: "Alexandre",
    lastname: "Rosenfeld",
    email: "alex@rosenfeld.one",
    homepage: "https://arsfeld.dev",
    phone: "+1 (514) 549-6762",
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

= Experience

#resume-entry(
  title: "Senior Software Architect",
  location: "Montreal, Canada",
  date: "December 2024 - Present",
  description: "ACCESS Newswire",
)

#resume-item[
  - Re-architecting the product around a Service Hub concept using #strong("Kubernetes") and microservices
  - Developing solutions using #strong(".NET") and #strong("Laravel") frameworks
]

#resume-entry(
  title: "Devops Team Lead",
  location: "Montreal, Canada",
  date: "July 2023 - November 2024",
  description: "Ubisoft (Rainbow Six Mobile)",
)

#resume-item[
  - Established and led a new DevOps team to centralize and improve deployment processes
  - Implemented comprehensive observability and streamlined deployment pipelines using #strong("ArgoCD")
]


#resume-entry(
  title: "Programming Team Lead",
  location: "Montreal, Canada",
  date: "November 2020 - June 2023",
  description: "Ubisoft (Online Services)",
)

#resume-item[
  - Led the successful migration from #strong("Node.js") to #strong(".NEt") for improved performance
  - Orchestrated the transition to cloud-native architecture while managing Stats and Leaderboards systems
]

#resume-entry(
  title: "Technical Lead",
  location: "Montreal, Canada",
  date: "December 2019 - November 2020",
  description: "Valital",
)

#resume-item[
  - Implemented agile methodologies and established CI/CD pipelines using #strong("GitHub Actions")
  - Developed full-stack solutions using #strong("Django")/#strong("Python") and #strong("React")
]

#resume-entry(
  title: "Full-stack Consulting",
  location: "Montreal, Canada",
  date: "(Contract) July 2019 - December 2019",
  description: "Zenika",
)

#resume-item[
  - Developed an in-store mobile payment solution using #strong("Kotlin")/#strong("Android")
  - Optimized e-commerce platform performance
]

#resume-entry(
  title: "Engineering Manager / Team Lead",
  location: "Montreal, Canada",
  date: "September 2017 - August 2019",
  description: "AlayaCare",
)

#resume-item[
  - Managed two engineering teams and collaborated with Client Success
  - Led the development and delivery of critical client features and fixes
  - Established and led the scheduling team, recruiting and mentoring developers working with #strong("Python") and #strong("Vue")
]

#resume-entry(
  title: "Senior Consultant",
  location: "Montreal, Canada",
  date: "September 2015 - September 2017",
  description: "Capgemini",
)

#resume-item[
  - Developed full-stack solutions using #strong("Laravel 5") and #strong("AngularJS") with #strong("TypeScript") and #strong("Docker")
]

#resume-entry(
  title: "Lead Developer",
  location: "Montreal, Canada",
  date: "October 2014 - September 2016",
  description: "Mentel, Inc",
)

#resume-item[
  - Led development of multiple projects including real estate platform and event websites
]

#resume-entry(
  title: "Coordinator of Education Games | Web & Mobile Developer",
  location: "São Carlos, Brazil",
  date: "January 2013 - September 2014",
  description: "Aptor Software, LTDA",
)

#resume-item[
  - Developed a new educational portal using #strong("PHP")/#strong("Symfony 2") and #strong("AngularJS"), leading a team to deliver over 10 educational games
]

= Education

#resume-entry(
  title: "University of São Paulo, USP",
  location: "São Carlos, Brazil",
  date: "2006 - 2014",
  description: "Computer Engineering",
)

= Skills

#resume-skill-item(
  "Spoken Languages",
  (strong("Portuguese"), strong("English"), strong("French"), strong("Spanish"), strong("German")),
)
