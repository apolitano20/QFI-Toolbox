function progressBar(varargin)
% Description:
%   progressBar() provides an indication of the progress of some task using
% graphics and text. Calling progressBar repeatedly will update the figure and
% automatically estimate the amount of time remaining.
%   This implementation of progressBar is intended to be extremely simple to use
% while providing a high quality user experience.
%
% Features:
%   - Can add progressBar to existing m-files with a single line of code.
%   - Supports multiple bars in one figure to show progress of nested loops.
%   - Optional labels on bars.
%   - Figure closes automatically when task is complete.
%   - Only one figure can exist so old figures don't clutter the desktop.
%   - Remaining time estimate is accurate even if the figure gets closed.
%   - Minimal execution time. Won't slow down code.
%   - Randomized color. When a programmer gets bored...
%
% Example Function Calls For Single Bar Usage:
%   progressBar               % Initialize/reset
%   progressBar(0)            % Initialize/reset
%   progressBar('Label')      % Initialize/reset and label the bar
%   progressBar(0.5)          % Update
%   progressBar(1)            % Close
%
% Example Function Calls For Multi Bar Usage:
%   progressBar(0, 0)         % Initialize/reset two bars
%   progressBar('A', '')      % Initialize/reset two bars with one label
%   progressBar('', 'B')      % Initialize/reset two bars with one label
%   progressBar('A', 'B')     % Initialize/reset two bars with two labels
%   progressBar(0.3)          % Update 1st bar
%   progressBar(0.3, [])      % Update 1st bar
%   progressBar([], 0.3)      % Update 2nd bar
%   progressBar(0.7, 0.9)     % Update both bars
%   progressBar(1)            % Close
%   progressBar(1, [])        % Close
%   progressBar(1, 0.4)       % Close
%
% Notes:
%   For best results, call progressBar with all zero (or all string) inputs
% before any processing. This sets the proper starting time reference to
% calculate time remaining.
%   Bar color is choosen randomly when the figure is created or reset. Clicking
% the bar will cause a random color change.
%
% Author:
%   Steve Hoelzer
%
% package: QFIEntanglementToolbox.utils

persistent progFig progData lastUpdate

% Get inputs
if nargin > 0
    inputArgs = varargin;
    nInput = nargin;
else
    % If no inputs, init with a single bar
    inputArgs = {0};
    nInput = 1;
end

% If task completed, close figure and clear vars, then exit
if inputArgs{1} == 1
    if ishandle(progFig)
        delete(progFig) % Close progress bar
    end
    clear progFig progData lastUpdate % Clear persistent vars
    drawnow
    return
end

% Init reset flag 
resetFlag = false;

% Set reset flag if first input is a string
if ischar(inputArgs{1})
    resetFlag = true;
end

% Set reset flag if all inputs are zero
if inputArgs{1} == 0
    % If the quick check above passes, need to check all inputs
    if all([inputArgs{:}] == 0) && (length([inputArgs{:}]) == nInput)
        resetFlag = true;
    end
end

% Set reset flag if more inputs than bars
if nInput > length(progData)
    resetFlag = true;
end

% If reset needed, close figure and forget old data
if resetFlag
    if ishandle(progFig)
        delete(progFig) % Close progress bar
    end
    progFig = [];
    progData = []; % Forget obsolete data
end

