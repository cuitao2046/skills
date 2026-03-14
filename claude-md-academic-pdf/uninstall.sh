#!/bin/bash

SKILL_NAME="md-to-pdf"
INSTALL_DIR="$HOME/.claude/skills/$SKILL_NAME"

echo "🗑️  Removing Claude Skill: $SKILL_NAME"

# Remove skill directory
if [ -d "$INSTALL_DIR" ]; then
    rm -rf "$INSTALL_DIR"
    echo "✅ Skill removed successfully"
else
    echo "⚠️  Skill directory not found: $INSTALL_DIR"
fi

echo "Done."
