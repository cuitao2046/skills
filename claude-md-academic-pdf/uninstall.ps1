#!/usr/bin/env pwsh

$SKILL_NAME = "md-to-pdf"
$INSTALL_DIR = Join-Path $HOME ".claude/skills/$SKILL_NAME"

Write-Host "🗑️  Removing Claude Skill: $SKILL_NAME" -ForegroundColor Cyan

# Remove skill directory
if (Test-Path $INSTALL_DIR) {
    Remove-Item -Path $INSTALL_DIR -Recurse -Force
    Write-Host "✅ Skill removed successfully" -ForegroundColor Green
} else {
    Write-Host "⚠️  Skill directory not found: $INSTALL_DIR" -ForegroundColor Yellow
}

Write-Host "Done."
