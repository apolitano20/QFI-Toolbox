function run_octave_smoke_tests()
%RUN_OCTAVE_SMOKE_TESTS Octave-compatible smoke tests for core toolbox APIs.
%
% This function is intentionally lightweight and avoids MATLAB-specific
% frameworks (e.g., matlab.unittest) so contributors can validate changes
% without a MATLAB license.

projectRoot = fileparts(fileparts(mfilename('fullpath')));
addpath(fullfile(projectRoot, 'src'));

% Legacy wrappers are intentionally exercised in a few parity checks below.
warning('off', 'QFIEntanglementToolbox:DeprecatedRootAPI');

fprintf('Running Octave smoke tests...\n');

% 1) State generators
ghz = QFIEntanglementToolbox.GHZState(3);
assert(isequal(size(ghz), [8, 1]), 'GHZState size check failed.');
assert(abs(norm(ghz) - 1) < 1e-10, 'GHZState normalization failed.');

neel = QFIEntanglementToolbox.neelState(4);
assert(isequal(size(neel), [16, 1]), 'neelState size check failed.');

% 2) Hamiltonian shape/hermiticity
hxxz = QFIEntanglementToolbox.heisenbergXXZ(3, 1.0);
assert(isequal(size(hxxz), [8, 8]), 'heisenbergXXZ size check failed.');
assert(norm(full(hxxz) - full(hxxz'), 'fro') < 1e-10, 'heisenbergXXZ hermiticity check failed.');

% 3) Entanglement/QFI basic paths
bounds = QFIEntanglementToolbox.boundQFI(6);
assert(numel(bounds) == 6, 'boundQFI output size check failed.');
assert(all(bounds >= 0), 'boundQFI non-negativity check failed.');

elevation = zeros(3, 1);
azimuth = (pi / 2) * ones(3, 1);
[maxFManual, varFManual, idxManual] = QFIEntanglementToolbox.stateQFIManual(ghz, elevation, azimuth);
assert(maxFManual >= 0, 'stateQFIManual maxF check failed.');
assert(varFManual >= 0, 'stateQFIManual varF check failed.');
assert(idxManual >= 1, 'stateQFIManual max index check failed.');

[maxF, varF, idx] = QFIEntanglementToolbox.stateQFI(ghz, 2, 'uniform');
assert(maxF >= 0, 'stateQFI maxF check failed.');
assert(varF >= 0, 'stateQFI varF check failed.');
assert(idx >= 1, 'stateQFI max index check failed.');

rho = ghz * ghz';
[maxFRho, varFRho] = QFIEntanglementToolbox.rhoQFI(rho, 2, 'uniform');
assert(maxFRho >= 0, 'rhoQFI maxF check failed.');
assert(varFRho >= 0, 'rhoQFI varF check failed.');

% 4) Linear algebra ops
psiBell = [1; 0; 0; 1] / sqrt(2);
rhoBell = psiBell * psiBell';
reduced = QFIEntanglementToolbox.PartialTrace(rhoBell, 2, [2 2]);
assert(norm(reduced - 0.5 * eye(2), 'fro') < 1e-10, 'PartialTrace Bell-state check failed.');

rhoPT = QFIEntanglementToolbox.PartialTranspose(rhoBell, 2, [2 2]);
assert(abs(trace(rhoPT) - trace(rhoBell)) < 1e-10, 'PartialTranspose trace check failed.');

permOut = QFIEntanglementToolbox.PermuteSystems((1:8)', [2 1 3], [2 2 2]);
assert(isequal(size(permOut), [8, 1]), 'PermuteSystems size check failed.');

distSelf = QFIEntanglementToolbox.traceDistance(ghz, ghz);
assert(abs(distSelf) < 1e-10, 'traceDistance identity check failed.');

% 5) Wrapper parity checks (legacy API compatibility)
ghzLegacy = GHZState(3);
assert(norm(ghzLegacy - ghz) < 1e-12, 'Legacy GHZState wrapper parity failed.');

a = [1 2; 3 4];
b = [0 1; 1 0];
mkronLegacy = mkron(a, b);
mkronPkg = QFIEntanglementToolbox.utils.mKron(a, b);
assert(norm(mkronLegacy - mkronPkg, 'fro') < 1e-12, 'Legacy mkron wrapper parity failed.');

fprintf('Octave smoke tests passed.\n');
end
