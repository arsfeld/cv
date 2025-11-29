compile:
    envsubst < metadata.toml.template > metadata.toml
    typst compile cv.typ resume.pdf
