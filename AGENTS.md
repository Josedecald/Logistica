# AGENTS.md

## Repo Shape
- Godot 4 project. Open `project.godot`; the main scene is `scenes/Main.tscn`.
- Runtime logic is mostly in `autoloads/` and `Scripts/data/`.
- Game design docs live in `Documentos/`; treat them as intent, not source of truth if code disagrees.
- Generated rule resources live in `Scripts/data/rules_data/`.

## Key Entrypoints
- `autoloads/ClassificationManager.gd` loads every `.tres` rule from `Scripts/data/rules_data/`, sorts by `prioridad` then `descripcion`, and decides the correct destination for a `CaseFile`.
- `Scripts/tools/generar_reglas.gd` is an `EditorScript` meant to be run once from the Godot editor to regenerate rule `.tres` files.
- `Scripts/data/case_file.gd` is the core expediente model; scoring is computed from `IncidentePesos.PESO` plus modifiers.

## Working Rules
- Do not hand-edit generated rule assets unless you are intentionally changing shipped data; prefer updating `Scripts/tools/generar_reglas.gd` and regenerating.
- Keep `.uid` files and `.godot/` cache files out of edits; `.gitignore` already excludes the editor cache.
- If a doc conflicts with code, trust the code.

## Verification
- There are no repo-local automated test commands or build scripts in the repo root.
- For logic changes, verify by opening the project in Godot and running the relevant scene or editor script.

## Conventions
- ASCII-only is the safe default for new edits.
- The repo uses LF line endings and UTF-8.
