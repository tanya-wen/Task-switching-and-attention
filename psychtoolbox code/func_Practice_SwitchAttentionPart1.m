function overall_accuracy = func_Practice_SwitchAttentionPart1(windowPtr,rect,pahandle,run_number,SubjID)

c = clock; %Current date and time as date vector. [year month day hour minute seconds]
time =strcat(num2str(c(1)),'_',num2str(c(2)),'_',num2str(c(3)),'_',num2str(c(4)),'_',num2str(c(5))); %makes unique filename
rand('seed', str2num(SubjID));

%% cues
task_rules = {'gender','race','concreteness','syllable'};
cue_colors = [148,0,211; 0,255,0; 0,0,255; 255,165,0];

%% counterbalance

% ntasks * ntasks matrix where row number corresponds to the previous
% task number and column number the current task number. Matrix values
% show the amount of each task transition left.
test_mat = [
    8 8 4 4
    8 8 4 4
    4 4 8 8
    4 4 8 8];
% gender, race, concreteness, syllable

ntasks = 4;
fragment = 0;
clear temp
while sum(sum(test_mat))>0 % while there are still numbers of task transitions left
    row = randi(ntasks); % start by chosing a random row
    while sum(test_mat(row,:))==0 % if row chosen is empty (vaules sum to 0) chose again
        row = randi(ntasks);
    end
    fragment = fragment + 1; % add 1 to the fragment count for each time new loop
    count = 0;
    while sum(test_mat(row,:))>0 % while there are transitions left from the previous task
        count = count + 1;
        col = randi(ntasks); % chose the column number
        while test_mat(row,col)==0 % If there aren't any transitions left between that row and coulmn then chose again
            col=randi(ntasks);
        end
        test_mat(row,col) = test_mat(row,col) - 1; % Take 1 away from the chosen transition value
        temp(fragment,count) = row; % add the previous task number to the temporary variable of run order fragments
        row = col; % make the current task number the previous task number
    end
    temp(fragment,count+1) = col; % after the fragment ends add the current task number to the end of the run order fragment
end

% Combine the run-order fragments such that numbers of each sequence-change
% conditions aren't disrupted. By insterting them after the same number the
% fragment begins and ends with
seq_order = temp(1,:);
seq_order = seq_order(seq_order~=0);
count = 1;
while size(temp,1)>count
    count = count + 1;
    lead = temp(count,1);
    point = datasample(find(seq_order==lead),1);
    insert = temp(count,2:end);
    insert = insert(insert~=0);
    seq_order = [seq_order(1:point) insert seq_order(point+1:end)];
end

variables.seq_order = seq_order;
ntrials = numel(variables.seq_order);


%% obtain switch type
for i = 2:numel(variables.seq_order) % record the previous task and current task
    
    
    if variables.seq_order(i-1) == 1 %gender
        preceding_rule{i-1} = 'Gender';
        preceding_category{i-1} = 'Face';
    elseif variables.seq_order(i-1) == 2 %race
        preceding_rule{i-1} = 'Race';
        preceding_category{i-1} = 'Face';
    elseif variables.seq_order(i-1) == 3 %concreteness
        preceding_rule{i-1} = 'Concreteness';
        preceding_category{i-1} = 'Word'; %syllable
    elseif variables.seq_order(i-1) == 4
        preceding_rule{i-1} = 'Syllable';
        preceding_category{i-1} = 'Word';
    end
    
    if variables.seq_order(i) == 1 %gender
        current_rule{i} = 'Gender';
        current_category{i} = 'Face';
    elseif variables.seq_order(i) == 2 %race
        current_rule{i} = 'Race';
        current_category{i} = 'Face';
    elseif variables.seq_order(i) == 3 %Concreteness
        current_rule{i} = 'Concreteness';
        current_category{i} = 'Word';
    elseif variables.seq_order(i) == 4 %Syllable
        current_rule{i} = 'Syllable';
        current_category{i} = 'Word';
    end
    
end

for i = 1:numel(current_rule)
    
    if i == 1
        switchtype.switch_category{i} = '';
        switchtype.switch_rule{i} = '';
        switchtype.switch_condition{i} = '';
        switchtype.switch_regressor{i} = '';
    else
        
        switchtype.switch_category{i} = sprintf('%s-%s',preceding_category{i-1},current_category{i});
        switchtype.switch_rule{i} = sprintf('%s-%s',preceding_rule{i-1},current_rule{i});
        
        if strcmp(preceding_rule{i-1},current_rule{i}) == 1
            switchtype.switch_condition{i} = 'stay';
        elseif strcmp(current_category{i-1},current_category{i}) == 1
            switchtype.switch_condition{i} = 'within';
        elseif strcmp(current_category{i-1},current_category{i}) ~=1
            switchtype.switch_condition{i} = 'between';
        end
    end
    
