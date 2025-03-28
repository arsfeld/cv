# My CV Project 🚀

Welcome to my CV project! This repository contains everything needed to build and maintain my professional resume and cover letter in a clean, automated way. Here's a quick overview of what's inside:

## 📂 Project Structure

- **`resume.typ`**:  
  This is the main file for my resume. Written in Typst, it includes all my professional experience, education, and skills.  
  👉 Run `just compile` to generate the PDF!

- **`coverletter2.typ`**:  
  A customizable cover letter template. It uses Typst to generate a professional-looking letter tailored to specific job applications.

- **`.github/workflows/build-pdf.yml`**:  
  GitHub Actions workflow to automatically build and release the resume PDF whenever changes are pushed to the `main` branch.  
  💡 It even uploads the PDF as an artifact and creates a release!

- **`justfile`**:  
  Contains a simple command to compile the Typst files into PDFs.  
  ```bash
  just compile
  ```

- **`.gitignore`**:  
  Keeps the repo clean by ignoring unnecessary files like PDFs, temporary files, and editor-specific files.

## 🛠️ How to Use

1. **Set up the environment**:  
   Make sure you have Nix and Devenv installed. Use `devenv shell` to access all dependencies.

2. **Compile the resume**:  
   Run the following command to generate the PDF:  
   ```bash
   just compile
   ```

3. **Automated builds**:  
   Push your changes to the `main` branch, and GitHub Actions will automatically build and release the updated resume PDF.

## 🌟 Features

- **Modern CV Design**:  
  Using the `@preview/modern-cv` Typst package for a sleek and professional look.

- **Multi-language Support**:  
  The resume and cover letter can be easily adapted to different languages.

- **Automated CI/CD**:  
  GitHub Actions ensures the latest version of the resume is always available.

## 📜 License

Feel free to use this project as inspiration for your own CV!  
Happy job hunting! 🎉
