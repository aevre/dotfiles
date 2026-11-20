---
name: css-refactor
description: Refactor and semantically rename CSS, Less, and Vue component class names across a project, enforce the existing Stylelint configuration, and validate that all references and visual behavior remain intact. Use when asked to rename, normalize, audit, or clean up styles and class naming.
---

# CSS / Less Semantic Refactoring

## Objective

Refactor CSS and Less naming across the project to improve semantic accuracy, consistency, maintainability, and compliance with the repository's existing Stylelint rules.

The task includes:

- Understanding the actual meaning of each class from its usage and component context.
- Renaming misleading, vague, inconsistent, or redundant class names.
- Updating every affected reference across the project.
- Fixing Stylelint violations using the existing configuration.
- Preserving visual appearance, responsive behavior, and runtime functionality.

This is a code refactoring task, not a redesign.

## 1. Repository reconnaissance

Before editing anything:

1. Read the repository's contributor instructions, including applicable `AGENTS.md` files and other relevant project-specific guidance.
2. Inspect the actual package manager, scripts, framework, component structure, and styling conventions.
3. Locate the existing Stylelint configuration and all configuration extensions it relies on.
4. Identify the supported stylesheet formats, including Less, Vue single-file components, CSS Modules, scoped styles, and any preprocessor-specific features actually used by the repository.
5. Discover existing naming conventions instead of imposing a new convention without evidence.
6. Run the relevant existing lint commands to establish a baseline when feasible.
7. Inspect the Git working tree before making changes. Preserve unrelated user modifications.

Do not invent configuration files, scripts, dependencies, components, or architectural conventions.

## 2. Build semantic understanding before renaming

Determine the meaning of a class by examining:

- The component or page containing the class.
- The corresponding Vue template and rendered element hierarchy.
- The component's props, state, events, and computed values.
- The relationship between parent and child elements.
- The actual declarations, including layout, positioning, typography, appearance, and interaction states.
- Related components, shared styles, design tokens, and existing naming patterns.
- All references to the class throughout the repository.

Prefer names that express the element's responsibility or role rather than its current appearance or DOM position.

Examples:

- `.box1` → `.article-toc`
- `.left-content` → `.article-sidebar`, if it represents a sidebar rather than merely left-aligned content.
- `.blue-button` → `.submit-button`, if its responsibility is submitting a form.
- `.item2` → `.toolbar-action`, if it represents an action in a toolbar.
- `.wrapper` → a more specific name only when the actual responsibility is clear.

These are illustrative examples, not automatic replacements.

Do not infer semantics from a class name alone. If the available code does not establish a reliable meaning, retain the existing name or choose a conservative improvement.

## 3. Naming rules

Follow this priority order:

1. Existing repository conventions.
2. Explicit naming requirements in project documentation or configuration.
3. Established conventions for the framework and stylesheet architecture.
4. A consistent, semantic naming scheme for remaining cases.

When the project has no clear convention, use these principles:

- Prefer descriptive, lowercase kebab-case class names.
- Use nouns for components and elements, and meaningful modifiers for states or variants.
- Prefer domain-specific names over generic names such as `.container`, `.content`, `.inner`, `.box`, and `.item` when those names conceal important meaning.
- Keep names concise without sacrificing clarity.
- Avoid encoding transient presentation details such as colors, pixel positions, or DOM indexes into names unless they are genuine variants.
- Avoid redundant component prefixes and deeply nested names that merely reproduce the full DOM hierarchy.
- Keep related component classes consistent.
- Preserve meaningful state classes such as `.is-active`, `.is-loading`, or `.is-disabled` when they match existing conventions.
- Do not rename a class merely to make it different.
- Do not introduce BEM, CSS Modules, utility classes, or another naming architecture across the repository unless explicitly requested or already established by the project.

Treat the naming convention as a consistency constraint, not an excuse to rewrite unrelated styles.

## 4. Rename every affected reference

A rename is incomplete until all relevant definitions and usages have been updated.

Search for references in:

- `.less`, `.css`, and other applicable stylesheet files.
- Vue templates and `<style>` blocks.
- Static class attributes and dynamic `:class` bindings.
- JavaScript and TypeScript strings that reference selectors.
- `querySelector`, `querySelectorAll`, `closest`, and related DOM APIs.
- `classList` operations and event delegation.
- Tests, snapshots, fixtures, and component examples.
- Global styles, theme overrides, and cross-component selectors.
- Documentation or other source files where the old name is contractually significant.

