# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a CV/resume project using Typst (a modern typesetting system) with the `@preview/brilliant-cv` package. The project uses Nix/devenv for reproducible development environments.

## Build Commands

Enter the development environment first:
```bash
devenv shell
```

Compile the resume to PDF:
```bash
just compile
```

## Project Structure

- `cv.typ` - Main CV file that imports modules
- `metadata.toml` - Configuration (personal info, colors, layout settings)
- `modules_en/` - Content modules (professional.typ, education.typ, skills.typ)
- `src/` - Assets (logos, avatar, etc.)
- `coverletter.typ`, `coverletter2.typ` - Cover letter templates
- `devenv.nix` - Nix development environment (provides typst, just, and fonts)
- `justfile` - Build automation commands
- `.github/workflows/build-pdf.yml` - CI/CD workflow for automated PDF builds and releases

## Typst Notes

- The project uses Typst with the `@preview/brilliant-cv:2.0.8` package
- Fonts are provided via Nix: Font Awesome, Roboto, Source Sans Pro
- Font paths are configured via `TYPST_FONT_PATHS` env var in devenv.nix
- Personal info (email, phone, etc.) is configured in `metadata.toml`

## CI/CD

GitHub Actions automatically builds the PDF on push to main and creates releases.
