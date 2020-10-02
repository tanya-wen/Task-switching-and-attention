face_img = '/Users/tanyawen/Box/Home Folder tw260/Private/task switching and attention/javascript code/images/MainExpStimuli/faces/FA_01.jpg';
scene_img = '/Users/tanyawen/Box/Home Folder tw260/Private/task switching and attention/javascript code/images/MainExpStimuli/scenes/O_p.jpg';
word_img = '/Users/tanyawen/Box/Extra_Space_for_Tanya/Stimuli/Word Stimuli/A1_p.jpg';

I1 = imread(face_img);
I1 = imresize(I1, [600 600]);
I2 = imread(scene_img);
I2 = imresize(I2, [600 600]);
I3 = imread(word_img);
I3 = imresize(I3, [600 600]);

% Specifying the weight for image blending
weight = 1/3;

% Calculating blended image using arithmetic expression
imgBlended = (weight*I1) + (weight*I2) + (weight*I3);
imshow(imgBlended)
set(gcf,'color','w')
axis tight equal

saveas(gcf,'/Users/tanyawen/Box/Home Folder tw260/Private/task switching and attention/javascript code/images/main exp stimuli/MC_C2_O.jpg');
