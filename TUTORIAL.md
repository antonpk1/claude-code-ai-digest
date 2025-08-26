Thread:

Let's setup Claude Code SDK to send you daily AI news analysis report:

---

Stack:
Claude Code SDK - the agent (free if you have Claude subscription!)
Github Actions - the environment and scheduling (free up to ...)
Github Issues to send the reports (you can use Telegram or Email instead)
[optional] Playwright MCP - to include nice visuals (free)

[diagram.png]

---

Prerequisites: install Claude Code locally and supercharge it with Github MCP so it will do all the work for you:
$ npm install -g @anthropic-ai/claude-code
$ claude mcp add --transport http github https://api.githubcopilot.com/mcp/ --header "Authorization: Bearer $GITHUB_PAT"

(you can create a github PAT token here https://github.com/settings/tokens, make sure to enable repo, workflow and copilot scopes)

---
Prompt 1) read claude code sdk docs and create simple ./agent.sh script that generates a haiku. use claude setup-token auth method

Result: Claude will ask you to run "claude setup-token" (save the token for later!) and will iterate and test the script until it works!
[screenshot]

---

Prompt 2) allow WebSearch and file Write tools - make the ./agent.sh to write a haiku about CURRENT weather in London and write it to ./result.md file

Result: this is our first agentic web research!
[screenshot]


---

More automation! Let's ask Claude Code to automate it via github actions, you just need to give it either gh CLI or add Github MCP:

$ claude mcp add --transport http github https://api.githubcopilot.com/mcp/ --header "Authorization: Bearer $GITHUB_PAT"
(the github PAT token can be created here https://github.com/settings/tokens, make sure to enable repo, workflow and copilot scopes)

Prompt 3) use github MCP (or gh CLI) to ship current project into a new github repo and setup a workflow so we can trigger the agent.sh and save the result as a github issue. guide me how to add the required "CLAUDE_CODE_OAUTH_TOKEN" env. once ready, test the workflow to make sure it works!

Result: it might not work from the first time, just let claude iterate until you see actual issue created

[screenshot]

---

The "M" in the MCP stands for magic! Let's use Playwright MCP to render some visuals for our research.

Prompt 4) research how to use https://github.com/microsoft/playwright-mcp and how to install an MCP server into the claude code sdk using the --mcp-config option. The goal is to run it in headless mode, "720x480" viewport. The workflow agent should create ./index.html with awesome SVG visualisation of the haiku, then use playwright mcp to render it, attach the screenshot into the result issue.
Gotchas: Don't forget to add the playwright mcp to the allowed_tools as 'mcp__playwright__*', also you will have to commit the image into a separate branch to be able attaching it into the issue



---

So far we used haiku+weather task as a quick and cheap prompt while building.
Since everything works end to end now - it's time to make the research more useful.

Prompt 5) let's re-clarify our system from weather research and haiku to make a deep research in latest developments about AI. Update the prompts to find the most impactful latest AI news, products, papers. For the visual rendering, make a cool summary infographics, keep it concise and include photos/images when possible. The result issue should contain bullet points with links to sources and the visualisation screenshot. Rename the repository, workflow, files and update README accordingly - to not mention weather and haiku anymore.




Install github MCP

Set up a long-lived authentication token (requires Claude subscription), so we don't pay for Claude API usage!
$ claude setup-token
Save the token in ./.env