# AI Coding Agent Prompts

This folder contains prompts for AI coding agents. Each prompt is a separate file designed for specific development tasks.

## Quick Start

**Option 1: Direct Prompt Usage**
- Copy prompt content to your LLM chat
- Attach template files from `templates/`
- Attach required documents

**Option 2: Claude Code Commands**
```bash
cd .claude/commands
ln -s /path/to/sdd-flow/prompts/1.1_initial_hypothesis.md hypothesis.md
ln -s /path/to/sdd-flow/prompts/2_system_architecture.md architecture.md
```

**Option 3: Custom Integration**
- Adapt prompts for your specific AI tool
- Modify technology stack in `<TECH_STACK_PREFERENCES>` sections
- Adjust templates to match your project structure

## Core Prompts

### 🎯 Discovery & Concept
- `1.1_initial_hypothesis.md` - Initial idea formation
- `1.3_market_research_report.md` - Market analysis

### 🏗️ System Design
- `2_system_architecture.md` - Technology stack and architecture

### 📋 Planning
- `3_feature_roadmap.md` - Feature breakdown and prioritization

### 🎨 Design
- `5.1_functional_design.md` - User stories and workflows
- `5.3_technical_design.md` - Component architecture (NEW 3-file approach)
- `5.3_technical_design_review.md` - Design validation
- `5.3._technical_design_lint.md` - Consistency checking
- `5.4_domain_setup.md` - Domain isolation setup (NEW)

### 🛠️ Implementation
- `6.1_implementation_plan.md` - Domain-based task planning
- `6.2_code_implementation.md` - Code execution
- `6.2_code_review.md` - Code quality checks

### 🧪 Testing
- `6.3_testing.md` - Test execution and validation
- `6.3_fix_bug.md` - Bug resolution
- `6.3_fix_test.md` - Test fixing

## Technology Customization

Each prompt allows technology stack customization. Key areas:
- **Frontend**: React/Next.js/TypeScript/etc
- **Backend**: FastAPI/Django/etc
- **Database**: PostgreSQL/MongoDB/etc
- **Tools**: npm/bun, pytest/jest, etc

## Templates

Corresponding templates in `templates/` folder:
- `1.1_initial_hypothesis.md`
- `2_system_architecture.md`
- `5.1_functional_design.md`
- `5.3_components.md`, `5.3_components.yaml`, `5.3_transactions.yaml`
- `5.4_domain_setup.md`
- `6.1_implementation_checklist.md`
- `6.2_bug_list.md`, `6.3_changes_list.md`

## Usage Tips

1. **Start with Step 1.1** for any new project
2. **Customize technology stack** in Step 2 based on your needs
3. **Use Step 5.4** for domain-based development
4. **Validate regularly** with lint and review prompts