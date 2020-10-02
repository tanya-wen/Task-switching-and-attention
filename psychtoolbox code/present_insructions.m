function present_insructions(part,windowPtr)

button_left = KbName('LeftArrow');
button_right = KbName('RightArrow');

ready_to_start = 0;
page = 1;

switch part
    
    %%
    case 1
        
        while ready_to_start ~=1
            
            switch page
                case 1
                    instuctions_img = Screen('MakeTexture', windowPtr, imread('part1_page1.jpg'));
                    Screen('DrawTexture', windowPtr, instuctions_img);
                    Screen('Flip',windowPtr);
                    WaitSecs(0.1);
                    RestrictKeysForKbCheck([button_right]);
                    keyisdown = 0;
                    while ~keyisdown
                        [keyisdown,secs,keycode] = KbCheck;
                        if keycode(button_right) == 1
                            page = 2;
                        end
                    end
                case 2
                    instuctions_img = Screen('MakeTexture', windowPtr, imread('part1_page2.jpg'));
                    Screen('DrawTexture', windowPtr, instuctions_img);
                    Screen('Flip',windowPtr);
                    WaitSecs(0.1);
                    RestrictKeysForKbCheck([button_left,button_right]);
                    keyisdown = 0;
                    while ~keyisdown
                        [keyisdown,secs,keycode] = KbCheck;
                        if keycode(button_right) == 1
                            page = 3;
                        elseif keycode(button_left) == 1
                            page = 1;
                        end
                    end
                case 3
                    instuctions_img = Screen('MakeTexture', windowPtr, imread('part1_page3.jpg'));
                    Screen('DrawTexture', windowPtr, instuctions_img);
                    Screen('Flip',windowPtr);
                    WaitSecs(0.1);
                    RestrictKeysForKbCheck([button_left,button_right]);
                    keyisdown = 0;
                    while ~keyisdown
                        [keyisdown,secs,keycode] = KbCheck;
                        if keycode(button_right) == 1
                            page = 4;
                        elseif keycode(button_left) == 1
                            page = 2;
                        end
                    end
                case 4
                    instuctions_img = Screen('MakeTexture', windowPtr, imread('part1_page4.jpg'));
                    Screen('DrawTexture', windowPtr, instuctions_img);
                    Screen('Flip',windowPtr);
                    WaitSecs(0.1);
                    RestrictKeysForKbCheck([button_left,button_right]);
                    keyisdown = 0;
                    while ~keyisdown
                        [keyisdown,secs,keycode] = KbCheck;
                        if keycode(button_right) == 1
                            ready_to_start = 1;
                        elseif keycode(button_left) == 1
                            page = 3;
                        end
                    end
            end
            
        end
        
        %%
    case 2
        
        while ready_to_start ~=1
            
            switch page
                case 1
                    instuctions_img = Screen('MakeTexture', windowPtr, imread('part2_page1.jpg'));
                    Screen('DrawTexture', windowPtr, instuctions_img);
                    Screen('Flip',windowPtr);
                    WaitSecs(0.1);
                    RestrictKeysForKbCheck([button_right]);
                    keyisdown = 0;
                    while ~keyisdown
                        [keyisdown,secs,keycode] = KbCheck;
                        if keycode(button_right) == 1
                            page = 2;
                        end
                    end
                case 2
                    instuctions_img = Screen('MakeTexture', windowPtr, imread('part2_page2.jpg'));
                    Screen('DrawTexture', windowPtr, instuctions_img);
                    Screen('Flip',windowPtr);
                    WaitSecs(0.1);
                    RestrictKeysForKbCheck([button_left,button_right]);
                    keyisdown = 0;
                    while ~keyisdown
                        [keyisdown,secs,keycode] = KbCheck;
                        if keycode(button_right) == 1
                            ready_to_start = 1;
                        elseif keycode(button_left) == 1
                            page = 1;
                        end
                    end
            end
            
        end
        
        %%
    case 3
        
        while ready_to_start ~=1
            
            switch page
                case 1
                    instuctions_img = Screen('MakeTexture', windowPtr, imread('part3_page1.jpg'));
                    Screen('DrawTexture', windowPtr, instuctions_img);
                    Screen('Flip',windowPtr);
                    WaitSecs(0.1);
                    RestrictKeysForKbCheck([button_right]);
                    keyisdown = 0;
                    while ~keyisdown
                        [keyisdown,secs,keycode] = KbCheck;
                        if keycode(button_right) == 1
                            page = 2;
                        end
                    end
                case 2
                    instuctions_img = Screen('MakeTexture', windowPtr, imread('part3_page2.jpg'));
                    Screen('DrawTexture', windowPtr, instuctions_img);
                    Screen('Flip',windowPtr);
                    WaitSecs(0.1);
                    RestrictKeysForKbCheck([button_left,button_right]);
                    keyisdown = 0;
                    while ~keyisdown
                        [keyisdown,secs,keycode] = KbCheck;
                        if keycode(button_right) == 1
                            ready_to_start = 1;
                        elseif keycode(button_left) == 1
                            page = 1;
                        end
                    end
            end
            
        end
        
end


end