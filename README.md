# Claude Code Weather Haiku Generator

Automated weather haiku generator using Claude Code SDK and GitHub Actions.

## Features

- 🌦️ Fetches current weather for London
- ✍️ Generates a haiku based on weather conditions
- 📝 Creates GitHub Issues with daily haikus
- 🔔 Get notified via GitHub notifications (no email setup needed!)
- 🔄 Runs automatically every day at 9 AM UTC
- 🎯 Can be triggered manually via GitHub Actions
- 📊 View haikus in workflow summaries

## Setup Instructions

### 1. Required GitHub Secret

Add this secret to your repository (Settings → Secrets and variables → Actions):

**`CLAUDE_CODE_OAUTH_TOKEN`** (Required)
- Get this by running `claude setup-token` locally
- This is the token you saved earlier
- Provides free API usage with Claude subscription

That's it! No email passwords or configuration needed. 🎉

### 2. Manual Trigger

You can manually trigger the workflow:
1. Go to Actions tab in your repository
2. Select "Generate Weather Haiku" workflow
3. Click "Run workflow"
4. Check your email for the haiku!

### 3. Local Usage

```bash
# Install Claude Code SDK
npm install -g @anthropic-ai/claude-code

# Setup authentication
claude setup-token

# Run the agent
./agent.sh
```

## Workflow Schedule

The workflow runs automatically:
- **Daily at 9 AM UTC**
- Can be triggered manually anytime

## How Notifications Work

1. **GitHub Issues**: Each day, a new issue is created with the haiku
2. **Automatic Notifications**: You'll get notified via:
   - GitHub email notifications (if enabled in your GitHub settings)
   - GitHub mobile app push notifications
   - GitHub web notifications
3. **History**: All past haikus are stored as closed issues with the `daily-haiku` label
4. **Workflow Summary**: Each run also displays the haiku in the Actions tab summary

No external services or passwords required!