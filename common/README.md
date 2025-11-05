# Common Files

This folder contains shared preferences and helper prompts for AI coding agents. These files are referenced across various prompts (commands or subagents).

## Available Files

### Development Standards

- `development-standards.md` - Development standards and conventions (PEP 8, TypeScript, etc.)
- `testing-preferences.md` - Testing frameworks and testing conventions
- `running-services.md` - Service status checking
- `graph-schema.md` - GRAPH-TAG system documentation and schema

### Usage

Copy or create symlinks to the common files in your working project folder.

```bash
export SYMLINKS_TARGET_DIR="~/your-project/docs/common"
ln -s ./common/running-services.md $SYMLINKS_TARGET_DIR/
ln -s ./common/testing-preferences.md $SYMLINKS_TARGET_DIR/
ln -s ./common/development-standards.md $SYMLINKS_TARGET_DIR/
ln -s ./common/graph-schema.md $SYMLINKS_TARGET_DIR/
```

## Usage Tips

1. **Centralized Configuration** - All prompts reference these files for consistent behavior
2. **Easy Updates** - Update in one place, affects all prompts
3. **Project Consistency** - Ensure all developers use the same standards

## File Descriptions

### running-services.md

Helper prompt to instruct agents to check required service status before starting development work.

### testing-preferences.md

Preferences and conventions for the testing process, including testing tools, frameworks, and quality gates.

### development-standards.md

Development standards and conventions for the project, including coding style, naming conventions, and quality standards.

### graph-schema.md

GRAPH-TAG system documentation and schema for component tracking and dependency mapping in Domain-Driven Design architecture.
