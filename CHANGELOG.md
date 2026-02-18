# Changelog

## Unreleased

- Refactor: root-level MATLAB APIs converted to deprecating compatibility wrappers.
- Refactor: added `scripts/legacy_wrapper_map.m` and `scripts/generate_legacy_wrappers.m` for wrapper generation.
- Refactor: canonical API standardized under `src/+QFIEntanglementToolbox` and `+utils`.
- Refactor: removed `de2bi` dependency from `randomHeisenbergZ` via local bit-conversion utility.
- Refactor: `traceNorm` now supports numeric fallback when `kpNorm.m` is unavailable.
- Docs: added migration guide (`MIGRATION.md`) and API inventory (`doc/API_INVENTORY.md`).
- Tests: expanded with wrapper parity and smoke tests across module categories.
- CI: added GitHub Actions workflow for Octave-based test execution.
- Tooling: added release check script (`scripts/release_check.m`).
