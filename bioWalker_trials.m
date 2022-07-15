%% PSYCH SETUP
% Clear the workspace and the screen
sca;
close all;
clearvars;

% Here we call some default settings for setting up Psychtoolbox
PsychDefaultSetup(2);

% Set window to opacity for debugging 
% PsychDebugWindowConfiguration(0, 0.5);

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

%% TRIAL MATRIX SETUP 
current_trial = {};

theta_v = [90, 120, 150, 180];
degradation = [7, 14, 21, 28];

for i = 1:size(degradation,2)
    for j = 1:size(theta_v,2)
        current_trial{i,j}.degradation = degradation(i);
        current_trial{i,j}.theta_v = theta_v(j);
        current_trial{i,j}.correct = false;
    end
end

len = size(degradation,2) * size(theta_v,2);

current_trial = reshape(current_trial,[1,len]);

trial_rand = current_trial(randperm(length(current_trial)));

%% DOT SETUP
% Colour intensity
colourLevel = 1;

% We can define a center for the dot coordinates to be relaitive to. Here
% we set the centre to be the centre of the screen
dotCenter = [(screenXpixels / 2 - 200) (screenYpixels / 2 + 500)];

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
life_count = 0;

% len = size(trajData{2, 1}.array, 2);
len = 1000;
scale = 2;

inputKey = cell(1,16);

 for trial = 1:size(trial_rand, 2)
    keyIsDown = false;
    while ~keyIsDown

        [keyIsDown, ~, keyCode, ~] = KbCheck;
        inputKey{trial} = KbName(keyCode);

        if mod(life_count, len / 50) == 0
             trajData = getTrajData(trial_rand{trial}.degradation, trial_rand{trial}.theta_v, 'TrajectoryData/*.mat');
        end
    
        % Extract dotXpos and dotYpos and apply to dot on screen 
        for i = 1:length(trajData)
            % data_count*0.1 is an offset for our specific data subject's
            % uwitting speed during data capture
            dotXpos = trajData{2, i}.array(1, data_count)/scale;
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
    
        life_count = life_count + 1;
        if (data_count >= len)
            data_count = 1;
        end
    end
    pause(1);

    if (trial_rand{trial}.theta_v == 90)
        trial_rand{trial}.correct = (strcmp(inputKey{trial}, '1!'));
    elseif  (trial_rand{trial}.theta_v == 120)
        trial_rand{trial}.correct = (strcmp(inputKey{trial}, '2@'));
    elseif (trial_rand{trial}.theta_v == 150)
        trial_rand{trial}.correct = (strcmp(inputKey{trial}, '3#'));
    elseif (trial_rand{trial}.theta_v == 180)
        trial_rand{trial}.correct = (strcmp(inputKey{trial}, '4$'));
    end
 end

% Clear screen
sca;



