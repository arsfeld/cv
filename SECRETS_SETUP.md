# GitHub Secrets Setup

To keep your personal information secure, this resume uses GitHub Actions secrets for sensitive data like email and phone number.

## Setting up GitHub Secrets

1. Go to your GitHub repository
2. Click on **Settings** tab
3. In the left sidebar, click **Secrets and variables** → **Actions**
4. Click **New repository secret**
5. Add the following secrets:

### Required Secrets

| Secret Name | Description | Example Value |
|-------------|-------------|---------------|
| `RESUME_EMAIL` | Your email address | `your-email@example.com` |
| `RESUME_PHONE` | Your phone number | `+1 (XXX) XXX-XXXX` |

## Local Development

For local development, you can either:

1. **Use the test script** (recommended):
   ```bash
   ./test-local.sh
   ```

2. **Set environment variables manually**:
   ```bash
   export EMAIL="your-email@example.com"
   export PHONE="+1 (XXX) XXX-XXXX"
   just compile
   ```

## Security Benefits

- ✅ Your personal information is not stored in the repository
- ✅ Secrets are encrypted and only accessible during GitHub Actions runs
- ✅ Contributors can't see your personal information
- ✅ You can still generate PDFs locally and in CI/CD

## Files Modified

- `resume.typ`: Uses `sys.inputs.at()` to read environment variables
- `.github/workflows/build-pdf.yml`: Passes secrets as environment variables
- `justfile`: Includes `--input` parameters for Typst compilation
