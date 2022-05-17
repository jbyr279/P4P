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
% trajFiles = dir('TrajectoryData/*.mat');
% 
% noOfMarkers = 28;
% visibleMarkers = 4;
% remove = noOfMarkers - visibleMarkers;
% randIndex = randperm(length(trajFiles), remove);
% index = 1;
% 
% for i=1:length(trajFiles)
%     if ~(ismember(i, randIndex))
%         trajData{1,index} = trajFiles(i).name;
%         trajData{2,index} = load(['TrajectoryData/', trajFiles(i).name]);
%         index = index + 1;
%     end
% end

%% DOT SETUP
% Colour intensity
colourLevel = 1;

<<<<<<< HEAD
% We can define a center for the dot coordinates to be relaitive to.
% Heresca
=======
% We can define a center for the dot coordinates to be relaitive to. Here
>>>>>>> main
% we set the centre to be the centre of the screen
dotCenter = [(screenXpixels / 2 + 200) (screenYpixels / 2 + 200)];

dotYpos = 0;
dotXpos = 0;
dotSizes = 10;

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
len = 500;

<<<<<<< HEAD
scale = 3;
angle = 0; % only works for 0, +-pi, +-pi/2??? 
=======
scale = 2;
angle = pi/8; % only works for 0, +-pi, +-pi/2??? 
>>>>>>> main

while ~KbCheck 
    if mod(life_count, len / 50) == 0
        trajFiles = dir('TrajectoryData/*.mat');
    
        noOfMarkers = 28;
        visibleMarkers = 28;
        remove = noOfMarkers - visibleMarkers;
        randIndex = randperm(length(trajFiles), remove);
        index = 1;
        
        for i=1:length(trajFiles)
            if ~(ismember(i, randIndex))
                trajData{1,index} = trajFiles(i).name;
                trajData{2,index} = load(['TrajectoryData/', trajFiles(i).name]);
<<<<<<< HEAD
                
                data = trajData{2,index}.array;
                data(4,:) = [];
                transData = rotateAxis(data, 150, "overhead");
                trajData{2,index}.array = transData;

=======
>>>>>>> main
                index = index + 1;
            end
        end
    end

    % Extract dotXpos and dotYpos and apply to dot on screen 
    for i = 1:length(trajData)
        % data_count*0.1 is an offset for our specific data subject's
        % uwitting speed during data capture
        dotXpos = trajData{2, i}.array(1, data_count)/scale;
        dotYpos = trajData{2, i}.array(2, data_count)/scale;

        xPos = cos(angle)*dotXpos + sin(angle)*dotYpos;
        yPos = -1*sin(angle)*dotXpos + cos(angle)*dotYpos;

<<<<<<< HEAD
        Screen('DrawDots', window, [dotXpos; dotYpos], dotSizes, white, dotCenter, 2);
=======
        Screen('DrawDots', window, [xPos; yPos], dotSizes, white, dotCenter, 2);
>>>>>>> main
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

% Clear screen
sca;