end



%% load images

%%% faces %%%
face_list = dir(fullfile('C:/Users/egnerlab/Desktop/Tanya/task switching and attention/psychtoolbox code/February_2020_Version/face stimuli','*_*.jpg'));
face_pool = face_list(randperm(numel(face_list)));

%%% objects %%%
word_list = readtable('C:/Users/egnerlab/Desktop/Tanya/task switching and attention/psychtoolbox code/February_2020_Version/practice word stimuli.xlsx');
word_pool = [word_list.(1),word_list.(2),word_list.(3),word_list.(4)];

%%% scenes %%%
scene_list = dir(fullfile('C:/Users/egnerlab/Desktop/Tanya/task switching and attention/psychtoolbox code/February_2020_Version/practice scene stimuli','*.jpg'));
scene_pool = scene_list(randperm(numel(scene_list)));

%% load incorrect sound
[y,Fs] = audioread('C:/Users/egnerlab/Desktop/Tanya/task switching and attention/psychtoolbox code/February_2020_Version/wrong_ans_sound.mp3');
wrong_ans_sound = y(1:44100,:)';

%% counterbalance & preload images
variables.seq_order = [];
for i = 1:5
    temp = randperm(4);
    variables.seq_order = [variables.seq_order, temp];
end
ntrials = numel(variables.seq_order);


%% run experiment
RestrictKeysForKbCheck([]);
DrawFormattedText(windowPtr,'PART 1 PRACTICE \n\n\n You will practice until you have performed at least 85% correct \n\n Press any key to begin','center','center',[0,0,0]);
Screen('Flip',windowPtr);
% wait for keypress to start exp
keyisdown = 0;
while ~keyisdown
    [keyisdown,secs,keycode] = KbCheck;
end
count = 1;
while count < 6 % ten second dummies
    DrawFormattedText(windowPtr,strcat('Starting in...',num2str(6-count)),'center','center',[0,0,0]);
    Screen('Flip',windowPtr);
    WaitSecs(2);
    count = count + 1;
end
DrawFormattedText(windowPtr,'+','center','center',[0,0,0]);
Screen('Flip',windowPtr);
WaitSecs(2);

stim_width = 640;
stim_height = 640;
stimPos = [rect(3)/2 - stim_width/2, rect(4)/2 - stim_height/2, rect(3)/2 + stim_width/2, rect(4)/2 + stim_height/2];


ans_left = KbName('LeftArrow');
ans_right = KbName('RightArrow');

