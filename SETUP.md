# Setup Instructions

This file guides you through setting up the project and pushing to GitHub.

## Prerequisites

1. **Git for Windows**: https://git-scm.com/download/win
2. **GitHub CLI (optional but recommended)**: https://cli.github.com/

**Important**: After installing Git, **restart your terminal** to use git commands.

## Quick Push (Recommended)

### Step 1: Install GitHub CLI

```powershell
# Using winget (run in PowerShell as Administrator)
winget install GitHub.cli

# Or download directly: https://github.com/cli/cli/releases
```

### Step 2: Authenticate

```bash
gh auth login
# Follow the prompts:
# - GitHub.com
# - HTTPS
# - Yes
# - Login with a web browser
# - Paste code
```

### Step 3: Push to GitHub

```bash
cd my-game
git init
git add .
git commit -m "Initial commit: OpenCode Game Studio - Godot 2D"
gh repo create opencode-godot-studio --public --source=. --description "Game development studio framework for OpenCode + Godot 2D"
git push -u origin main
```

## Alternative: Git Only (Without gh CLI)

### Step 1: Create Repository on GitHub.com

1. Go to: https://github.com/new
2. Repository name: `opencode-godot-studio`
3. Description: `Game development studio framework for OpenCode + Godot 2D`
4. Select: **Public**
5. Don't add any files (README, .gitignore, license) - we have them already
6. Click: **Create repository**

### Step 2: Push from Terminal

```bash
cd my-game
git init
git add .
git commit -m "Initial commit: OpenCode Game Studio - Godot 2D"
git remote add origin https://github.com/chxzh1983/opencode-godot-studio.git
git branch -M main
git push -u origin main
```

## After Push

### 1. Add Topics (Important for discoverability)

On your GitHub repository page:
1. Click **Repository → Settings**
2. Scroll to **Topics**
3. Add these topics:
   - `opencode`
   - `godot`
   - `godot-2d`
   - `gamedev`
   - `game-development`
   - `ai-agent`
   - `game-engine`
   - `2d-game`

### 2. Enable Features

- Go to **Settings → Issues** → Enable Issues
- Go to **Settings → Pages** → (optional) Enable GitHub Pages

### 3. Share!

Your repository URL: https://github.com/chxzh1983/opencode-godot-studio

## Troubleshooting

### "git is not recognized"

Restart your terminal or computer after installing Git.

### "Permission denied"

```bash
gh repo delete opencode-godot-studio
# Then create again
```

### "Repository already exists"

```bash
# Try a different name or delete on GitHub web interface
gh repo delete opencode-godot-studio --yes
```

## Project Summary

You're creating an open source project with these files:

| File | Purpose |
|------|---------|
| `README.md` | Main documentation |
| `LICENSE` | MIT License |
| `CONTRIBUTING.md` | Contribution guide |
| `AGENTS.md` | OpenCode rules |
| `.opencode/agents/*.md` | 5 Agent definitions |
| `docs/*.md` | Godot 2D reference |

---

**Project ready!** For questions, open an issue on GitHub.