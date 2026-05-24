#!/usr/bin/env bash
# ag-scaffold-brain.sh
# Scaffolds the Antigravity AI global environment structure and compiles templates.

set -e

# 1. Environment Variable Check
if [ ! -f .env ]; then
  echo "=> No .env file found!"
  if [ -f .env.example ]; then
    echo "=> Generating .env from .env.example..."
    cp .env.example .env
    echo "=> Please edit the newly created .env file with your specific OS and Path details, then re-run this script!"
  else
    echo "=> Error: Neither .env nor .env.example found. Please create a .env file."
  fi
  exit 1
fi

echo "=> Sourcing .env configuration..."
set -a
source .env
set +a

# Require core variables
: "${AG_WORKSPACE:?Variable AG_WORKSPACE is not set in .env}"
: "${AG_SETUP_DIR:?Variable AG_SETUP_DIR is not set in .env}"

echo "=> Compiling Markdown Templates..."
# Expand variables in the setup documentation
for file in requirements.md implementation_plan.md system_instructions.md; do
  if [ -f "$file" ]; then
    # Use envsubst to replace variables, keeping existing variables intact if not defined
    envsubst < "$file" > "${file}.tmp"
    mv "${file}.tmp" "$file"
    echo "   -> Compiled $file"
  fi
done

echo "=> Scaffolding Antigravity Brain Environments..."

# 2. Setup Docs Repository
mkdir -p "${AG_SETUP_DIR}"
if [ ! -d "${AG_SETUP_DIR}/.git" ]; then
    git -C "${AG_SETUP_DIR}" init
    echo "   -> Initialized git repository in ${AG_SETUP_DIR}"
fi

# 3. Skills Repository Directories
mkdir -p "${AG_WORKSPACE}/skills/"{bin,summaries,templates,patches}
if [ ! -d "${AG_WORKSPACE}/skills/.git" ]; then
    git -C "${AG_WORKSPACE}/skills" init
    echo "   -> Initialized git repository in ${AG_WORKSPACE}/skills"
fi

# 4. Scaffold .gitignore
cat << 'EOF' > "${AG_WORKSPACE}/skills/.gitignore"
# Prevent accidental tracking of binary files or secrets
*.env
*.pem
*.key
.DS_Store
__pycache__/
node_modules/
target/
EOF

# 5. Scaffold memories.md
if [ ! -f "${AG_WORKSPACE}/skills/memories.md" ]; then
cat << 'EOF' > "${AG_WORKSPACE}/skills/memories.md"
# Antigravity Correction Memory Ledger

This file contains explicit behavioral directives learned from user corrections.

## Directives
<!-- Use schema: [#tags] | [Context Trigger] -> [Explicit Directive] -->
EOF
fi

# 6. Scaffold INDEX.md
if [ ! -f "${AG_WORKSPACE}/skills/INDEX.md" ]; then
cat << 'EOF' > "${AG_WORKSPACE}/skills/INDEX.md"
# Antigravity Skills Index

This file acts as a fast-reference manifest for available skills.

## Available Skills
- `ag-scaffold-brain.sh`: Scaffolds the Antigravity global environment architecture.
EOF
fi

echo "=> Antigravity Brain scaffolded successfully!"
