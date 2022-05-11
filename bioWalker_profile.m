%% PSYCH SETUP
% Clear the workspace and the screen
sca;
close all;
clearvars;

% Here we call some default settings for setting up Psychtoolbox
PsychDefaultSetup(2);

% Set window to opacity for debugging 
PsychDebugWindowConfiguration(0, 0.5);

% Get the screen numbers
screens = Screen('Screens');

% Draw to the external screen if avaliable
screenNumber = max(screens);

% Open an on screen window
[window, windowRect] = PsychImaging('OpenWindow', screenNumber, [0 0 0]);

% Get the size of the on screen window
[screenXpixels, screenYpixels] = Screen('WindowSize', window);

% Query the frame duration
ifi = Screen('GetFlipInterval', window);

%% TRAJ. SETUP
trajFiles = dir('TrajectoryData/*.mat');

for i=1:length(trajFiles)
    trajData{1,i} = trajFiles(i).name;
    trajData{2,i} = load(['TrajectoryData/', trajFiles(i).name]);
end

%% DOT SETUP
% Colour intensity
colourLevel = 1;

% We can define a center for the dot coordinates to be relaitive to. Here
% we set the centre to be the centre of the screen
dotCenter = [(screenXpixels / 2 - 100) (screenYpixels / 2 + 500)];

dotYpos = 0;
dotXpos = 0;
dotSizes = 20;

white = WhiteIndex(screenNumber);
dotColours = white*colourLevel;

% Sync us and get a time stamp
vbl = Screen('Flip', window);
waitframes = 1;

% Maximum priority level
topPriorityLevel = MaxPriority(window);
Priority(topPriorityLevel);

% Draw White Dot on screen
Screen('DrawDots', window, [dotXpos; dotYpos], dotSizes, dotColours, dotCenter, 2);
Screen('Flip', window);

time = 0;
data_count = 1;
% len = size(trajData{2, 1}.array, 2);
len = 1000;
scale = 2;

while ~KbCheck
    % Extract dotXpos and dotYpos and apply to dot on screen 
    for i = 1:length(trajData)
        % data_count*0.1 is an offset for our specific data
        dotXpos = -trajData{2, i}.array(1, data_count)/scale - data_count*0.1;
        dotYpos = -trajData{2, i}.array(3, data_count)/scale;

        Screen('DrawDots', window, [dotXpos; dotYpos], dotSizes, white, dotCenter, 2);
    end

    % Flip to the screen
    vbl  = Screen('Flip', window, vbl + (waitframes - 0.5) * ifi);

    % Increment the time
    time = time + ifi;

    data_count = data_count + 1;
    if (data_count >= len)
        data_count = 1;
    end
end

% Clear screen
sca;