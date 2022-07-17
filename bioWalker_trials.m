%% PSYCH SETUP
% Clear the workspace and the screen
sca;
close all;
clearvars;

% Here we call some default settings for setting up Psychtoolbox
PsychDefaultSetup(2);

% Set window to opacity for debugging 
PsychDebugWindowConfiguration(0, 1);

% Get the screen numbers
screens = Screen('Screens');
screenNumber = max(screens);

% Open an on screen window
[window, windowRect] = PsychImaging('OpenWindow', screenNumber, [0 0 0]);

% Get the size of the on screen window
[screenXpixels, screenYpixels] = Screen('WindowSize', window);

% Query the frame duration
ifi = Screen('GetFlipInterval', window);

%% TRIAL MATRIX SETUP 
num_trials = 2;
theta_v = [90, 120, 150, 180];
degradation = [4, 8, 12, 16, 20, 24, 28];

trial_rand = {};

for i = 1:num_trials
    trial_rand = [trial_rand, randomiseTrials(theta_v, degradation)];
end

%% DOT SETUP2
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

len = 1000;
scale = 2;

inputKey = cell(1,size(theta_v,2)*size(degradation,2));

for trial = 1:size(trial_rand, 2)
    % Flash grey
    Screen('FillRect', window, [0.5, 0.5, 0.5]);
    Screen('Flip', window);

    pause(0.5);

    % Reset black
    Screen('FillRect', window, [0, 0, 0]);
    Screen('Flip', window);

    trajData = getTrajData(trial_rand{trial}.degradation, trial_rand{trial}.theta_v, 'TrajectoryData/*.mat', scale);

    while (~validKey(trial_rand{trial}.inputKey))
        [~, ~, keyCode, ~] = KbCheck;
        trial_rand{trial}.inputKey = KbName(keyCode);
        
        % Extract dotXpos and dotYpos and apply to dot on screen
        if time <= 3
            for i = 1:length(trajData)
                dotXpos = trajData{2, i}.array(1, data_count)/scale;
                dotYpos = -trajData{2, i}.array(3, data_count)/scale;
                Screen('DrawDots', window, [dotXpos; dotYpos], dotSizes, white, dotCenter, 2);
            end
        else
            Screen('FillRect', window, [0.5, 0, 0]);
        end
    
        % Flip to the screen
        Screen('Flip', window);
    
        % Increment the time
        time = time + ifi;

        data_count = incrementValues(data_count, len);
    end
    pause(0.5);

    trial_rand = populateCorrect(trial_rand, trial, trial_rand{trial}.inputKey);
    time = 0;
    data_count = 1;
end

% Clear screen
sca;

matrix = dataParser(trial_rand, theta_v, degradation);

% Keep useful vars
clearvars -except matrix num_trials;

name = input("Trial Subject Name: ", "s");
save(append('PrelimTrialData\', date, '-', name, '.mat'))
