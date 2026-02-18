function release_check()
%RELEASE_CHECK Run basic release validation steps.
projectRoot = fileparts(fileparts(mfilename('fullpath')));
addpath(projectRoot);
addpath(fullfile(projectRoot, 'src'));
addpath(fullfile(projectRoot, 'doc'));
addpath(fullfile(projectRoot, 'scripts'));

disp('1) Running tests...');
run_tests();

if exist('OCTAVE_VERSION', 'builtin') ~= 0
    disp('2) Skipping API docs generation in Octave.');
    disp('3) Skipping toolbox packaging (.mltbx) in Octave.');
else
    disp('2) Generating API docs...');
    run(fullfile(projectRoot, 'doc', 'generate_api_docs.m'));

    disp('3) Packaging toolbox...');
    run(fullfile(projectRoot, 'package_QFIEntanglementToolbox.m'));
end

disp('Release checks completed successfully.');
end
