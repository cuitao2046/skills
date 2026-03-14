@echo off
setlocal

set SKILL_NAME=md-to-pdf
set INSTALL_DIR=%USERPROFILE%\.claude\skills\%SKILL_NAME%

echo 🗑️  Removing Claude Skill: %SKILL_NAME%

REM Remove skill directory
if exist "%INSTALL_DIR%" (
    rmdir /S /Q "%INSTALL_DIR%"
    echo ✅ Skill removed successfully
) else (
    echo ⚠️  Skill directory not found: %INSTALL_DIR%
)

echo Done.

endlocal
pause
