// Imports
#import "@preview/brilliant-cv:2.0.8": cvSection, cvSkill, hBar
#let metadata = toml("../metadata.toml")
#let cvSection = cvSection.with(metadata: metadata)


#cvSection("Skills")

#cvSkill(
  type: [Languages],
  info: [C\# #hBar() Python #hBar() TypeScript #hBar() PHP #hBar() Kotlin #hBar() Go],
)

#cvSkill(
  type: [Frameworks],
  info: [.NET #hBar() Django #hBar() Laravel #hBar() React #hBar() Vue #hBar() Node.js],
)

#cvSkill(
  type: [DevOps & Cloud],
  info: [Kubernetes #hBar() Docker #hBar() ArgoCD #hBar() GitHub Actions #hBar() AWS #hBar() Kafka],
)

#cvSkill(
  type: [Spoken Languages],
  info: [Portuguese #hBar() English #hBar() French #hBar() Spanish #hBar() German],
)