% Create new progress bar if needed
if ishandle(progFig)
else % This strange if-else works when progFig is empty (~ishandle() does not)
    
    % Define figure size and axes padding for the single bar case
    height = 0.03;
    width = height * 8;
    hPad = 0.02;
    vPad = 0.25;
    
    % Figure out how many bars to draw
    nBars = max(nInput, length(progData));
    
    % Adjust figure size and axes padding for number of bars
    heightFactor = (1 - vPad) * nBars + vPad;
    height = height * heightFactor;
    vPad = vPad / heightFactor;
    
    % Initialize progress bar figure
    left = (1 - width) / 2;
    bottom = (1 - height) / 2;
    progFig = figure(...
        'Units', 'normalized',...
        'Position', [left bottom width height],...
        'NumberTitle', 'off',...
        'Resize', 'off',...
        'MenuBar', 'none' );
    
    % Initialize axes, patch, and text for each bar
    left = hPad;
    width = 1 - 2*hPad;
    vPadTotal = vPad * (nBars + 1);
    height = (1 - vPadTotal) / nBars;
    for idx = 1:nBars
        % Create axes, patch, and text
        bottom = vPad + (vPad + height) * (nBars - idx);
        progData(idx).progaxes = axes( ...
            'Position', [left bottom width height], ...
            'XLim', [0 1], ...
            'YLim', [0 1], ...
            'Box', 'on', ...
            'ytick', [], ...
            'xtick', [] );
        progData(idx).progpatch = patch( ...
            'XData', [0 0 0 0], ...
            'YData', [0 0 1 1] );
        progData(idx).progtext = text(0.99, 0.5, '', ...
            'HorizontalAlignment', 'Right', ...
            'FontUnits', 'Normalized', ...
            'FontSize', 0.7 );
        progData(idx).proglabel = text(0.01, 0.5, '', ...
            'HorizontalAlignment', 'Left', ...
            'FontUnits', 'Normalized', ...
            'FontSize', 0.7 );
        if idx <= nInput && ischar(inputArgs{idx})
            set(progData(idx).proglabel, 'String', inputArgs{idx})
            inputArgs{idx} = 0;
        end
        
        % Set callbacks to change color on mouse click
        set(progData(idx).progaxes, 'ButtonDownFcn', {@changeColor, progData(idx).progpatch})
        set(progData(idx).progpatch, 'ButtonDownFcn', {@changeColor, progData(idx).progpatch})
        set(progData(idx).progtext, 'ButtonDownFcn', {@changeColor, progData(idx).progpatch})
        set(progData(idx).proglabel, 'ButtonDownFcn', {@changeColor, progData(idx).progpatch})
        
        % Pick a random color for this patch
        changeColor([], [], progData(idx).progpatch)
        
        % Set starting time reference
        if ~isfield(progData(idx), 'starttime') || isempty(progData(idx).starttime)
            progData(idx).starttime = clock;
        end
    end
    
    % Set time of last update to ensure a redraw
    lastUpdate = clock - 1;
    
end

% Process inputs and update state of progData
for idx = 1:nInput
    if ~isempty(inputArgs{idx})
        progData(idx).fractiondone = inputArgs{idx};
        progData(idx).clock = clock;
    end
end

% Enforce a minimum time interval between graphics updates
myClock = clock;
if abs(myClock(6) - lastUpdate(6)) < 0.01 % Could use etime() but this is faster
    return
end

% Update progress patch
for idx = 1:length(progData)
    set(progData(idx).progpatch, 'XData', ...
        [0, progData(idx).fractiondone, progData(idx).fractiondone, 0])
end

% Update progress text if there is more than one bar
if length(progData) > 1
    for idx = 1:length(progData)
        set(progData(idx).progtext, 'String', ...
            sprintf('%1d%%', floor(100*progData(idx).fractiondone)))
    end
end

% Update progress figure title bar
if progData(1).fractiondone > 0
    runtime = etime(progData(1).clock, progData(1).starttime);
    timeLeft = runtime / progData(1).fractiondone - runtime;
    timeLeftStr = sec2timeStr(timeLeft);
    titleBarStr = sprintf('%2d%%    %s remaining', ...
        floor(100*progData(1).fractiondone), timeLeftStr);
else
    titleBarStr = ' 0%';
end
set(progFig, 'Name', titleBarStr)

% Force redraw to show changes
drawnow

% Record time of this update
lastUpdate = clock;


% ------------------------------------------------------------------------------
function changeColor(h, e, progpatch) %#ok<INUSL>
% Change the color of the progress bar patch

% Prevent color from being too dark or too light
colorMin = 1.5;
colorMax = 2.8;

thisColor = rand(1, 3);
while (sum(thisColor) < colorMin) || (sum(thisColor) > colorMax)
    thisColor = rand(1, 3);
end

set(progpatch, 'FaceColor', thisColor)


% ------------------------------------------------------------------------------
function timeStr = sec2timeStr(sec)
% Convert a time measurement from seconds into a human readable string.

% Convert seconds to other units
w = floor(sec/604800); % Weeks
sec = sec - w*604800;
d = floor(sec/86400); % Days
sec = sec - d*86400;
h = floor(sec/3600); % Hours
sec = sec - h*3600;
m = floor(sec/60); % Minutes
sec = sec - m*60;
s = floor(sec); % Seconds

% Create time string
if w > 0
    if w > 9
        timeStr = sprintf('%d week', w);
    else
        timeStr = sprintf('%d week, %d day', w, d);
    end
elseif d > 0
    if d > 9
        timeStr = sprintf('%d day', d);
    else
        timeStr = sprintf('%d day, %d hr', d, h);
    end
elseif h > 0
    if h > 9
        timeStr = sprintf('%d hr', h);
    else
        timeStr = sprintf('%d hr, %d min', h, m);
    end
elseif m > 0
    if m > 9
        timeStr = sprintf('%d min', m);
    else
        timeStr = sprintf('%d min, %d sec', m, s);
    end
else
    timeStr = sprintf('%d sec', s);
end
