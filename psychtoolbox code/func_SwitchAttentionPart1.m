function func_SwitchAttentionPart1(windowPtr,rect,pahandle,SubjID)

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
    4 4 8 8]*3;
ntrials_of_interest = sum(test_mat(:));
% gender, age, Concreteness, Syllable

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

for i = 2:numel(current_rule)
    
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
        elseif strcmp(preceding_category{i-1},current_category{i}) == 1
            switchtype.switch_condition{i} = 'within';
        elseif strcmp(preceding_category{i-1},current_category{i}) ~=1
            switchtype.switch_condition{i} = 'between';
        end
    end
    
end
switchtype.switch_condition{1} = 'x';


%% load images
nrepetitions_per_img = 3; %if too difficult change to 6
nswitch_type = 3;
nrule_type = 4;

%%% faces %%%
face_list = dir(fullfile('C:/Users/egnerlab/Desktop/Tanya/task switching and attention/psychtoolbox code/February_2020_Version/face stimuli','*_*.jpg'));
face_list_FA = dir(fullfile('C:/Users/egnerlab/Desktop/Tanya/task switching and attention/psychtoolbox code/February_2020_Version/face stimuli','F_A_*.jpg'));
face_list_MA = dir(fullfile('C:/Users/egnerlab/Desktop/Tanya/task switching and attention/psychtoolbox code/February_2020_Version/face stimuli','M_A_*.jpg'));
face_list_FC = dir(fullfile('C:/Users/egnerlab/Desktop/Tanya/task switching and attention/psychtoolbox code/February_2020_Version/face stimuli','F_C_*.jpg'));
face_list_MC = dir(fullfile('C:/Users/egnerlab/Desktop/Tanya/task switching and attention/psychtoolbox code/February_2020_Version/face stimuli','M_C_*.jpg'));
nimg_per_cond = ntrials_of_interest/nrepetitions_per_img/4;
face_pool = [face_list_FA(randsample(numel(face_list_FA),nimg_per_cond));
    face_list_MA(randsample(numel(face_list_MA),nimg_per_cond));
    face_list_FC(randsample(numel(face_list_FC),nimg_per_cond));
    face_list_MC(randsample(numel(face_list_MC),nimg_per_cond))];
face_list_name = {face_list.name};
face_pool_name = {face_pool.name};
face_firsttrial_pool = setdiff(face_list_name,face_pool_name,'rows');

%%% Words %%%
if rem(str2num(SubjID),2)==1
    word_list_all = readtable('C:/Users/egnerlab/Desktop/Tanya/task switching and attention/psychtoolbox code/February_2020_Version/word stimuli.xlsx');
    word_list = word_list_all(1:25,1:4);
    word_list_A1 = word_list_all(1:24,1);
    word_list_A2 = word_list_all(1:24,2);
    word_list_C1 = word_list_all(1:24,3);
    word_list_C2 = word_list_all(1:24,4);
elseif rem(str2num(SubjID),2)==0
    word_list_all = readtable('C:/Users/egnerlab/Desktop/Tanya/task switching and attention/psychtoolbox code/February_2020_Version/word stimuli.xlsx');
    word_list = word_list_all(26:50,1:4);
    word_list_A1 = word_list_all(26:49,1);
    word_list_A2 = word_list_all(26:49,2);
    word_list_C1 = word_list_all(26:49,3);
    word_list_C2 = word_list_all(26:49,4);
end
nimg_per_cond = ntrials_of_interest/nrepetitions_per_img/4;
word_pool = [word_list_A1(1:nimg_per_cond,1),...
    word_list_A2(1:nimg_per_cond,1),...
    word_list_C1(1:nimg_per_cond,1),...
    word_list_C2(1:nimg_per_cond,1)];
word_firsttrial_pool = setdiff(word_list,word_pool);

%%% scenes %%%
if rem(str2num(SubjID),4)==1 || rem(str2num(SubjID),4)==2
    scene_list = dir(fullfile('C:/Users/egnerlab/Desktop/Tanya/task switching and attention/psychtoolbox code/February_2020_Version/scene stimuli unique','*a.jpg'));
    scene_list_I = dir(fullfile('C:/Users/egnerlab/Desktop/Tanya/task switching and attention/psychtoolbox code/February_2020_Version/scene stimuli unique','I_*_a.jpg'));
    scene_list_O = dir(fullfile('C:/Users/egnerlab/Desktop/Tanya/task switching and attention/psychtoolbox code/February_2020_Version/scene stimuli unique','O_*_a.jpg'));
