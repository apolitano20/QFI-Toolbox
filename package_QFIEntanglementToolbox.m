% PACKAGE_QFIENTANGLEMENTTOOLBOX Script to package the QFIEntanglementToolbox
% into an .mltbx (MATLAB Toolbox) file.
%
% This script automates the process of creating a distributable MATLAB toolbox
% package. The .mltbx file can then be easily shared and installed by other
% MATLAB users.
%
% How to use:
% 1. Open MATLAB.
% 2. Ensure your current MATLAB directory is the root of the 
%    QFIEntanglementToolbox project (i.e., the directory containing this 
%    script and the 'src', 'examples', etc. folders).
% 3. Run this script from the MATLAB command window:
%    >> package_QFIEntanglementToolbox
% 4. Upon successful completion, a file named 'QFIEntanglementToolbox.mltbx'
%    will be generated in the project root directory.
%
% Note: This script requires MATLAB R2014b or later, as it uses
% matlab.addons.toolbox.ToolboxOptions and matlab.addons.toolbox.packageToolbox.

% Script to package the QFIEntanglementToolbox into an .mltbx file
% This script uses matlab.addons.toolbox.ToolboxOptions and packageToolbox

try
    disp('Starting toolbox packaging process...');

    % Define toolbox options
    % The first argument to ToolboxOptions is the root folder of the toolbox contents.
    % In this case, '.' refers to the current directory (project root).
    % The second argument is an internal name or identifier, often the main package name.
    opts = matlab.addons.toolbox.ToolboxOptions('.', 'QFIEntanglementToolbox'); 

    % --- General Information ---
    opts.ToolboxName = 'QFI Entanglement Toolbox';
    opts.ToolboxVersion = '1.0.0'; % Initial version (can be updated per release)

    % Author information
    opts.AuthorName = 'Andrea Politano and The Refactoring Agent'; % Original author and agent contribution
    opts.AuthorCompany = 'GitHub Community'; % Placeholder or actual affiliation
    opts.AuthorEmail = 'a.politano20@gmail.com'; % Email from original scripts

    % Description for the toolbox
    opts.Description = ['A MATLAB toolbox for exploring and manipulating multipartite entanglement and quantum Fisher information. ' ...
                        'This version has been refactored for improved structure and usability, including organization into MATLAB packages.'];
    opts.Summary = 'Toolbox for Quantum Fisher Information and Multipartite Entanglement calculations.';

    % --- Content ---
    % Add the 'src' directory. MATLAB's packaging tools will discover the 
    % +QFIEntanglementToolbox package structure within 'src/'.
    % All .m files, Contents.m files, and sub-packages within 'src' that are part of 
    % the QFIEntanglementToolbox package will be included.
    opts.ToolboxMatlabPath = {'src'}; 

    % Specify the main help file / Getting Started Guide.
    % This file will be prominently displayed to users after installation.
    % README.md is a good candidate. It will be included in the toolbox package.
    opts.ToolboxGettingStartedGuide = 'README.md'; 

    % --- Examples ---
    % Add the 'examples' folder to include example scripts.
    opts.ToolboxExampleLocations = {'examples'};

    % --- Limitations / Requirements (Optional but good practice) ---
    % Specify minimum MATLAB release if known (e.g., due to specific functions used).
    % opts.MinimumMatlabRelease = 'R2020a'; 
    
    % Specify supported platforms (e.g., 'win64', 'maci64', 'glnxa64').
    % opts.SupportedPlatforms = {'win64', 'maci64', 'glnxa64'}; 

    % --- Output File ---
    % Define the output file name for the toolbox package.
    outputFileName = 'QFIEntanglementToolbox.mltbx';
    opts.OutputFile = outputFileName;

    % --- Package the toolbox ---
    disp(['Creating toolbox package: ' outputFileName '...']);
    matlab.addons.toolbox.packageToolbox(opts);
    disp(['Successfully created ' outputFileName ' in the current directory: ' fullfile(pwd, outputFileName)]);
    disp('This .mltbx file can be used to install the toolbox in MATLAB.');

catch ME
    disp('Error during toolbox packaging:');
    disp(['Identifier: ' ME.identifier]);
    disp(['Message: ' ME.message]);
    disp('Stack trace:');
    for k_stack = 1:length(ME.stack)
        disp(ME.stack(k_stack));
    end
    error('Toolbox packaging failed. Please check the error messages above.');
end
