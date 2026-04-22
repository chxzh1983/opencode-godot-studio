@echo off
echo ================================================
echo OpenCode Game Studio - GitHub Push
echo ================================================
echo.
echo Step 1: Install Git (if not already)
echo   https://git-scm.com/download/win
echo.
echo Step 2: Restart this terminal
echo.
echo Step 3: Open a NEW terminal and run:
echo.
echo   cd my-game
echo   git init
echo   git add .
echo   git commit -m "Initial commit"
echo   gh repo create opencode-godot-studio --public --source=. --description "Game dev studio for OpenCode + Godot 2D"
echo   git push -u origin main
echo.
echo OR without GitHub CLI:
echo   gh repo create on website, then:
echo   git remote add origin https://github.com/chxzh1983/opencode-godot-studio.git
echo   git push -u origin main
echo.
echo ================================================
echo.
echo Project location: %~dp0
echo.
pause