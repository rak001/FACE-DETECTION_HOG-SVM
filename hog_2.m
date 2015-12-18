function [ feature ] = hog_2( im )
% The given code finds the HOG feature vector for any given image. HOG
% feature vector/descriptor can then be used for detection of any
% particular object. 

% INPUT => im (input image)
% OUTPUT => Signed HOG feature vector for that particular image

% Example: Running the code
% >>> im = imread('cameraman.tif');
% >>> hog = hog_feature_vector (im);



% Convert RGB iamge to grayscale
if size(im,3)==3
    im=rgb2gray(im);
end
im=double(im);

rows=size(im,1);
cols=size(im,2);
Ix=im; %Basic Matrix assignment
Iy=im; %Basic Matrix assignment

% Gradients in X and Y direction. Iy is the gradient in X direction and Iy
% is the gradient in Y direction
for i=1:rows-2
    Iy(i,:)=(im(i,:)-im(i+2,:));
end
Iy(rows-1,:)=Iy(rows-2,:);
Iy(rows,:)=Iy(rows-2,:);
for i=1:cols-2
    Ix(:,i)=(im(:,i)-im(:,i+2));
end
Ix(:,cols-1)=Ix(:,cols-2);
Ix(:,cols)=Ix(:,cols-2);

%gauss=fspecial('gaussian',8); %% Initialized a gaussian filter with sigma=0.5 * block width.    

angle=atan2(Ix,Iy); % Matrix containing the angles of each edge gradient
angle=angle*180/pi;
angle=imadd(angle,180); %Angles in range (0,180)
magnitude=sqrt(Ix.^2 + Iy.^2);

% figure,imshow(uint8(angle));
% figure,imshow(uint8(magnitude));

% Remove redundant pixels in an image. 
angle(isnan(angle))=0;
magnitude(isnan(magnitude))=0;

feature=[]; %initialized the feature vector

% Iterations for Blocks
for i = 0: (rows-1)/8 - 1
    for j= 0: (cols-1)/8 -1
        %disp([i,j])
        
        magA = magnitude(8*i+1 : 8*i+8 , 8*j+1 : 8*j+8);
        %mag_patch = imfilter(mag_patch,gauss);
        angleA = angle(8*i+1 : 8*i+8 , 8*j+1 : 8*j+8);
        
        block_feature=[];
        
        %Iterations for cells in a block
        %for x= 0:1
            %for y= 0:1
                %angleA =ang_patch(8*x+1:8*x+8, 8*y+1:8*y+8);
                %magA   =mag_patch(8*x+1:8*x+8, 8*y+1:8*y+8); 
                histr  =zeros(1,18);
                
                %Iterations for pixels in one cell
                for p=1:8
                    for q=1:8
%                       
                        alpha= angleA(p,q);
                        
                        % Binning Process (Bi-Linear Interpolation)
                        if alpha>10 && alpha<=30
                            histr(1)=histr(1)+ magA(p,q)*(30-alpha)/20;
                            histr(2)=histr(2)+ magA(p,q)*(alpha-10)/20;
                        elseif alpha>30 && alpha<=50
                            histr(2)=histr(2)+ magA(p,q)*(50-alpha)/20;                 
                            histr(3)=histr(3)+ magA(p,q)*(alpha-30)/20;
                        elseif alpha>50 && alpha<=70
                            histr(3)=histr(3)+ magA(p,q)*(70-alpha)/20;
                            histr(4)=histr(4)+ magA(p,q)*(alpha-50)/20;
                        elseif alpha>70 && alpha<=90
                            histr(4)=histr(4)+ magA(p,q)*(90-alpha)/20;
                            histr(5)=histr(5)+ magA(p,q)*(alpha-70)/20;
                        elseif alpha>90 && alpha<=110
                            histr(5)=histr(5)+ magA(p,q)*(110-alpha)/20;
                            histr(6)=histr(6)+ magA(p,q)*(alpha-90)/20;
                        elseif alpha>110 && alpha<=130
                            histr(6)=histr(6)+ magA(p,q)*(130-alpha)/20;
                            histr(7)=histr(7)+ magA(p,q)*(alpha-110)/20;
                        elseif alpha>130 && alpha<=150
                            histr(7)=histr(7)+ magA(p,q)*(150-alpha)/20;
                            histr(8)=histr(8)+ magA(p,q)*(alpha-130)/20;
                        elseif alpha>150 && alpha<=170
                            histr(8)=histr(8)+ magA(p,q)*(170-alpha)/20;
                            histr(9)=histr(9)+ magA(p,q)*(alpha-150)/20;
                        elseif alpha>170 && alpha<=190
                            histr(9)=histr(9)+ magA(p,q)*(190-alpha)/20;
                            histr(10)=histr(10)+ magA(p,q)*(alpha-170)/20;
                        elseif alpha>190 && alpha<=210
                            histr(10)=histr(10)+ magA(p,q)*(210-alpha)/20;
                            histr(11)=histr(11)+ magA(p,q)*(alpha-190)/20;
                        elseif alpha>210 && alpha<=230
                            histr(11)=histr(11)+ magA(p,q)*(230-alpha)/20;
                            histr(12)=histr(12)+ magA(p,q)*(alpha-210)/20;
                        elseif alpha>230 && alpha<=250
                            histr(12)=histr(12)+ magA(p,q)*(250-alpha)/20;
                            histr(13)=histr(13)+ magA(p,q)*(alpha-230)/20;
                        elseif alpha>250 && alpha<=270
                            histr(13)=histr(13)+ magA(p,q)*(270-alpha)/20;
                            histr(14)=histr(14)+ magA(p,q)*(alpha-250)/20;
                        elseif alpha>270 && alpha<=290
                            histr(14)=histr(14)+ magA(p,q)*(290-alpha)/20;
                            histr(15)=histr(15)+ magA(p,q)*(alpha-270)/20;
                        elseif alpha>290 && alpha<=310
                            histr(15)=histr(15)+ magA(p,q)*(310-alpha)/20;
                            histr(16)=histr(16)+ magA(p,q)*(alpha-290)/20;
                        elseif alpha>310 && alpha<=330
                            histr(16)=histr(16)+ magA(p,q)*(330-alpha)/20;
                            histr(17)=histr(17)+ magA(p,q)*(alpha-310)/20;
                        elseif alpha>330 && alpha<=350
                            histr(17)=histr(17)+ magA(p,q)*(350-alpha)/20;
                            histr(18)=histr(18)+ magA(p,q)*(alpha-330)/20;
                        elseif alpha>=0 && alpha<=10
                            histr(1)=histr(1)+ magA(p,q)*(alpha+10)/20;
                            histr(18)=histr(18)+ magA(p,q)*(10-alpha)/20;
                        elseif alpha>350 && alpha<=360
                            histr(18)=histr(18)+ magA(p,q)*(370-alpha)/20;
                            histr(1)=histr(1)+ magA(p,q)*(alpha-350)/20;
                        
                        end
                        
                
                    end
                end
                block_feature=[block_feature histr]; % Concatenation of Four histograms to form one block feature
                                
            %end
        %end
        % Normalize the values in the block using L1-Norm
        block_feature=block_feature/sqrt(norm(block_feature)^2+.01);
               
        feature=[feature block_feature]; %Features concatenation
    end
end

feature(isnan(feature))=0; %Removing Infinitiy values

% Normalization of the feature vector using L2-Norm
feature=feature/sqrt(norm(feature)^2+.001);
for z=1:length(feature)
    if feature(z)>0.2
         feature(z)=0.2;
    end
end
feature=feature/sqrt(norm(feature)^2+.001);        



end

