function[P3]= detect(im,svmmodel,wSize)
%{
this function will take three parameters
    1.  im      --> Test Image
    2.  model   --> trained model
    3.  wStize  --> Size of the window, i.e. [24,32]*3
and draw rectangle on best estimated window
%}
if(ndims(im)==3)
    im=rgb2gray(im);
end
model_size=svmmodel{1};
model=svmmodel{2};
nx = size(im);
F=floor(nx./(wSize/2));

fcount = 1;
featureVector=[];

% this for loop scan the entire image and extract features for each sliding window
for y = 1:F(1)-1
    for x = 1:F(2)-1
        p1 = [(x-1)*floor(wSize(2)/2)+1,(y-1)*floor(wSize(1)/2)+1];
        p2 = [p1(1)+(wSize(2)-1), p1(2)+(wSize(1)-1)];
        
        img = im(p1(2):p2(2),p1(1):p2(1));     
        
        img=imresize(img,model_size);        
        X1=hog_1(img);
        X2=hog_2(img);
        Y1=[];
        for ix=1:length(X1)/9
            Y1=[Y1 X1((ix-1)*9+1:9*ix) X2((ix-1)*18+1:18*ix)];
        end
        
        featureVector=[featureVector;Y1];
        boxPoint{fcount} = p1;
        fcount = fcount+1;

    end
end

label = ones(size(featureVector,1),1);
% each row of P' correspond to a window
[P1,~,P3]=svmpredict(label,featureVector,model,'-b 1');

  imshow(im);
  indx=find(P1==1);
  for i=1:length(indx)
      if(P3(indx(i),1)>.7)
  bBox = cell2mat(boxPoint(indx(i)));
  rectangle('Position',[bBox(1),bBox(2),wSize],'LineWidth',1, 'EdgeColor','r');
      end
  end
end