Handle dynamic class construction carefully. Search-based replacement alone is insufficient when a class name is assembled from variables, computed values, or conditional expressions.

Use syntax-aware or targeted edits where possible. Avoid broad textual replacement that could alter unrelated identifiers, substrings, API fields, or user-visible text.

### Special cases

- Vue scoped styles: verify the matching template elements and any cross-component selectors.
- CSS Modules: update both the module definitions and all imported references.
- Dynamic classes: preserve every existing state and variant.
- Global styles: account for consumers outside the component being edited.
- Third-party integrations: preserve selectors that external libraries or APIs require.
- Animations: update relevant keyframe names and animation references only when they are part of the intended refactor.
- Tests: update assertions that depend on renamed classes without weakening their coverage.

Do not rename public or externally consumed selectors blindly.

## 5. Less and Stylelint compliance

Use the repository's actual Stylelint configuration as the source of truth.

1. Determine the correct Stylelint command from the existing package scripts and installed tooling.
2. Run linting against the affected files, then the broader supported scope.
3. Fix violations rather than suppressing them.
4. Use automatic fixes only when the tool's behavior is understood and the changes are appropriate.
5. Review all automatic fixes, especially changes to nested selectors, declaration order, Less variables, mixins, interpolation, and at-rules.
6. Manually fix remaining violations while preserving semantics.
7. Re-run Stylelint after the final edits.

Never:

- Disable rules simply to make the command pass.
- Add broad ignore patterns to hide violations.
- Weaken the existing configuration.
- Replace project-specific rules with a generic configuration.
- Remove necessary declarations or selectors solely to satisfy a lint rule.
- Claim success without running the relevant checks.

If an existing violation cannot be fixed safely, document the exact file, rule, and reason.

## 6. Preserve runtime and visual behavior

The following must remain intact unless explicitly requested otherwise:

- Layout, spacing, alignment, and positioning.
- Responsive breakpoints and mobile layouts.
- Hover, focus, active, disabled, and loading states.
- Transitions, animations, and keyframe behavior.
- Dark mode, light mode, and theme variables.
- Conditional rendering and dynamic class logic.
- Accessibility states and interaction behavior.
- Component boundaries and existing public interfaces.

Do not use this task as an opportunity to redesign components, reorganize the application, migrate styling frameworks, or refactor unrelated business logic.

If a class is genuinely redundant, remove it only after verifying that it has no consumers and that removing it does not change behavior.

## 7. Execution workflow

Perform the refactor in manageable batches.

### Phase A — Audit

- Inventory relevant style files and class definitions.
- Identify ambiguous or misleading names.
- Identify naming inconsistencies and actual lint violations.
- Trace important selectors to their templates and consumers.
- Establish the baseline and record existing failures.

### Phase B — Plan

For each proposed rename, establish:

- Current class name.
- Proposed class name.
- Evidence of its actual meaning.
- Files and references that must change.
- Potential conflicts or compatibility risks.

Resolve ambiguous cases conservatively rather than guessing.

### Phase C — Refactor

- Rename related classes in coherent groups.
- Update definitions and references together.
- Preserve component and state relationships.
- Avoid unrelated formatting or logic changes.

### Phase D — Validate

Run the applicable checks, using the repository's existing commands:

- Stylelint on changed files.
- Stylelint on the full intended scope.
- Type checking when relevant.
- Unit tests and component tests when available.
- Build or other project validation commands when practical.

Inspect the final diff for stale selectors, accidental replacements, unrelated changes, and unexplained removals.

Compare failures against the baseline. Do not report pre-existing failures as newly introduced, and do not claim a clean result when validation was incomplete.

### Phase E — Report

Summarize:

1. The scope of files and components examined.
2. The principal naming improvements.
3. Any naming decisions that remain uncertain.
4. The Stylelint rules or categories corrected.
5. Validation commands and their actual results.
6. Remaining failures, skipped checks, and compatibility concerns.

Distinguish clearly between checks that passed, checks that failed, and checks that were not run.

## 8. Completion criteria

The task is complete only when:

- Relevant classes have been evaluated for semantic accuracy.
- Intended renames are reflected in their definitions and references.
- No known stale references remain within the inspected scope.
- The existing Stylelint configuration is preserved.
- All relevant lint checks have been run and their results reported accurately.
- Available tests and builds have been run as appropriate.
- Unrelated user changes have been preserved.
- Unresolved issues and unverified behavior are explicitly documented.

Prioritize correctness and traceability over the number of renamed classes. A justified decision to retain a class name is preferable to an unsupported semantic guess.
