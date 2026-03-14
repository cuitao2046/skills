@echo off
setlocal enabledelayedexpansion

set SKILL_NAME=md-to-pdf
set INSTALL_DIR=%USERPROFILE%\.claude\skills\%SKILL_NAME%

echo 📦 Installing Claude Skill: %SKILL_NAME%

REM Create skills directory
if not exist "%USERPROFILE%\.claude\skills" (
    mkdir "%USERPROFILE%\.claude\skills"
)

REM Clone or update repository
if not exist "%INSTALL_DIR%" (
    echo 📥 Cloning repository...
    git clone https://github.com/cuitao2046/skills.git "%TEMP%\skills-repo"
    xcopy /E /I /Y "%TEMP%\skills-repo\claude-md-academic-pdf" "%INSTALL_DIR%"
    rmdir /S /Q "%TEMP%\skills-repo"
) else (
    echo 📂 Skill directory already exists, updating...
    cd /d "%INSTALL_DIR%"
    git pull 2>nul || echo ⚠️  Not a git repository, skipping update
)

cd /d "%INSTALL_DIR%"

REM Install Node.js dependencies
where npm >nul 2>nul
if %ERRORLEVEL% EQU 0 (
    echo 📦 Installing Node.js dependencies...
    call npm install
) else (
    echo ⚠️  npm not found, skipping dependency installation
)

REM Install Chrome for Puppeteer
where npx >nul 2>nul
if %ERRORLEVEL% EQU 0 (
    echo 🌐 Installing Chrome for PDF generation...
    call npx puppeteer browsers install chrome
) else (
    echo ⚠️  npx not found, skipping Chrome installation
)

echo.
echo ✅ Installation complete!
echo.
echo Usage:
echo   node tools/convert.js ^<file^> [--template ieee] [--pagebreak academic]
echo.
echo Run 'node tools/convert.js help' for more information

endlocal
pause