starttime = GetSecs;
for trial = 1:ntrials
    
    % present cue
    switch variables.seq_order(trial)
        case 1
            DrawFormattedText(windowPtr,'FACE','center',rect(4)/2-100,cue_colors(variables.seq_order(trial),:));
            DrawFormattedText(windowPtr,'  MALE          FEMALE','center',rect(4)/2+100,cue_colors(variables.seq_order(trial),:));
        case 2
            DrawFormattedText(windowPtr,'FACE','center',rect(4)/2-100,cue_colors(variables.seq_order(trial),:));
            DrawFormattedText(windowPtr,'   ASIAN         CAUCASIAN','center',rect(4)/2+100,cue_colors(variables.seq_order(trial),:));
        case 3
            DrawFormattedText(windowPtr,'WORD','center',rect(4)/2-100,cue_colors(variables.seq_order(trial),:));
            DrawFormattedText(windowPtr,'ABSTRACT           CONCRETE','center',rect(4)/2+100,cue_colors(variables.seq_order(trial),:));
        case 4
            DrawFormattedText(windowPtr,'WORD','center',rect(4)/2-100,cue_colors(variables.seq_order(trial),:));
            DrawFormattedText(windowPtr,'1 SYLLABLE        2 SYLLABLES','center',rect(4)/2+100,cue_colors(variables.seq_order(trial),:));
    end
    DrawFormattedText(windowPtr,'+','center','center',[0,0,0]);
    cuetime = Screen('Flip',windowPtr);
    variables.cueonset(trial) = cuetime-starttime;
    WaitSecs(0.5);
    
    % prepare to record response
    variables.trialonset(trial) = NaN;
    variables.rtime(trial) = NaN;
    variables.subjanswer(trial) = NaN;
    variables.subjaccuracy(trial) = NaN;
    
    
    % display stimuli:
    weight = 1/2;
    face_img_name{trial} = face_pool(trial).name;
    I1 = imread(char(face_img_name{trial}));
    I1 = imresize(I1, [stim_width stim_height]);
    scene_img_name{trial} = scene_pool(trial).name;
    I2 = imread(char(scene_img_name{trial}));
    I2 = imresize(I2, [stim_width stim_height]);
    imgBlended = (weight*I1) + (weight*I2);
    composite_img_MakeTexture = Screen('MakeTexture', windowPtr, imgBlended);
    Screen('DrawTexture', windowPtr, composite_img_MakeTexture,[],stimPos);
    % draw word
    Screen(windowPtr,'TextSize',175);
    word_ind = randi(4);
    word_img_name{trial} = char(word_pool{randi(5),word_ind});
    DrawFormattedText(windowPtr,word_img_name{trial},'center','center',[0,0,0,weight*255]);
    Screen(windowPtr,'TextSize',32);
    displaytime = Screen('Flip',windowPtr);
    variables.trialonset(trial) = displaytime-starttime;
    
    % correct answer
    switch variables.seq_order(trial)
        case 1
            if ~isempty(regexp(face_img_name{trial},'M', 'once'))
                variables.trial_ans(trial) = 0;
            elseif ~isempty(regexp(face_img_name{trial},'F', 'once'))
                variables.trial_ans(trial) = 1;
            end
        case 2
            if ~isempty(regexp(face_img_name{trial},'A', 'once'))
                variables.trial_ans(trial) = 0;
            elseif ~isempty(regexp(face_img_name{trial},'C', 'once'))
                variables.trial_ans(trial) = 1;
            end
        case 3
            if word_ind == 1 || word_ind == 2
                variables.trial_ans(trial) = 0;
            elseif word_ind == 3 || word_ind == 4
                variables.trial_ans(trial) = 1;
            end
        case 4
            if word_ind == 1 || word_ind == 3
                variables.trial_ans(trial) = 0;
            elseif word_ind == 2 || word_ind == 4
                variables.trial_ans(trial) = 1;
            end
    end
    
    % get subject response
    RestrictKeysForKbCheck([ans_right ans_left]);
    % keyisdown = 0;
    while GetSecs - displaytime < 2
        [keyisdown,secs,keycode] = KbCheck;
        if keycode(ans_right) == 1 || keycode(ans_left) == 1
            variables.rtime(trial) = round((secs-displaytime)*1000); % reaction time in miliseconds
            variables.subjresponsetime(trial) = GetSecs-starttime;
            if keycode(ans_right) == 1
                variables.subjanswer(trial) = 1;
            elseif keycode(ans_left) == 1
                variables.subjanswer(trial) = 0;
            end
            if isequaln(variables.subjanswer(trial),variables.trial_ans(trial))
                variables.subjaccuracy(trial) = 1;
            else  variables.subjaccuracy(trial) = 0;
                PsychPortAudio('Stop', pahandle,1,1);
                PsychPortAudio('FillBuffer', pahandle, wrong_ans_sound);
                startsound = PsychPortAudio('Start', pahandle,1,0,1);
                WaitSecs(1);
                break;
            end
        end
    end
    if isnan(variables.subjanswer(trial))
        PsychPortAudio('Stop', pahandle,1,1);
        PsychPortAudio('FillBuffer', pahandle, wrong_ans_sound);
        startsound = PsychPortAudio('Start', pahandle,1,0,1);
        WaitSecs(1);
    end
    
    if keyisdown == 1 % if button is pressed
        WaitSecs(2-variables.rtime(trial));
    else % otherwise move on directly
    end
    
    DrawFormattedText(windowPtr,'+','center','center',[0,0,0]);
    Screen('Flip',windowPtr);
    WaitSecs(1);
    
end

runtime = GetSecs - starttime;

save(strcat('C:/Users/egnerlab/Desktop/Tanya/task switching and attention/psychtoolbox code/February_2020_Version/data/SwitchAttnMemPart1_',SubjID,'_Practice_','Run',num2str(run_number),'_',time,'.mat'));

overall_accuracy = nansum(variables.subjaccuracy)/ntrials;

%% feedback on accuracy
DrawFormattedText(windowPtr,sprintf('accuracy %2.2f %% \n\n press any key to exit',100*overall_accuracy),'center','center',[0,0,0]);
Screen('Flip',windowPtr);
RestrictKeysForKbCheck([]);
keyisdown = 0;
while ~keyisdown
    [keyisdown,secs,keycode] = KbCheck;
end

end

