clear;clc;
li=dir('yaleface\yaleface\');
detector=vision.CascadeObjectDetector('FrontalFaceCART');
mkdir('Face');
mkdir('Non-Face');
c=1;
for i=3:length(li)
image=imread(strcat('yaleface\yaleface\',li(i).name));
BBOX=step(detector,image);
if(isempty(BBOX)~=1 && size(BBOX,1)==1)
F=(image(BBOX(2):BBOX(2)+BBOX(4),BBOX(1):BBOX(1)+BBOX(3)));
imwrite(imresize(F,[50 50]),strcat('Face\',int2str(c),'.png'),'PNG');
c=c+1;
end
end




%%% for Non-Face copy images with no face