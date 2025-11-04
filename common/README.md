# Common Files

This folder contains shared preferences and helper prompts for AI coding agents. These files are referenced across various prompts (commands or subagents).

## Available Files

### Development Standards

- `development-standards.md` - Development standards and conventions (PEP 8, TypeScript, etc.)
- `testing-preferences.md` - Testing frameworks and testing conventions
- `running-services.md` - Service status checking
- `current-task-context.md` - Phase and step extraction for agent context

### Usage

Copy or create symlinks to the common files in your working project folder.

```bash
cd <your_project_folder>/docs/common

ln -s /mnt/f/AICoding/common/current-task-context.md \
ln -s /mnt/f/AICoding/common/running-services.md \
ln -s /mnt/f/AICoding/common/testing-preferences.md \
ln -s /mnt/f/AICoding/common/development-standards.md
```

## Usage Tips

1. **Centralized Configuration** - All prompts reference these files for consistent behavior
2. **Easy Updates** - Update in one place, affects all prompts
3. **Project Consistency** - Ensure all developers use the same standards

## File Descriptions

### current-task-context.md

Helper prompt for extracting current task context from `task_context.ini` file, enabling AI agents to understand which phase and step they're currently working on.

### running-services.md

Helper prompt to instruct agents to check required service status before starting development work.

### testing-preferences.md

Preferences and conventions for the testing process, including testing tools, frameworks, and quality gates.

### development-standards.md

Development standards and conventions for the project, including coding style, naming conventions, and quality standards.
