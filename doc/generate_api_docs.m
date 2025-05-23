% GENERATE_API_DOCS Script to automatically generate HTML documentation
% for the QFIEntanglementToolbox.
%
% How to use:
% 1. Open MATLAB.
% 2. Change the current directory to the root of the QFIEntanglementToolbox repository.
% 3. Run this script from the MATLAB command window:
%    >> run doc/generate_api_docs.m
% 4. The HTML documentation will be generated in the 'doc/api/' directory.
%    An 'index.html' (if Contents.m files are published) or individual HTML files
%    for each function will be available there.

% Define the output directory for HTML files
outputDir = fullfile(pwd, 'doc', 'api');

% Create the output directory if it doesn't exist
if ~isfolder(outputDir)
    mkdir(outputDir);
    fprintf('Created output directory: %s\n', outputDir);
end

% Define the source directory for the toolbox
toolboxSourceDir = fullfile(pwd, 'src', '+QFIEntanglementToolbox');

% --- Publish core package functions ---
fprintf('Publishing core QFIEntanglementToolbox functions...\n');
corePackageDir = toolboxSourceDir;
coreFiles = dir(fullfile(corePackageDir, '*.m'));

% Publish Contents.m for the main package first if it exists
contentsFileCore = fullfile(corePackageDir, 'Contents.m');
if exist(contentsFileCore, 'file')
    fprintf('Publishing: %s\n', contentsFileCore);
    try
        publish(contentsFileCore, 'outputDir', outputDir, 'format', 'html');
    catch ME
        fprintf('Failed to publish %s. Error: %s\n', contentsFileCore, ME.message);
    end
else
    fprintf('Warning: Main Contents.m not found in %s\n', corePackageDir);
end

for i = 1:length(coreFiles)
    filename = coreFiles(i).name;
    % Skip Contents.m as it's handled separately or if we don't want it as a standalone page from this loop
    if strcmp(filename, 'Contents.m')
        continue;
    end
    
    fullFilePath = fullfile(corePackageDir, filename);
    fprintf('Publishing: %s\n', fullFilePath);
    try
        publish(fullFilePath, 'outputDir', outputDir, 'format', 'html');
    catch ME
        fprintf('Failed to publish %s. Error: %s\n', fullFilePath, ME.message);
    end
end

% --- Publish utility package functions ---
fprintf('\nPublishing QFIEntanglementToolbox.utils functions...\n');
utilsPackageDir = fullfile(toolboxSourceDir, '+utils');
if isfolder(utilsPackageDir)
    utilsFiles = dir(fullfile(utilsPackageDir, '*.m'));

    % Publish Contents.m for the utils subpackage
    contentsFileUtils = fullfile(utilsPackageDir, 'Contents.m');
    if exist(contentsFileUtils, 'file')
        fprintf('Publishing: %s\n', contentsFileUtils);
        try
            publish(contentsFileUtils, 'outputDir', outputDir, 'format', 'html');
        catch ME
            fprintf('Failed to publish %s. Error: %s\n', contentsFileUtils, ME.message);
        end
    else
        fprintf('Warning: Utils Contents.m not found in %s\n', utilsPackageDir);
    end

    for i = 1:length(utilsFiles)
        filename = utilsFiles(i).name;
        if strcmp(filename, 'Contents.m')
            continue;
        end
        
        fullFilePath = fullfile(utilsPackageDir, filename);
        fprintf('Publishing: %s\n', fullFilePath);
        try
            % To make publish work correctly with package functions,
            % we might need to temporarily add src to path or call it in a way
            % that MATLAB understands the package context.
            % However, `publish` typically takes the direct file path.
            publish(fullFilePath, 'outputDir', outputDir, 'format', 'html');
        catch ME
            fprintf('Failed to publish %s. Error: %s\n', fullFilePath, ME.message);
        end
    end
else
    fprintf('Warning: +utils directory not found in %s\n', toolboxSourceDir);
end

fprintf('\nAPI documentation generation complete.\nHTML files are in: %s\n', outputDir);
% Note: Publishing Contents.m usually creates an index.html if structured correctly.
% Otherwise, users can browse the individual HTML files.
% For a more sophisticated index, a separate step would be needed after publishing.
