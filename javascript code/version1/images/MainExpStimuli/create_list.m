fileID = fopen('list.txt','w');
% faces
for i = 1:12
    fprintf(fileID,'"images/main exp stimuli/faces/MA_%02d.jpg", ',i);
end
for i = 1:12
    fprintf(fileID,'"images/main exp stimuli/faces/MC_%02d.jpg", ',i);
end
for i = 1:12
    fprintf(fileID,'"images/main exp stimuli/faces/FA_%02d.jpg", ',i);
end
for i = 1:12
    fprintf(fileID,'"images/main exp stimuli/faces/FC_%02d.jpg", ',i);
end
% words
for i = 1:12
    fprintf(fileID,'"images/main exp stimuli/words/A1_%02d.jpg", ',i);
end
for i = 1:12
    fprintf(fileID,'"images/main exp stimuli/words/A2_%02d.jpg", ',i);
end
for i = 1:12
    fprintf(fileID,'"images/main exp stimuli/words/C1_%02d.jpg", ',i);
end
for i = 1:12
    fprintf(fileID,'"images/main exp stimuli/words/C2_%02d.jpg", ',i);
end
% scenes
for i = 1:24
    fprintf(fileID,'"images/main exp stimuli/scenes/I_%02d.jpg", ',i);
end
for i = 1:24
    fprintf(fileID,'"images/main exp stimuli/scenes/O_%02d.jpg", ',i);
end
fclose(fileID);