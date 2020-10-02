function func_SwitchAttentionPart3(windowPtr,rect,SubjID)

c = clock; %Current date and time as date vector. [year month day hour minute seconds]
time =strcat(num2str(c(1)),'_',num2str(c(2)),'_',num2str(c(3)),'_',num2str(c(4)),'_',num2str(c(5))); %makes unique filename
rand('seed', str2num(SubjID));

part1_file = dir(strcat('C:/Users/egnerlab/Desktop/Tanya/task switching and attention/psychtoolbox code/February_2020_Version/data/SwitchAttnMemPart1_',SubjID,'_Behavioral','*.mat'));
load(part1_file.name);

KbName('UnifyKeyNames');
ans_one = KbName('1!');
ans_two = KbName('2@');
ans_three = KbName('3#');
ans_four = KbName('4$');

%% load stimuli

target_word_img = unique(word_img_name(2:end));
if rem(str2num(SubjID),2)==1
    word_list_all = readtable('C:/Users/egnerlab/Desktop/Tanya/task switching and attention/psychtoolbox code/February_2020_Version/word stimuli.xlsx');
    lure_list = word_list_all(26:49,1:4);
    lure_word_img = [word_list_all.(1);word_list_all.(2);word_list_all.(3);word_list_all.(4)]';
elseif rem(str2num(SubjID),2)==0
    word_list_all = readtable('C:/Users/egnerlab/Desktop/Tanya/task switching and attention/psychtoolbox code/February_2020_Version/word stimuli.xlsx');
    lure_list = word_list_all(1:24,1:4);
    lure_word_img = [word_list_all.(1);word_list_all.(2);word_list_all.(3);word_list_all.(4)]';
end

target_scene_img = unique(scene_img_name(2:end));
if rem(str2num(SubjID),4)==1 || rem(str2num(SubjID),4)==2
    lure_scene_img = unique(regexprep(scene_img_name(2:end),'a.jpg','c.jpg'));
elseif rem(str2num(SubjID),4)==3 || rem(str2num(SubjID),2)==0
    lure_scene_img = unique(regexprep(scene_img_name(2:end),'c.jpg','a.jpg'));
end

nitems = numel(target_word_img);
ntrials = 2*2*nitems;

% To minimize recency memory effects, the test was structured such that words...
% presented in the first half of the experiment were tested first and words...
% presented in the second half of the experiment were tested second. However, ...
% within each half, the test trials were randomized.
variables.word_test_order = [randperm(nitems/2), nitems/2+randperm(nitems/2)];
variables.scene_test_order = [randperm(nitems/2), nitems/2+randperm(nitems/2)];

% order of words and scenes (we want them intermixed)
variables.word_scene_order = [];
for i = 1:2*nitems
    temp = randperm(2);
    variables.word_scene_order = [variables.word_scene_order, temp];
end

% order of whether it is a target or lure
variables.word_target_lure = [];
variables.scene_target_lure = [];
for i = 1:nitems
    temp = randperm(2);
    variables.word_target_lure = [variables.word_target_lure, temp];
    temp = randperm(2);
    variables.scene_target_lure = [variables.scene_target_lure, temp];
end

%% set up email to send to researcher when participant is almost done
% parameters
mail = 'dukepsych.mail@gmail.com'; % my gmail address
password = 'Send2Researcher';  % my gmail password
host = 'smtp.gmail.com';
sendto = 'jack.dolgin@duke.edu';
Subject = sprintf('Subject %s is almost done',SubjID);
Message = sprintf('Subject %s is almost done',SubjID);
% preferences
setpref('Internet','SMTP_Server', host);
setpref('Internet','E_mail',mail);
setpref('Internet','SMTP_Username',mail);
setpref('Internet','SMTP_Password',password);
props = java.lang.System.getProperties;
props.setProperty('mail.smtp.auth','true');
props.setProperty('mail.smtp.socketFactory.class', 'javax.net.ssl.SSLSocketFactory');
props.setProperty('mail.smtp.socketFactory.port','465');

%% run experiment
RestrictKeysForKbCheck([]);
DrawFormattedText(windowPtr,'PART 3 MAIN EXPERIMENT \n\n\n Press any key to begin','center','center',[0,0,0]);
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
% Specifying the weight for image blending
weight = 1/2;
stimPos = [rect(3)/2 - stim_width/2, rect(4)/2 - stim_height/2, rect(3)/2 + stim_width/2, rect(4)/2 + stim_height/2];


starttime = GetSecs;
word_target_cntr = 1;
word_lure_cntr = 1;
word_cntr = 1;
scene_target_cntr = 1;
scene_lure_cntr = 1;
scene_cntr = 1;

