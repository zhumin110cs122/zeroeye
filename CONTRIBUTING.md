# Contributing

Thank you for contributing to Tent of Trials! This guide helps you set up a working development environment and submit pull requests.

## Local Setup

```bash
git clone https://github.com/lobster-trap/TentOfTrials
cd TentOfTrials
```

### Prerequisites

- Python 3.8+
- Rust toolchain (cargo)
- Node.js 22+
- Go 1.21+
- GCC (for C/C++ modules)
- Java JDK 21 (for compliance module)

Install all dependencies at once on Ubuntu:

```bash
sudo apt update
sudo apt install -y build-essential curl ca-certificates gnupg pkg-config \
  libssl-dev protobuf-compiler make gcc g++ cmake linux-libc-dev \
  openjdk-21-jdk golang-go ruby-full ruby-dev redis-server \
  lua5.4 luarocks libi2c-dev i2c-tools ghc cabal-install zlib1g-dev
```

### Build

```bash
python3 build.py              # Build all modules
python3 build.py --clean      # Clean all artifacts
python3 build.py -m backend   # Build specific module
```

Each build generates diagnostic artifacts in the `diagnostic/` directory.

## Pull Request Workflow

1. **Fork** the repository
2. **Create a branch**: `git checkout -b feat/your-feature`
3. **Make changes** and commit them
4. **Run the build**: `python3 build.py`
5. **Include diagnostic artifacts** from `diagnostic/` in your PR
6. **Open a pull request** against the `main` branch

Use the `.github/pull_request_template.md` template for your PR description.

### PR Requirements

- Build passes locally (`python3 build.py`)
- Diagnostic log files from `diagnostic/` are committed
- Documentation updated if applicable
- Changes are scoped to the PR purpose
- Code follows the project's `.editorconfig` style rules

## Code Style

This project uses [EditorConfig](https://editorconfig.org/) for consistent formatting. See `.editorconfig` in the repository root for per-language rules:

- **Python, Rust, C, C++**: 4 spaces
- **TypeScript, JavaScript, YAML, JSON, Markdown, Lua, CSS, HTML**: 2 spaces
- **Go, Makefile**: tabs
- All files: UTF-8, LF line endings, trailing whitespace trimmed

## Questions?

Open an issue or check the active bounties on the [Issues page](https://github.com/lobster-trap/TentOfTrials/issues).
