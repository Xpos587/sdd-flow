# Domain Flow Prompts

AI coding prompts for Software Development Design Flow methodology.

## Quick Setup

```bash
# Set target directory for symbolic links
export SYMLINKS_TARGET_DIR="~/your-project/.claude/commands"

# Create symbolic links for all available prompts
ln -s ./prompts/1.1_initial_hypothesis.md $SYMLINKS_TARGET_DIR/hypothesis.md
ln -s ./prompts/1.3_market_research_report.md $SYMLINKS_TARGET_DIR/market-research.md
ln -s ./prompts/2_system_architecture.md $SYMLINKS_TARGET_DIR/architecture.md
ln -s ./prompts/2_system_architecture_review.md $SYMLINKS_TARGET_DIR/architecture-review.md
ln -s ./prompts/3_feature_roadmap.md $SYMLINKS_TARGET_DIR/roadmap.md
ln -s ./prompts/5.1_functional_design.md $SYMLINKS_TARGET_DIR/functional-design.md
ln -s ./prompts/5.3_technical_design.md $SYMLINKS_TARGET_DIR/tech-design.md
ln -s ./prompts/5.3_technical_design_review.md $SYMLINKS_TARGET_DIR/tech-review.md
ln -s ./prompts/5.3_technical_design_lint.md $SYMLINKS_TARGET_DIR/tech-lint.md
ln -s ./prompts/5.4_domain_setup.md $SYMLINKS_TARGET_DIR/domain-setup.md
ln -s ./prompts/6.1_implementation_plan.md $SYMLINKS_TARGET_DIR/plan.md
ln -s ./prompts/6.1_implementation_plan_review.md $SYMLINKS_TARGET_DIR/plan-review.md
ln -s ./prompts/6.2_code_implementation.md $SYMLINKS_TARGET_DIR/do.md
ln -s ./prompts/6.2_code_review.md $SYMLINKS_TARGET_DIR/code-review.md
ln -s ./prompts/6.3_testing.md $SYMLINKS_TARGET_DIR/test.md
ln -s ./prompts/6.3_fix_bug.md $SYMLINKS_TARGET_DIR/fix-bug.md
ln -s ./prompts/6.3_fix_test.md $SYMLINKS_TARGET_DIR/fix-test.md
```

## Core Workflow

| Phase     | Prompt                            | Purpose                |
| --------- | --------------------------------- | ---------------------- |
| Discovery | `1.1_initial_hypothesis.md`       | Initial idea formation |
|           | `1.3_market_research_report.md`   | Market analysis        |
| Design    | `2_system_architecture.md`        | System architecture    |
|           | `2_system_architecture_review.md` | Architecture review    |
| Planning  | `3_feature_roadmap.md`            | Feature planning       |
|           | `5.1_functional_design.md`        | User stories           |
|           | `5.3_technical_design.md`         | Component architecture |
| Setup     | `5.4_domain_setup.md`             | Domain isolation       |
| Planning  | `6.1_implementation_plan.md`      | Task breakdown         |
| Code      | `6.2_code_implementation.md`      | Code execution         |
| Test      | `6.3_testing.md`                  | Test execution         |

## Quality & Review

| Prompt                              | Purpose              |
| ----------------------------------- | -------------------- |
| `5.3_technical_design_review.md`    | Design validation    |
| `5.3_technical_design_lint.md`      | Consistency checking |
| `6.1_implementation_plan_review.md` | Plan validation      |
| `6.2_code_review.md`                | Code quality         |
| `6.3_fix_bug.md`                    | Bug resolution       |
| `6.3_fix_test.md`                   | Test fixing          |

## Usage

1. **Copy prompt content** to your AI tool
2. **Attach relevant templates** from `templates/`
3. **Customize technology stack** in prompts
4. **Follow Domain Flow sequence**: 1.1 → 1.3 → 2 → 3 → 5.1 → 5.3 → 5.4 → 6.1 → 6.2 → 6.3

## Templates

Corresponding templates in `templates/`:

- `5.3_components.md`, `5.3_components.yaml`, `5.3_transactions.yaml`
- `5.4_domain_setup.md`
- `6.1_implementation_checklist.md`
- `6.2_bug_list.md`, `6.3_changes_list.md`