elseif rem(str2num(SubjID),4)==3 || rem(str2num(SubjID),2)==0
    scene_list = dir(fullfile('C:/Users/egnerlab/Desktop/Tanya/task switching and attention/psychtoolbox code/February_2020_Version/scene stimuli unique','*c.jpg'));
    scene_list_I = dir(fullfile('C:/Users/egnerlab/Desktop/Tanya/task switching and attention/psychtoolbox code/February_2020_Version/scene stimuli unique','I_*_c.jpg'));
    scene_list_O = dir(fullfile('C:/Users/egnerlab/Desktop/Tanya/task switching and attention/psychtoolbox code/February_2020_Version/scene stimuli unique','O_*_c.jpg'));
end
nimg_per_cond = ntrials_of_interest/nrepetitions_per_img/2;
scene_pool = [scene_list_I(randsample(numel(scene_list_I),nimg_per_cond));
    scene_list_O(randsample(numel(scene_list_O),nimg_per_cond))];
scene_list_name = {scene_list.name};
scene_pool_name = {scene_pool.name};
scene_firsttrial_pool = setdiff(scene_list_name,scene_pool_name,'rows');

%% load incorrect sound
[y,Fs] = audioread('C:/Users/egnerlab/Desktop/Tanya/task switching and attention/psychtoolbox code/February_2020_Version/wrong_ans_sound.mp3');
wrong_ans_sound = y(1:44100,:)';

%% counterbalance & preload images
RestrictKeysForKbCheck([]);
DrawFormattedText(windowPtr,sprintf('PART 1 MAIN EXPERIMENT \n\n\n Loading images\n\n please wait patiently...'),'center','center',[0,0,0]);
Screen('Flip',windowPtr);

types_of_switch = {'stay','within','between'};
used_words_A1 = []; used_words_A2 = []; used_words_C1 = []; used_words_C2 = [];

for switch_type = 1:3
    for rule_type = 1:4
        
        ind = find(ismember(switchtype.switch_condition,types_of_switch{switch_type}) & variables.seq_order==rule_type);
        rand_ind = ind(randperm(numel(ind)));
        
        %% faces
        cntr_f = 1;
        for gender = {'M','F'}
            for race = {'A','C'}
                sample_face = find(~cellfun(@isempty,regexp({face_pool.name},sprintf('%s_%s',gender{1},race{1}))));
                face_img = datasample(sample_face,numel(rand_ind)/nrepetitions_per_img/4,'Replace',false);
                for nrep = 1:nrepetitions_per_img
                    for cntr = 1:numel(ind)/nrepetitions_per_img/4
                        % save image index
                        face_img_name{rand_ind(cntr_f)} = face_pool(face_img(cntr)).name;
                        % save correct answer
                        if (rule_type == 1 && ismember(gender,'M')) || (rule_type == 2 && ismember(race,'A'))
                            variables.trial_ans(rand_ind(cntr_f)) = 0;
                        elseif (rule_type == 1 && ismember(gender,'F')) || (rule_type == 2 && ismember(race,'C'))
                            variables.trial_ans(rand_ind(cntr_f)) = 1;
                        end
                        cntr_f = cntr_f + 1;
                    end
                end
                % delete used image from pool
                face_pool(face_img) = [];
            end
        end
        
        %% Words
        cntr_w = 1;
        for concreteness = {'Abstract','Concrete'}
            for syllable = {'1','2'}
                switch concreteness{1}
                    case 'Abstract'
                        switch syllable{1}
                            case '1'
                                sample_word = word_pool.Abstract_1;
                                word_img = datasample(setdiff(1:length(sample_word),used_words_A1),numel(rand_ind)/nrepetitions_per_img/4,'Replace',false);
                            case '2'
                                sample_word = word_pool.Abstract_2;
                                word_img = datasample(setdiff(1:length(sample_word),used_words_A2),numel(rand_ind)/nrepetitions_per_img/4,'Replace',false);
                        end
                    case 'Concrete'
                        switch syllable{1}
                            case '1'
                                sample_word = word_pool.Concrete_1;
                                word_img = datasample(setdiff(1:length(sample_word),used_words_C1),numel(rand_ind)/nrepetitions_per_img/4,'Replace',false);
                            case '2'
                                sample_word = word_pool.Concrete_2;
                                word_img = datasample(setdiff(1:length(sample_word),used_words_C2),numel(rand_ind)/nrepetitions_per_img/4,'Replace',false);
                        end
                end
                
                
                for nrep = 1:nrepetitions_per_img
                    for cntr = 1:numel(ind)/nrepetitions_per_img/4
                        % store word index
                        word_img_name{rand_ind(cntr_w)} = char(sample_word(word_img(cntr)));
                        % save correct answer
                        if (rule_type == 3 && ismember(concreteness,'Abstract')) || (rule_type == 4 && ismember(syllable,'1'))
                            variables.trial_ans(rand_ind(cntr_w)) = 0;
                        elseif (rule_type == 3 && ismember(concreteness,'Concrete')) || (rule_type == 4 && ismember(syllable,'2'))
                            variables.trial_ans(rand_ind(cntr_w)) = 1;
                        end
                        cntr_w = cntr_w + 1;
                    end
                end
                % delete used image index from pool
                switch concreteness{1}
                    case 'Abstract'
                        switch syllable{1}
                            case '1'
                                used_words_A1 = [used_words_A1, word_img];
                            case '2'
                                used_words_A2 = [used_words_A2, word_img];
                        end
                    case 'Concrete'
                        switch syllable{1}
                            case '1'
                                used_words_C1 = [used_words_C1, word_img];
                            case '2'
                                used_words_C2 = [used_words_C2, word_img];
                        end
                end
                
                
            end
        end
        
        
        %% scenes
        cntr_s = 1;
        for i = {'I','O'}
            sample_scene = find(~cellfun(@isempty,regexp({scene_pool.name},sprintf('%s',i{1}))));
            scene_img = datasample(sample_scene,numel(rand_ind)/nrepetitions_per_img/2,'Replace',false);
            for nrep = 1:nrepetitions_per_img
                for cntr = 1:numel(ind)/nrepetitions_per_img/2
                    scene_img_name{rand_ind(cntr_s)} = scene_pool(scene_img(cntr)).name;
                    cntr_s = cntr_s + 1;
                end
            end
            % delete used image from pool
            scene_pool(scene_img) = [];
        end
        
        
    end
