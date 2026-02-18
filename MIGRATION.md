# Migration Guide

This document maps legacy root-level function names to canonical package APIs.

## Timeline

- `v1.x`: legacy wrappers remain available and warn.
- `v2.0.0`: legacy root-level wrappers planned for removal.

## Function Mapping

| Legacy root-level | Canonical package function |
|---|---|
| `bipartiteEntanglement` | `QFIEntanglementToolbox.bipartiteEntanglement` |
| `boundQFI` | `QFIEntanglementToolbox.boundQFI` |
| `densityMatrix` | `QFIEntanglementToolbox.densityMatrix` |
| `entropy` | `QFIEntanglementToolbox.entropy` |
| `GHZState` | `QFIEntanglementToolbox.GHZState` |
| `heisenbergXXZ` | `QFIEntanglementToolbox.heisenbergXXZ` |
| `JordanWignerTransformation` | `QFIEntanglementToolbox.JordanWignerTransformation` |
| `localMagnetization` | `QFIEntanglementToolbox.localMagnetization` |
| `multipartEntanglement` | `QFIEntanglementToolbox.multipartEntanglement` |
| `neelState` | `QFIEntanglementToolbox.neelState` |
| `orderParameter` | `QFIEntanglementToolbox.orderParameter` |
| `PartialTrace` | `QFIEntanglementToolbox.PartialTrace` |
| `PartialTranspose` | `QFIEntanglementToolbox.PartialTranspose` |
| `PermuteSystems` | `QFIEntanglementToolbox.PermuteSystems` |
| `phaseShiftEnsemble` | `QFIEntanglementToolbox.phaseShiftEnsemble` |
| `phaseShiftGenerator` | `QFIEntanglementToolbox.phaseShiftGenerator` |
| `pure_to_mixed` | `QFIEntanglementToolbox.pureToMixed` |
| `randomHeisenbergJ` | `QFIEntanglementToolbox.randomHeisenbergJ` |
| `randomHeisenbergZ` | `QFIEntanglementToolbox.randomHeisenbergZ` |
| `rhoQFI` | `QFIEntanglementToolbox.rhoQFI` |
| `stateEvolution` | `QFIEntanglementToolbox.stateEvolution` |
| `stateQFI` | `QFIEntanglementToolbox.stateQFI` |
| `stateQFImanual` | `QFIEntanglementToolbox.stateQFIManual` |
| `TensorSum` | `QFIEntanglementToolbox.tensorSum` |
| `traceDistance` | `QFIEntanglementToolbox.traceDistance` |
| `TraceNorm` | `QFIEntanglementToolbox.traceNorm` |
| `zeroTotalSpinLabel` | `QFIEntanglementToolbox.zeroTotalSpinLabel` |
| `ByteSize` | `QFIEntanglementToolbox.utils.ByteSize` |
| `cleanMat` | `QFIEntanglementToolbox.utils.cleanMat` |
| `mkron` | `QFIEntanglementToolbox.utils.mKron` |
| `opt_args` | `QFIEntanglementToolbox.utils.optArgs` |
| `progressbar` | `QFIEntanglementToolbox.utils.progressBar` |
| `randpdf` | `QFIEntanglementToolbox.utils.randPdf` |
| `unique_perms` | `QFIEntanglementToolbox.utils.uniquePerms` |
| `vectarrow` | `QFIEntanglementToolbox.utils.vectArrow` |
