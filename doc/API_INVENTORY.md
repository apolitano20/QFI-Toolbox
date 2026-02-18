# API Inventory

## Canonical source tree

- `src/+QFIEntanglementToolbox/*.m`
- `src/+QFIEntanglementToolbox/+utils/*.m`
- `src/+QFIEntanglementToolbox/+states/*.m`
- `src/+QFIEntanglementToolbox/+hamiltonians/*.m`
- `src/+QFIEntanglementToolbox/+entanglement/*.m`
- `src/+QFIEntanglementToolbox/+qfi/*.m`
- `src/+QFIEntanglementToolbox/+linalg/*.m`

## Legacy compatibility wrappers

Root-level `.m` files with legacy names now forward to package functions and emit:

- Warning ID: `QFIEntanglementToolbox:DeprecatedRootAPI`
- Planned removal: `v2.0.0`

## Duplicate core APIs converted to wrappers (26)

- `bipartiteEntanglement`
- `boundQFI`
- `densityMatrix`
- `entropy`
- `GHZState`
- `heisenbergXXZ`
- `JordanWignerTransformation`
- `localMagnetization`
- `multipartEntanglement`
- `neelState`
- `orderParameter`
- `PartialTrace`
- `PartialTranspose`
- `PermuteSystems`
- `phaseShiftEnsemble`
- `phaseShiftGenerator`
- `randomHeisenbergJ`
- `randomHeisenbergZ`
- `rhoQFI`
- `stateEvolution`
- `stateQFI`
- `stateQFImanual`
- `TensorSum`
- `traceDistance`
- `TraceNorm`
- `zeroTotalSpinLabel`

## Utility aliases converted to wrappers (8)

- `ByteSize` -> `QFIEntanglementToolbox.utils.ByteSize`
- `cleanMat` -> `QFIEntanglementToolbox.utils.cleanMat`
- `mkron` -> `QFIEntanglementToolbox.utils.mKron`
- `opt_args` -> `QFIEntanglementToolbox.utils.optArgs`
- `progressbar` -> `QFIEntanglementToolbox.utils.progressBar`
- `randpdf` -> `QFIEntanglementToolbox.utils.randPdf`
- `unique_perms` -> `QFIEntanglementToolbox.utils.uniquePerms`
- `vectarrow` -> `QFIEntanglementToolbox.utils.vectArrow`

## External dependency gates

- `kpNorm.m` is optional for `QFIEntanglementToolbox.traceNorm` (numeric fallback uses SVD)

## Test coverage status

- Existing tests retained: `test_cleanMat`, `test_densityMatrix`, `test_GHZState`, `test_mKron`
- Added smoke/parity tests:
  - `test_wrapper_parity`
  - `test_states_and_hamiltonians_smoke`
  - `test_linear_algebra_smoke`
  - `test_qfi_smoke`
