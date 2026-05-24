# Antigravity Skills & Memory Repository

## Context
This repository acts as the continuous learning "brain" for the Antigravity AI assistant. It safely tracks learned workflows, scripts, and explicit behavioral corrections across all local projects. It is designed to be generated automatically by the Antigravity Collaboration Framework.

## Quick Start
1. Place executable AI skills (prefixed with `ag-`) in the `bin/` directory to safely extend the assistant's capabilities.
2. Update the `memories.md` file whenever the AI makes a behavioral mistake. The AI will load this file at the beginning of every session.
3. **Security Warning**: Do not commit raw secrets or `.env` files to this repository.

## Architecture
- `bin/`: Executable Bash/Python skill scripts.
- `summaries/`: Anonymized session summaries.
- `templates/`: Boilerplate configuration files.
- `patches/`: Safe, system-generated unified diff patches.
- `memories.md`: The core rule ledger for behavioral corrections.
- `INDEX.md`: A lightweight mapping index of all available skills.
