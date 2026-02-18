function map = legacy_wrapper_map()
%LEGACY_WRAPPER_MAP Mapping from legacy root functions to package APIs.
%   map is an Nx2 cell array:
%   {legacyFunctionName, packageQualifiedTarget}

map = {
    'bipartiteEntanglement',  'QFIEntanglementToolbox.bipartiteEntanglement'
    'boundQFI',               'QFIEntanglementToolbox.boundQFI'
    'ByteSize',               'QFIEntanglementToolbox.utils.ByteSize'
    'cleanMat',               'QFIEntanglementToolbox.utils.cleanMat'
    'densityMatrix',          'QFIEntanglementToolbox.densityMatrix'
    'entropy',                'QFIEntanglementToolbox.entropy'
    'GHZState',               'QFIEntanglementToolbox.GHZState'
    'heisenbergXXZ',          'QFIEntanglementToolbox.heisenbergXXZ'
    'JordanWignerTransformation', 'QFIEntanglementToolbox.JordanWignerTransformation'
    'localMagnetization',     'QFIEntanglementToolbox.localMagnetization'
    'mkron',                  'QFIEntanglementToolbox.utils.mKron'
    'multipartEntanglement',  'QFIEntanglementToolbox.multipartEntanglement'
    'neelState',              'QFIEntanglementToolbox.neelState'
    'opt_args',               'QFIEntanglementToolbox.utils.optArgs'
    'orderParameter',         'QFIEntanglementToolbox.orderParameter'
    'PartialTrace',           'QFIEntanglementToolbox.PartialTrace'
    'PartialTranspose',       'QFIEntanglementToolbox.PartialTranspose'
    'PermuteSystems',         'QFIEntanglementToolbox.PermuteSystems'
    'phaseShiftEnsemble',     'QFIEntanglementToolbox.phaseShiftEnsemble'
    'phaseShiftGenerator',    'QFIEntanglementToolbox.phaseShiftGenerator'
    'progressbar',            'QFIEntanglementToolbox.utils.progressBar'
    'pure_to_mixed',          'QFIEntanglementToolbox.pureToMixed'
    'randomHeisenbergJ',      'QFIEntanglementToolbox.randomHeisenbergJ'
    'randomHeisenbergZ',      'QFIEntanglementToolbox.randomHeisenbergZ'
    'randpdf',                'QFIEntanglementToolbox.utils.randPdf'
    'rhoQFI',                 'QFIEntanglementToolbox.rhoQFI'
    'stateEvolution',         'QFIEntanglementToolbox.stateEvolution'
    'stateQFI',               'QFIEntanglementToolbox.stateQFI'
    'stateQFImanual',         'QFIEntanglementToolbox.stateQFIManual'
    'TensorSum',              'QFIEntanglementToolbox.tensorSum'
    'traceDistance',          'QFIEntanglementToolbox.traceDistance'
    'TraceNorm',              'QFIEntanglementToolbox.traceNorm'
    'unique_perms',           'QFIEntanglementToolbox.utils.uniquePerms'
    'vectarrow',              'QFIEntanglementToolbox.utils.vectArrow'
    'zeroTotalSpinLabel',     'QFIEntanglementToolbox.zeroTotalSpinLabel'
    };
end
