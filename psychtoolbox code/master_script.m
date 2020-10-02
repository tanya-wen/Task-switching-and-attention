%%-- master script --%%

clear all; close all; clc; dbstop if error
addpath(genpath('C:/Users/egnerlab/Desktop/Tanya/task switching and attention/psychtoolbox code/February_2020_Version'));

%% input subject information
prompt = {'Enter paticipant number'};
defaults = {'001'};
answer = inputdlg(prompt, 'Experimental Setup Information', 1, defaults);
[SubjID] = deal(answer{:});


%% Set screen parameters
AssertOpenGL;
InitializePsychSound;
fs = 44100; %sampling rate
nrchannels = 2; % number of channels
pahandle = PsychPortAudio('Open', [], [], 1, fs, nrchannels);% latency setting of 1
Screen('Preference', 'SkipSyncTests', 1);
screens = Screen('Screens');
whichscreen = max(screens);
[windowPtr, rect] = Screen('OpenWindow',whichscreen,[255 255 255]);
Screen('BlendFunction', windowPtr, GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
Priority(MaxPriority(windowPtr));
FontSize = Screen(windowPtr,'TextSize',32);
FontName = Screen(windowPtr,'TextFont','Arial');
HideCursor;
ListenChar(2);

KbName('UnifyKeyNames');


%% Part1 practice (keep practicing until accuracy is at least 85%)
present_insructions(1,windowPtr)
overall_accuracy = 0;
run_number = 1;
while overall_accuracy < 0.85
    overall_accuracy = func_Practice_SwitchAttentionPart1(windowPtr,rect,pahandle,run_number,SubjID);
    run_number = run_number + 1;
end


%% Part1 
func_SwitchAttentionPart1(windowPtr,rect,pahandle,SubjID);


%% Part2 practice (keep practicing until accuracy is at least 85%)
present_insructions(2,windowPtr)
overall_accuracy = 0;
run_number = 1;
while overall_accuracy < 0.85
    overall_accuracy = func_Practice_SwitchAttentionPart2(windowPtr,rect,run_number,SubjID);
    run_number = run_number + 1;
end



%% Part2
func_SwitchAttentionPart2(windowPtr,rect,SubjID);

%% Part3
present_insructions(3,windowPtr)
func_SwitchAttentionPart3(windowPtr,rect,SubjID);

%% Close window
Screen('CloseAll');
PsychPortAudio('Close', pahandle);
ShowCursor;
ListenChar(0);
Priority(0);
