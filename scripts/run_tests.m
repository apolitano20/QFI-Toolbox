function results = run_tests()
%RUN_TESTS Run toolbox test suite.
projectRoot = fileparts(fileparts(mfilename('fullpath')));
addpath(fullfile(projectRoot, 'src'));
addpath(fullfile(projectRoot, 'tests'));

if exist('OCTAVE_VERSION', 'builtin') ~= 0
    % Octave does not support matlab.unittest; run smoke checks instead.
    run_octave_smoke_tests();
    results = true;
    return;
end

results = runtests(fullfile(projectRoot, 'tests'));
assertSuccess(results);
end
