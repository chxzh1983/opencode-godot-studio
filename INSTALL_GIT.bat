@echo off
echo ================================================
echo OpenCode Game Studio - GitHub Push
echo ================================================
echo.
echo Git not found in your system.
echo.
echo Please install Git for Windows:
echo.
echo 1. Download:
echo    https://git-scm.com/download/windows
echo.
echo 2. During installation, use these options:
echo    - Select: "Use Git from Windows Command Prompt"
echo    - Select: "Checkout Windows-style, commit Unix-style"
echo    - Select: "Use OpenSSH"
echo.
echo 3. RESTART your terminal after installation
echo.
echo 4. Then run this command from my-game folder:
echo.
echo    git init
echo    git add .
echo    git commit -m "Initial commit"
echo    gh repo create opencode-godot-studio --public --source=. --description "Game dev studio for OpenCode + Godot 2D"
echo    git push -u origin main
echo.
echo ================================================
echo.
echo After installing Git, run: PUSH.bat
echo.
echo Press any key to open Git download page...
start https://git-scm.com/download/windows
pause >nul