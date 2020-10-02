function func_SwitchAttentionPart2(windowPtr,rect,SubjID)

c = clock; %Current date and time as date vector. [year month day hour minute seconds]
time =strcat(num2str(c(1)),'_',num2str(c(2)),'_',num2str(c(3)),'_',num2str(c(4)),'_',num2str(c(5))); %makes unique filename
rand('seed', str2num(SubjID));

ans_left = KbName('LeftArrow');
ans_right = KbName('RightArrow');


%% load stimuli

right_arrow_image = imread('right arrow.jpg');
right_arrow_img = Screen('MakeTexture', windowPtr, right_arrow_image);
left_arrow_image = imread('left arrow.jpg');
left_arrow_img = Screen('MakeTexture', windowPtr, left_arrow_image);

ntrials_per_condition = 24;
variables.condition_order = [];
for i = 1:ntrials_per_condition
    temp = randperm(4);
    variables.condition_order = [temp, variables.condition_order];
end
ntrials = numel(variables.condition_order);


%% run experiment
RestrictKeysForKbCheck([]);
DrawFormattedText(windowPtr,'PART 2 MAIN EXPERIMENT \n\n\n Press any key to begin','center','center',[0,0,0]);
Screen('Flip',windowPtr);
% wait for keypress to start exp
keyisdown = 0;
while ~keyisdown
    [keyisdown,secs,keycode] = KbCheck;
end
count = 1;
while count < 6 % ten second dummies
    DrawFormattedText(windowPtr,strcat('PART 2 MAIN EXPERIMENT \n\n\n Starting in...',num2str(6-count)),'center','center',[0,0,0]);
    Screen('Flip',windowPtr);
    WaitSecs(2);
    count = count + 1;
end
DrawFormattedText(windowPtr,'+','center','center',[0,0,0]);
Screen('Flip',windowPtr);
WaitSecs(2);


arrow_width = 200;
arrow_height = 100;
stimPos{1} = [rect(3)/2 - 5/2*arrow_width, rect(4)/2 - arrow_height/2, rect(3)/2 - 3/2*arrow_width, rect(4)/2 + arrow_height/2];
stimPos{2} = [rect(3)/2 - 3/2*arrow_width, rect(4)/2 - arrow_height/2, rect(3)/2 - 1/2*arrow_width, rect(4)/2 + arrow_height/2];
stimPos{3} = [rect(3)/2 - 1/2*arrow_width, rect(4)/2 - arrow_height/2, rect(3)/2 + 1/2*arrow_width, rect(4)/2 + arrow_height/2];
stimPos{4} = [rect(3)/2 + 1/2*arrow_width, rect(4)/2 - arrow_height/2, rect(3)/2 + 3/2*arrow_width, rect(4)/2 + arrow_height/2];
stimPos{5} = [rect(3)/2 + 3/2*arrow_width, rect(4)/2 - arrow_height/2, rect(3)/2 + 5/2*arrow_width, rect(4)/2 + arrow_height/2];

