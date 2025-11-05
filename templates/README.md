# Domain Flow Templates

Document templates for Software Development Design Flow methodology.

## Quick Setup

```bash
# Set target directory for symbolic links
export SYMLINKS_TARGET_DIR="~/your-project/docs"

# Create symbolic links for all templates
ln -s ./templates/* $SYMLINKS_TARGET_DIR/
```

## Core Templates

| Phase          | Template                                   | Purpose                 |
| -------------- | ------------------------------------------ | ----------------------- |
| Discovery      | `1.1_initial_hypothesis.md`                | Initial idea formation  |
|                | `1.3_market_research_report.md`            | Market analysis         |
|                | `1.5_draft_customer_interview_insights.md` | Customer insights       |
|                | `1.5_draft_early_validation_report.md`     | Early validation        |
| Design         | `2_system_architecture.md`                 | System architecture     |
|                | `3_feature_roadmap.md`                     | Feature planning        |
|                | `5.1_functional_design.md`                 | User stories            |
|                | `5.3_technical_design.md`                  | Technical specification |
|                | `5.3_components.md`                        | Component architecture  |
|                | `5.3_components.yaml`                      | Component registry      |
|                | `5.3_transactions.yaml`                    | Transaction flows       |
|                | `5.4_domain_setup.md`                      | Domain isolation        |
| Implementation | `6.1_implementation_checklist.md`          | Task planning           |
|                | `6.1_implementation_plan.md`               | Work breakdown          |
|                | `6.2_bug_list.md`                          | Bug tracking            |
|                | `6.2_implementation_report.md`             | Progress reports        |
|                | `6.2_testing_plan.md`                      | Testing strategy        |
|                | `6.3_changes_list.md`                      | Change tracking         |
|                | `6.3_testing_report.md`                    | Test results            |

## Usage

1. **AI Agent Integration** - Templates are referenced in prompts
2. **Document Creation** - Copy and customize for specific projects
3. **Version Control** - Track document evolution

## File Structure

```tree
templates/
├── 1.*_discovery_templates.md      # Discovery phase
├── 2.*_design_templates.md          # System design
├── 3.*_planning_templates.md         # Feature planning
├── 5.*_design_templates.md          # Technical design
├── 6.*_implementation_templates.md   # Implementation
└── README.md                        # This file
```

## Customization

All templates support:

- **Technology stack** configuration
- **Project-specific** modifications
- **Domain adaptation** for different contexts
- **Domain Flow sequence** adherence
