#!/bin/bash

# Claude Code SDK Agent Script - AI News Digest
# This script uses Claude Code to research latest AI developments and create a digest
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

# Generate an AI news digest using Claude Code
echo "🤖  Researching latest AI developments and generating digest..."
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

# Build the prompt based on whether visualization is requested
if [ "$WITH_VISUALIZATION" = "true" ]; then
    echo "📊 Visualization mode enabled"
    
    PROMPT="Search for the latest AI developments from the last 24-48 hours. Focus on:
- Breaking AI news and announcements
- New AI product launches and major updates
- Important research papers or breakthroughs
- Industry trends and analysis
- Major company announcements (OpenAI, Anthropic, Google, Meta, etc.)

Then do the following:
1. Create a structured digest and save it to ./result.md with:
   - Title: '# 🤖 AI Digest - [Today's Date]'
   - Sections: Latest Developments, Product Launches, Research Papers, Industry Trends
   - Each item as a bullet point with source link
   - Keep it concise but informative

2. Create an HTML file at ./index.html with a professional AI news infographic using SVG:
   - Modern, clean design (720x480)
   - Highlight 3-5 key stories visually
   - Use icons/logos where appropriate (tech company logos, AI symbols)
   - Include a small data visualization if relevant (trend chart, comparison, etc.)
   - Professional color scheme (blues, purples, teals)
   - Title: 'AI Digest' with today's date

3. Use Playwright MCP to navigate to file://\$PWD/index.html
4. Take a screenshot and save it as ./ai-digest-visualization.png

Ensure all information includes source attribution and links."
    
    ALLOWED_TOOLS="WebSearch,Write,mcp__playwright__*"
else
    PROMPT="Search for the latest AI developments from the last 24-48 hours including breaking news, product launches, and research papers. Create a structured digest with bullet points and source links. Save it to ./result.md with title '# 🤖 AI Digest - [Today's Date]' and sections for different categories."
    
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
echo "✨ AI digest generated and saved to ./result.md!"
echo ""
echo "📄 Content of result.md:"
echo "------------------------"
if [ -f ./result.md ]; then
    cat ./result.md
else
    echo "⚠️  File not created yet. Please check if the command ran successfully."
fi