function plotDots(trajData, scale, dotSizes, white, dotCenter, data_count)
    for i = 1:length(trajData)
        % data_count*0.1 is an offset for our specific data subject's
        % uwitting speed during data capture
        dotXpos = trajData{2, i}.array(1, data_count)/scale;
        dotYpos = -trajData{2, i}.array(3, data_count)/scale;

        Screen('DrawDots', window, [dotXpos; dotYpos], dotSizes, white, dotCenter, 2);
    end
end