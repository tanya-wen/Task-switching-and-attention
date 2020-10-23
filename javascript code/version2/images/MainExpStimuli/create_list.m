fileID = fopen('list.txt','w');
% faces
for i = 1:25
    fprintf(fileID,'"images/MainExpStimuli/faces/M_C_%03d.jpg", ',i);
end
for i = 1:25
    fprintf(fileID,'"images/MainExpStimuli/faces/F_C_%03d.jpg", ',i);
end
% words
for i = 1:25
    fprintf(fileID,'"images/MainExpStimuli/words/U_%02d.png", ',i);
end
for i = 1:25
    fprintf(fileID,'"images/MainExpStimuli/words/L_%02d.png", ',i);
end
% scenes
for i = 1:25
    fprintf(fileID,'"images/MainExpStimuli/scenes/I_%02d.jpg", ',i);
end
for i = 1:25
    fprintf(fileID,'"images/MainExpStimuli/scenes/O_%02d.jpg", ',i);
end
fclose(fileID);