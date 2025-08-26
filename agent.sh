#!/bin/bash

# Claude Code SDK Agent Script - Weather Haiku Generator
# This script uses Claude Code to check current London weather and write a haiku about it
# Supports both local use and GitHub Actions workflow with optional visualization

# Check if Claude Code is installed
if ! command -v claude &> /dev/null; then
    echo "Error: Claude Code is not installed."
    echo "Please install it with: npm install -g @anthropic-ai/claude-code"
    exit 1
fi

# Determine authentication method
if [ -n "$CLAUDE_CODE_OAUTH_TOKEN" ]; then
    echo "ℹ️  Using CLAUDE_CODE_OAUTH_TOKEN from environment"
else
    echo "ℹ️  Using Claude setup-token authentication (free with Claude subscription)"
    echo "   If not configured yet, run: claude setup-token"
fi

# Generate a weather haiku using Claude Code
echo "🌦️  Checking current weather in London and generating haiku..."
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

# Build the prompt based on whether visualization is requested
if [ "$WITH_VISUALIZATION" = "true" ]; then
    echo "📊 Visualization mode enabled"
    
    PROMPT="Search for the current weather in London, UK including temperature and conditions. 

Then do the following:
1. Create a beautiful haiku about the current weather and save it to ./result.md
2. Create an HTML file at ./index.html with a simple, artistic daily poster using SVG. Design it as:
   - A minimalist poster (720x480) with the haiku as the centerpiece
   - Include today's weather (temperature and condition) in a compact, stylish way
   - Use beautiful typography and colors that match the weather mood
   - Keep it simple and poster-like, not a detailed infographic
   - No charts or complex visualizations, just an artistic daily weather poster
3. Use Playwright MCP to navigate to file://\$PWD/index.html
4. Take a screenshot and save it as ./weather-visualization.png

Make the design clean, artistic, and suitable for daily sharing."
    
    ALLOWED_TOOLS="WebSearch,Write,mcp__playwright__*"
else
    PROMPT="Search for the current weather in London, UK right now. Then write a beautiful haiku about the current weather conditions in London. Save the haiku to a file called ./result.md with a nice markdown format including a title '# London Weather Haiku' and today's date."
    
    ALLOWED_TOOLS="WebSearch,Write"
fi

# Build the Claude command
CLAUDE_CMD="claude --print \"$PROMPT\" --output-format text --allowedTools \"$ALLOWED_TOOLS\" --permission-mode bypassPermissions"

# Add MCP config if provided
if [ -n "$MCP_CONFIG" ] && [ -f "$MCP_CONFIG" ]; then
    echo "📋 Using MCP config: $MCP_CONFIG"
    CLAUDE_CMD="$CLAUDE_CMD --mcp-config $MCP_CONFIG"
fi

# Execute the command
eval $CLAUDE_CMD

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