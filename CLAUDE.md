# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a CV/resume project using Typst (a modern typesetting system) with the `@preview/modern-cv` package. The project uses Nix/devenv for reproducible development environments.

## Build Commands

Enter the development environment first:
```bash
devenv shell
```

Compile the resume to PDF:
```bash
just compile
```

The compile command requires `EMAIL` and `PHONE` environment variables for personal contact info (these are injected via Typst's `--input` flag).

## Project Structure

- `resume.typ` - Main resume file using modern-cv Typst package
- `coverletter.typ`, `coverletter2.typ` - Cover letter templates
- `devenv.nix` - Nix development environment (provides typst, just, and fonts)
- `justfile` - Build automation commands
- `.github/workflows/build-pdf.yml` - CI/CD workflow for automated PDF builds and releases

## Typst Notes

- The project uses Typst v0.8.0+ with the `@preview/modern-cv:0.8.0` package
- Fonts are provided via Nix: Font Awesome 5/6, Roboto, Source Sans Pro
- Font path is set via `$XDG_DATA_DIRS` in the compile command
- Sensitive info (email, phone) is passed as Typst inputs, not hardcoded

## CI/CD

GitHub Actions automatically builds the PDF on push to main and creates releases. Secrets `RESUME_EMAIL` and `RESUME_PHONE` must be configured in the repository.
