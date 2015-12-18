uclear
li=dir('yalefaces\yalefaces\');
mkdir('yaleFaceResult');
wSize=[48,64]*3;
load('model_t0_24_32.mat')
c=1;
for i=3:length(li)
im=imread(strcat('yalefaces\yalefaces\',li(i).name));
detect(im,svmmodel,wSize);
print(strcat('yaleFaceResult\',int2str(c),'.png'),'-dpng')
c=c+1;
end
