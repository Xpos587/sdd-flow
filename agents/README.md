# AI Agents

Specialized AI agents for Domain Flow methodology development tasks.

## Quick Setup

```bash
# Set target directory for symbolic links
export SYMLINKS_TARGET_DIR="~/your-project/.claude/agents"

# Create symbolic links for available agents
ln -s ./agents/context-analyzer.md $SYMLINKS_TARGET_DIR/context-analyzer.md
```

## Available Agents

| Agent              | Purpose                               |
| ------------------ | ------------------------------------- |
| `context-analyzer` | Domain-Driven Design context analysis |

## Usage

1. **Auto-invoked** when triggers are detected in conversation
2. **Manual invocation** for specific analysis tasks
3. **Integration** with development workflow
