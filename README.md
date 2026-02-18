# Quantum Fisher Information Toolbox

A MATLAB toolbox for exploring multipartite entanglement and quantum Fisher information (QFI).

## Project Status

This repository is under active structural refactoring. The canonical implementation lives under:

- `src/+QFIEntanglementToolbox`
- `src/+QFIEntanglementToolbox/+utils`

Internal implementation is now split into domain subpackages:

- `src/+QFIEntanglementToolbox/+states`
- `src/+QFIEntanglementToolbox/+hamiltonians`
- `src/+QFIEntanglementToolbox/+entanglement`
- `src/+QFIEntanglementToolbox/+qfi`
- `src/+QFIEntanglementToolbox/+linalg`

Top-level `QFIEntanglementToolbox.<Function>` names remain the stable public API.

Legacy root-level functions are kept as compatibility wrappers during the migration window and emit deprecation warnings.

## Installation

```matlab
addpath('path/to/QFI-Toolbox/src');
```

## Quickstart

```matlab
psi = QFIEntanglementToolbox.GHZState(4);
[maxF,varF,idx] = QFIEntanglementToolbox.stateQFI(psi, 100, 'uniform');
```

## API Modules

- States and operators: `GHZState`, `neelState`, `pureToMixed`, `stateEvolution`
- Hamiltonians: `heisenbergXXZ`, `randomHeisenbergJ`, `randomHeisenbergZ`
- Entanglement and QFI: `bipartiteEntanglement`, `multipartEntanglement`, `boundQFI`, `stateQFI`, `stateQFIManual`, `rhoQFI`
- Linear algebra and transforms: `PartialTrace`, `PartialTranspose`, `PermuteSystems`, `traceDistance`, `traceNorm`, `tensorSum`
- Utilities: `QFIEntanglementToolbox.utils.*`

See:

- `src/+QFIEntanglementToolbox/Contents.m`
- `src/+QFIEntanglementToolbox/+utils/Contents.m`
- `MIGRATION.md`
- `doc/API_INVENTORY.md`

## Dependencies

| Dependency | Required by | Notes |
|---|---|---|
| MATLAB (R2020a+) | entire toolbox | baseline target for this refactor |
| `kpNorm.m` (QETLAB, optional) | `QFIEntanglementToolbox.traceNorm` | used when available; numeric fallback uses SVD |

## Backward-Compatibility Policy

- Release `v1.x`: root-level APIs remain available as wrappers with warning ID `QFIEntanglementToolbox:DeprecatedRootAPI`.
- Planned removal: `v2.0.0`.
- Use package-qualified APIs now to avoid migration risk.

## Documentation and Examples

- Examples: `examples/`
- API docs generator: `doc/generate_api_docs.m`
- Release checks: `scripts/release_check.m`
- Legacy wrapper generator: `scripts/generate_legacy_wrappers.m`

## Testing Without MATLAB (GNU Octave)

You can validate core functionality with Octave smoke tests:

```bash
octave --quiet --eval "addpath('scripts'); release_check();"
```

This runs Octave-compatible checks and skips MATLAB-only steps (API publish and `.mltbx` packaging).

## Main Public APIs

- `QFIEntanglementToolbox.bipartiteEntanglement`
- `QFIEntanglementToolbox.heisenbergXXZ`
- `QFIEntanglementToolbox.phaseShiftEnsemble`
- `QFIEntanglementToolbox.phaseShiftGenerator`
- `QFIEntanglementToolbox.stateQFI`

## License

MIT, see `LICENSE`.
