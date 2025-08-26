#!/bin/bash

# Claude Code SDK Agent Script - Weather Haiku Generator
# This script uses Claude Code to check current London weather and write a haiku about it
# Uses claude setup-token for authentication (requires Claude subscription)

# Check if Claude Code is installed
if ! command -v claude &> /dev/null; then
    echo "Error: Claude Code is not installed."
    echo "Please install it with: npm install -g @anthropic-ai/claude-code"
    exit 1
fi

# Check if Claude setup-token is configured
# The token is stored in Claude's configuration after running 'claude setup-token'
echo "ℹ️  Using Claude setup-token authentication (free with Claude subscription)"
echo "   If not configured yet, run: claude setup-token"

# Generate a weather haiku using Claude Code with WebSearch and file editing capabilities
echo "🌦️  Checking current weather in London and generating haiku..."
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

# Run Claude Code with WebSearch and Write tools enabled
# It will search for current weather in London and write a haiku to result.md
claude --print "Search for the current weather in London, UK right now. Then write a beautiful haiku about the current weather conditions in London. Save the haiku to a file called ./result.md with a nice markdown format including a title '# London Weather Haiku' and today's date." \
    --output-format text \
    --allowedTools "WebSearch,Write" \
    --permission-mode bypassPermissions

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "✨ Weather haiku generated and saved to ./result.md!"
echo ""
echo "📄 Content of result.md:"
echo "------------------------"
if [ -f ./result.md ]; then
    cat ./result.md
else
    echo "⚠️  File not created yet. Please check if the command ran successfully."
fi