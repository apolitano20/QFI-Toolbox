% PACKAGE_QFIENTANGLEMENTTOOLBOX Build the .mltbx package.
%
% Run from project root:
%   >> package_QFIEntanglementToolbox

try
    disp('Starting toolbox packaging process...');

    opts = matlab.addons.toolbox.ToolboxOptions('.', 'QFIEntanglementToolbox');

    opts.ToolboxName = 'QFI Entanglement Toolbox';
    opts.ToolboxVersion = '1.1.0';

    opts.AuthorName = 'Andrea Politano';
    opts.AuthorCompany = 'Independent';
    opts.AuthorEmail = 'a.politano20@gmail.com';

    opts.Summary = 'MATLAB toolbox for QFI and multipartite entanglement.';
    opts.Description = ['A MATLAB toolbox for multipartite entanglement and quantum Fisher information. ' ...
                        'This release introduces a package-first API with legacy compatibility wrappers.'];

    opts.ToolboxMatlabPath = {'src'};
    opts.ToolboxGettingStartedGuide = 'README.md';
    opts.ToolboxExampleLocations = {'examples'};
    opts.MinimumMatlabRelease = 'R2020a';

    opts.OutputFile = 'QFIEntanglementToolbox.mltbx';

    disp(['Creating toolbox package: ', opts.OutputFile, '...']);
    matlab.addons.toolbox.packageToolbox(opts);
    disp(['Successfully created ', opts.OutputFile, ' in ', pwd]);

catch ME
    disp('Error during toolbox packaging:');
    disp(['Identifier: ', ME.identifier]);
    disp(['Message: ', ME.message]);
    for k = 1:numel(ME.stack)
        disp(ME.stack(k));
    end
    error('Toolbox packaging failed.');
end
