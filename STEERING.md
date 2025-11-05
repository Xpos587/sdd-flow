# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

<CURRENT_TASK_CONTEXT>

## Required Reading Before Work

**Before starting any work, you MUST:**

1. **Discover all domains** in the project using dynamic domain discovery
2. **Read the `Context.toml` file** in your assigned domain folder to understand current context
3. **Confirm understanding** by stating:
   - Current epic: {current_epic}
   - Current step: {current_step}
   - Current domain: {current_domain}
   - Current dev stage: {current_dev_stage}

Only proceed with tasks after confirming full context understanding.

## Dynamic Domain Discovery

**Simple command to discover all domains:**

```bash
# Find all domains and their configurations
for file in $(fd -e toml Context.toml); do
    echo ">>>> $file"
    dasel -f "$file" -r toml '.'
done
```

## Context.toml Format

```toml
[domain]
name = "{DOMAIN_NAME}"

[workflow]
current_epic = "{EPIC_NAME}"
current_step = "{STEP_NUMBER}"
current_domain = "{DOMAIN_NAME}"
current_dev_stage = "{STAGE_NAME}"
```

## Domain Work Rules

**Your domain boundaries are:**

- **Allowed folders:** `src/backend/domains/{YOUR_DOMAIN}/`, `src/frontend/domains/{YOUR_DOMAIN}/`, `src/shared/dto/{YOUR_DOMAIN}/`, `docs/domains/{YOUR_DOMAIN}/`
- **Read-only access:** `src/shared/dto/Y/`, `docs/domains/Y/` for other domains Y
- **Forbidden:** cross-domain imports, direct DB access, bypassing handlers

## GRAPH_TAG System

```python
#GRAPH_TAG: Component=F{DOMAIN_NUMBER}.1.ComponentName
#GRAPH_TAG: Handler=H-F{DOMAIN_NUMBER}.1.ComponentName.MethodName
```

## 4 DTO Pattern

Each handler must have 4 DTOs:

1. Frontend Request DTO (camelCase)
2. Backend Request DTO (snake_case)
3. Backend Response DTO (snake_case)
4. Frontend Response DTO (camelCase)

## Forbidden Actions

- **cross_domain_imports** - Don't import from other domains
- **direct_db_access** - Don't access database directly
- **bypass_handler_calls** - Don't bypass defined handlers

</CURRENT_TASK_CONTEXT>

<PROJECT_DOCUMENTATION>

All the project documentation is in the docs/ directory, number prefix of the documents corresponds to the step in the methodology.

## Whole Project Documentation

- **Project Overview:** `docs/1.4_concept.md`
- **System Architecture:** `docs/2_system_architecture.md`
- **Feature Roadmap:** `docs/3_feature_roadmap.md`
- **Functional Design:** `docs/5.1_functional_design.md`
- **Technical Design:**
  - `docs/5.3_components.md` - Component architecture diagrams
  - `docs/5.3_components.yaml` - Component registry with handlers and DTOs
  - `docs/5.3_transactions.yaml` - Transaction flows between components
- **Deployment Architecture:** `docs/4_deployment_architecture.md` (TBD)

## Domain-Specific Documentation

For each domain (auth, profile, billing, notification, admin, etc.):

- **Implementation Checklist:** `docs/<domain_name>/implementation_checklist.md`
- **Bug List:** `docs/<domain_name>/bug_list.md`
- **Changes List:** `docs/<domain_name>/changes_list.md`

**Example domains:** auth, profile, billing, notification, admin

</PROJECT_DOCUMENTATION>

<PROJECT_STRUCTURE>

```tree
Root/
├── src/
│   ├── backend/domains/           # Backend domain implementations
│   ├── frontend/domains/          # Frontend domain implementations
│   └── shared/dto/               # Shared DTOs
├── docs/                          # Comprehensive project documentation
│   ├── 1.4_concept.md             # Project concept and requirements
│   ├── 2_system_architecture.md   # System architecture overview
│   ├── 3_feature_roadmap.md       # Feature roadmap
│   ├── 5.1_functional_design.md   # Functional design specification
│   ├── 5.3_components.md          # Component architecture diagrams
│   ├── 5.3_components.yaml        # Component registry
│   ├── 5.3_transactions.yaml      # Transaction flows
│   ├── auth/                      # Domain-specific documentation
│   │   ├── implementation_checklist.md
│   │   ├── bug_list.md
│   │   └── changes_list.md
│   ├── profile/                   # Domain-specific documentation
│   │   ├── implementation_checklist.md
│   │   ├── bug_list.md
│   │   └── changes_list.md
│   ├── billing/                   # Domain-specific documentation
│   │   ├── implementation_checklist.md
│   │   ├── bug_list.md
│   │   └── changes_list.md
│   └── ...                        # Other domain folders
└── CLAUDE.md                      # AI agent instructions
```

</PROJECT_STRUCTURE>

<GENERAL_CODE_PREFERENCES>

## Core Principles

- **Always carefully read** the project docs in /docs folder
- **Always prefer simple solutions** - Very important! Do not overcomplicate things!
- **Propose minimal changes** - Introduce as few code changes as possible
- **Pay attention to concerns separation**
- **Focus on relevant areas** - Do not touch unrelated code
- **Avoid code duplication** - Check for existing similar code/functionality
- **Make only requested changes** - Be confident changes are well-understood
- **Keep codebase clean and organized**

## Implementation Guidelines

### Code Quality

- **File size limits:** Avoid files over 400-500 lines. Refactor at that point
- **Reuse existing code** before creating new implementations
- **Remove old implementations** when introducing new patterns
- **Use external icon libraries** (@radix-ui/react-icons) for standard UI actions
- **Do not create custom SVG tags** for standard actions (delete, save, send, etc.)

### Documentation & Updates

- **Always update CLAUDE.md** - Project Structure section when making changes (add, remove, rename files or folders)
- **Validate component references** through AI review for technical design files (5.3_components.md, 5.3_components.yaml, 5.3_transactions.yaml)
- **Use domain-based organization** for implementation tasks
- **Track progress** in appropriate domain folders (auth/, profile/, billing/, etc.)

### External Dependencies

- **Use Context7 MCP** for up-to-date docs on external frameworks
- **Stop execution** if commands require sudo - ask for manual execution

### Critical Reminders

- **AVOID CODE DUPLICATION** - Reuse existing code with minimal updates
- **MAKE MINIMAL CHANGES** - Produce minimal new code! VERY IMPORTANT!
- **Fix issues with existing patterns** before introducing new ones

</GENERAL_CODE_PREFERENCES>

<AVOID_SYCOPHANCY>

## Principle

Sycophancy erodes trust. The assistant exists to help the user, not flatter them or agree with them all the time.

## Guidelines

### Objective Questions

- **Factual aspects should not differ** based on question phrasing
- **Do not change stance** solely to agree with the user
- **May acknowledge or empathize** with user's perspective, but maintain objectivity

### Subjective Questions

- **Articulate interpretations and assumptions**
- **Provide thoughtful rationale**
- **Act as a sounding board** for ideas, not a sponge for praise
- **Provide constructive feedback** when critiquing ideas or work

### Direct Instructions

- **Do not agree all the time**
- **Criticize ideas and solutions**
- **Implement only if confident** it's a good idea

</AVOID_SYCOPHANCY>
