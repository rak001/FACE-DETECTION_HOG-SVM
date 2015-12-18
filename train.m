uclear
imlist = dir('Face');
wsize=[24,32];  %% model for [24,32] size image
Data=[];label=[];

for i = 3:length(imlist)
    im = imresize(imread(strcat('Face\',imlist(i).name)),wsize);
    X1=hog_1(im);
    X2=hog_2(im);
    Y1=[];
    for ix=1:length(X1)/9
        Y1=[Y1 X1((ix-1)*9+1:9*ix) X2((ix-1)*18+1:18*ix)];
    end
    Data=[Data;Y1];
    label=[label;1];
end


imlist = dir('Non-Face\');
for i = 3:length(imlist)
    im = imresize(imread(strcat('Non-Face\',imlist(i).name)),wsize);
    X1=hog_1(im);
    X2=hog_2(im);
    Y1=[];
    for ix=1:length(X1)/9
        Y1=[Y1 X1((ix-1)*9+1:9*ix) X2((ix-1)*18+1:18*ix)];
    end
    Data=[Data;Y1];
    label=[label;2];
end



model=svmtrain(label,Data,'-s 0 -t 0 -b 1');
svmmodel{1}=wsize;
svmmodel{2}=model;

save(strcat('model_t0_',int2str(wsize(1)),'_',int2str(wsize(2)),'.mat'),'svmmodel');