starttime = GetSecs;
for trial = 1:ntrials
    
    DrawFormattedText(windowPtr,'+','center','center',[0,0,0]);
    Screen('Flip',windowPtr);
    WaitSecs(1);
    
    switch variables.condition_order(trial)
        case 1 % congruent with all arrows pointing right
            Screen('DrawTexture', windowPtr, right_arrow_img, [], stimPos{1});
            Screen('DrawTexture', windowPtr, right_arrow_img, [], stimPos{2});
            Screen('DrawTexture', windowPtr, right_arrow_img, [], stimPos{3});
            Screen('DrawTexture', windowPtr, right_arrow_img, [], stimPos{4});
            Screen('DrawTexture', windowPtr, right_arrow_img, [], stimPos{5});
            variables.trial_ans(trial) = 1;
            variables.trial_congruency(trial) = 1;
        case 2 % congruent with all arrows pointing left
            Screen('DrawTexture', windowPtr, left_arrow_img, [], stimPos{1});
            Screen('DrawTexture', windowPtr, left_arrow_img, [], stimPos{2});
            Screen('DrawTexture', windowPtr, left_arrow_img, [], stimPos{3});
            Screen('DrawTexture', windowPtr, left_arrow_img, [], stimPos{4});
            Screen('DrawTexture', windowPtr, left_arrow_img, [], stimPos{5});
            variables.trial_ans(trial) = 0;
            variables.trial_congruency(trial) = 1;
        case 3 % incongruent with middle left, flankers right
            Screen('DrawTexture', windowPtr, right_arrow_img, [], stimPos{1});
            Screen('DrawTexture', windowPtr, right_arrow_img, [], stimPos{2});
            Screen('DrawTexture', windowPtr, left_arrow_img, [], stimPos{3});
            Screen('DrawTexture', windowPtr, right_arrow_img, [], stimPos{4});
            Screen('DrawTexture', windowPtr, right_arrow_img, [], stimPos{5});
            variables.trial_ans(trial) = 0;
            variables.trial_congruency(trial) = 0;
        case 4 % incongruent with middle right, flankers left
            Screen('DrawTexture', windowPtr, left_arrow_img, [], stimPos{1});
            Screen('DrawTexture', windowPtr, left_arrow_img, [], stimPos{2});
            Screen('DrawTexture', windowPtr, right_arrow_img, [], stimPos{3});
            Screen('DrawTexture', windowPtr, left_arrow_img, [], stimPos{4});
            Screen('DrawTexture', windowPtr, left_arrow_img, [], stimPos{5});
            variables.trial_ans(trial) = 1;
            variables.trial_congruency(trial) = 0;
    end
    displaytime = Screen('Flip',windowPtr);
    variables.trialonset(trial) = displaytime-starttime;
    
    
    % prepare to record response
    variables.rtime(trial) = NaN;
    variables.subjanswer(trial) = NaN;
    variables.subjaccuracy(trial) = NaN;
    
    
    % get subject response
    RestrictKeysForKbCheck([ans_right ans_left]);
    keyisdown = 0;
    while ~keyisdown && (GetSecs - displaytime < 1)
        [keyisdown,secs,keycode] = KbCheck;
        if keycode(ans_right) == 1 || keycode(ans_left) == 1
            variables.rtime(trial) = round((secs-displaytime)*1000); % reaction time in miliseconds
            variables.subjresponsetime(trial) = GetSecs-starttime;
            if keycode(ans_right) == 1
                variables.subjanswer(trial) = 1;
            elseif keycode(ans_left) == 1
                variables.subjanswer(trial) = 0;
            end
            DrawFormattedText(windowPtr,'+','center','center',[0,0,0]);
            Screen('Flip',windowPtr);
        end
    end
    Screen('Flip',windowPtr);
    
    if isequaln(variables.subjanswer(trial),variables.trial_ans(trial))
        variables.subjaccuracy(trial) = 1;
    else  variables.subjaccuracy(trial) = 0;
    end
    
    extratime = 1 - variables.rtime(trial)/1000;
    if isnan(extratime)
        extratime = 0;
    end
    WaitSecs(1+extratime);
    
    
end
save(strcat('C:/Users/egnerlab/Desktop/Tanya/task switching and attention/psychtoolbox code/February_2020_Version/data/SwitchAttnMemPart2_',SubjID,'_Behavioral_',time,'.mat'));

%% feedback on accuracy
DrawFormattedText(windowPtr,sprintf('accuracy %2.2f %% \n\n press any key to exit',100*nansum(variables.subjaccuracy)/ntrials),'center','center',[0,0,0]);
Screen('Flip',windowPtr);
RestrictKeysForKbCheck([]);
keyisdown = 0;
while ~keyisdown
    [keyisdown,secs,keycode] = KbCheck;
end

end
