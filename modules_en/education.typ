// Imports
#import "@preview/brilliant-cv:2.0.8": cvSection, cvEntry, hBar
#let metadata = toml("../metadata.toml")
#let cvSection = cvSection.with(metadata: metadata)
#let cvEntry = cvEntry.with(metadata: metadata)


#cvSection("Education")

#cvEntry(
  title: [Bachelor of Computer Engineering],
  society: [University of São Paulo, USP],
  date: [2006 - 2014],
  location: [São Carlos, Brazil],
  description: list(
    [One-year exchange program in Bolivia; AIESEC member organizing international internship exchanges],
  ),
)