end

%%first trial
sample_face = find(~cellfun(@isempty,regexp(face_firsttrial_pool,sprintf('_'))));
face_img = datasample(sample_face,1);
face_img_name{1} = face_firsttrial_pool(face_img);
if (variables.seq_order(1) == 1 && ismember('M',face_firsttrial_pool{face_img})) || (variables.seq_order(1) == 2 && ismember('A',face_firsttrial_pool{face_img}))
    variables.trial_ans(1) = 0;
elseif (variables.seq_order(1) == 1 && ismember('F',face_firsttrial_pool{face_img})) || (variables.seq_order(1) == 2 && ismember('C',face_firsttrial_pool{face_img}))
    variables.trial_ans(1) = 1;
end

temp_ind_word = randi(numel(word_firsttrial_pool));
word_img_name{1} = char(word_firsttrial_pool.(temp_ind_word));
if (variables.seq_order(1) == 3 && temp_ind_word <= 2) || (variables.seq_order(1) == 4 && rem(temp_ind_word,2) == 1)
    variables.trial_ans(1) = 0;
elseif (variables.seq_order(1) == 3 && temp_ind_word >= 3) || (variables.seq_order(1) == 4 && rem(temp_ind_word,2) == 0)
    variables.trial_ans(1) = 1;
end

temp_ind_scene = randi(numel(scene_firsttrial_pool));
scene_img_name{1} = scene_firsttrial_pool(temp_ind_scene);


%% prepare images

stim_width = 640;
stim_height = 640;

% Specifying the weight for image blending
weight = 1/2;

for i = 1:ntrials
    
    %%% percentage loaded
    DrawFormattedText(windowPtr,sprintf('PART 1 MAIN EXPERIMENT \n\n\n Loading images\n\n please wait patiently...\n\n loaded %2.2f %%',100*i/ntrials),'center','center',[0,0,0]);
    Screen('Flip',windowPtr);
    %%%
    
    I1 = imread(char(face_img_name{i}));
    I1 = imresize(I1, [stim_width stim_height]);
    I2 = imread(char(scene_img_name{i}));
    I2 = imresize(I2, [stim_width stim_height]);
    imgBlended = (weight*I1) + (weight*I2);
    
    composite_img_MakeTexture(i) = Screen('MakeTexture', windowPtr, imgBlended);
end

%% run experiment
DrawFormattedText(windowPtr,'Press any key to begin','center','center',[0,0,0]);
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
    % draw face-scene composite
    Screen('DrawTexture', windowPtr, composite_img_MakeTexture(trial),[],stimPos);
    % draw word
    Screen(windowPtr,'TextSize',175);
    DrawFormattedText(windowPtr,word_img_name{trial},'center','center',[0,0,0,weight*255]);
    Screen(windowPtr,'TextSize',32);
    displaytime = Screen('Flip',windowPtr);
    variables.trialonset(trial) = displaytime-starttime;
    
    
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

save(strcat('C:/Users/egnerlab/Desktop/Tanya/task switching and attention/psychtoolbox code/February_2020_Version/data/SwitchAttnMemPart1_',SubjID,'_Behavioral_',time,'.mat'));

%% feedback on accuracy
DrawFormattedText(windowPtr,sprintf('accuracy %2.2f %% \n\n press any key to exit',100*nansum(variables.subjaccuracy)/ntrials),'center','center',[0,0,0]);
Screen('Flip',windowPtr);
RestrictKeysForKbCheck([]);
keyisdown = 0;
while ~keyisdown
    [keyisdown,secs,keycode] = KbCheck;
end

end