for trial = 1:ntrials
    
    % present test and lure items
    if variables.word_scene_order(trial) == 1 %word
        if variables.word_target_lure(word_cntr) == 1
            variables.img_name{trial} = target_word_img{variables.word_test_order(word_target_cntr)};
            Screen(windowPtr,'TextSize',175);
            DrawFormattedText(windowPtr,variables.img_name{trial},'center','center',[0,0,0,weight*255]);
            Screen(windowPtr,'TextSize',32);
            variables.target_lure(trial) = 2;
            word_target_cntr = word_target_cntr + 1;
        elseif variables.word_target_lure(word_cntr) == 2
            variables.img_name{trial} = lure_word_img{variables.word_test_order(word_lure_cntr)};
            Screen(windowPtr,'TextSize',175);
            DrawFormattedText(windowPtr,variables.img_name{trial},'center','center',[0,0,0,weight*255]);
            Screen(windowPtr,'TextSize',32);
            variables.target_lure(trial) = 1;
            word_lure_cntr = word_lure_cntr + 1;
        end
        word_cntr = word_cntr + 1;
    elseif variables.word_scene_order(trial) == 2 %scene
        if variables.word_target_lure(scene_cntr) == 1
            white_img_size = size(imread(target_scene_img{variables.scene_test_order(scene_target_cntr)}));
            target_img = Screen('MakeTexture', windowPtr, weight*255.*ones(white_img_size,'uint8') + weight*imread(target_scene_img{variables.scene_test_order(scene_target_cntr)}));
            variables.img_name{trial} = target_scene_img{variables.scene_test_order(scene_target_cntr)};
            Screen('DrawTexture', windowPtr, target_img, [], stimPos);
            variables.target_lure(trial) = 2;
            scene_target_cntr = scene_target_cntr + 1;
        elseif variables.word_target_lure(scene_cntr) == 2
            white_img_size = size(imread(lure_scene_img{variables.scene_test_order(scene_lure_cntr)}));
            lure_img = Screen('MakeTexture', windowPtr, weight*255.*ones(white_img_size,'uint8') + weight*imread(lure_scene_img{variables.scene_test_order(scene_lure_cntr)}));
            variables.img_name{trial} = lure_scene_img{variables.scene_test_order(scene_lure_cntr)};
            Screen('DrawTexture', windowPtr, lure_img, [], stimPos);
            variables.target_lure(trial) = 1;
            scene_lure_cntr = scene_lure_cntr + 1;
        end
        scene_cntr = scene_cntr + 1;
    end
    
    
    rating_img = Screen('MakeTexture', windowPtr, imread('ratingscale.jpg'));
    Screen('DrawTexture', windowPtr, rating_img, [], [rect(3)/2 - 320, rect(4)/2 + 320, rect(3)/2 + 320, rect(4)/2 + 420]);
    
    displaytime = Screen('Flip',windowPtr);
    variables.trialonset(trial) = displaytime-starttime;
    
    % prepare to record response
    variables.rtime(trial) = NaN;
    variables.subjresponse(trial) = NaN;
    variables.subjanswer(trial) = NaN;
    variables.subjaccuracy(trial) = NaN;
    
    
    % get subject response
    RestrictKeysForKbCheck([ans_one ans_two ans_three ans_four]);
    keyisdown = 0;
    while ~keyisdown
        [keyisdown,secs,keycode] = KbCheck;
        if keycode(ans_one) == 1 || keycode(ans_two) == 1 || keycode(ans_three) == 1 || keycode(ans_four) == 1
            variables.rtime(trial) = round((secs-displaytime)*1000); % reaction time in miliseconds
            variables.subjresponsetime(trial) = GetSecs-starttime;
            if keycode(ans_one) == 1
                variables.subjresponse(trial) = 1;
                variables.subjanswer(trial) = 1;
            elseif keycode(ans_two) == 1
                variables.subjresponse(trial) = 2;
                variables.subjanswer(trial) = 1;
            elseif keycode(ans_three) == 1
                variables.subjresponse(trial) = 3;
                variables.subjanswer(trial) = 2;
            elseif keycode(ans_four) == 1
                variables.subjresponse(trial) = 4;
                variables.subjanswer(trial) = 2;
            end
            DrawFormattedText(windowPtr,'+','center','center',[0,0,0]);
            Screen('Flip',windowPtr);
        end
    end
    WaitSecs(0.1);
    DrawFormattedText(windowPtr,'+','center','center',[0,0,0]);
    Screen('Flip',windowPtr);
    
    if isequaln(variables.subjanswer(trial),variables.target_lure(trial))
        variables.subjaccuracy(trial) = 1;
    else  variables.subjaccuracy(trial) = 0;
    end
    WaitSecs(0.75);
    
    
    %% notify researcher when participant is almost done
    if trial == ntrials - 10
        % execute
        sendmail(sendto,Subject,Message)
    end
end
save(strcat('C:/Users/egnerlab/Desktop/Tanya/task switching and attention/psychtoolbox code/February_2020_Version/data/SwitchAttnMemPart3_',SubjID,'_Behavioral_',time,'.mat'));

%% feedback on accuracy
DrawFormattedText(windowPtr,sprintf('accuracy %2.2f %% \n\n press any key to exit',100*nansum(variables.subjaccuracy)/ntrials),'center','center',[0,0,0]);
Screen('Flip',windowPtr);
RestrictKeysForKbCheck([]);
keyisdown = 0;
while ~keyisdown
    [keyisdown,secs,keycode] = KbCheck;
end

end