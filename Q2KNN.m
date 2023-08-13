close all;
clear all;
clc;


%% Training Cat Data
folderCat = './DogCat/Training/Cat/';
filesCat = dir(fullfile(folderCat,'*.jpg'));
CatFeat = zeros(length(filesCat), 1);
for i = 1:length(filesCat) 
    disp(i);
    filename = filesCat(i,1).name;
    img=imread([folderCat filename]);
    img_gray=rgb2gray(img);
    im=imresize(img_gray,[48 48]);
    J = integralImage(im);
    Sum_w=J(41,41)-J(41,4)-J(4,41)+J(4,4);
    Sum_b=J(49,49)-Sum_w;
    haar=Sum_w-Sum_b;    
    CatFeat(i,:) = haar;
    
end


%% Training Dog Data
folderDog = './DogCat/Training/Cat/';
filesDog = dir(fullfile(folderDog,'*.jpg'));
DogFeat = zeros(length(filesCat), 1);

for i = 1:length(filesDog) 
    disp(i);
    filename = filesDog(i,1).name;
    img=imread([folderDog filename]);
    img_gray=rgb2gray(img);
    im=imresize(img_gray,[48 48]);
    J = integralImage(im);
    Sum_w=J(41,41)-J(41,4)-J(4,41)+J(4,4);
    Sum_b=J(49,49)-Sum_w;
    haar=Sum_w-Sum_b;    
    DogFeat(i,:) = haar;
    
end

k=[1,1,1,1];
for j=1:length(k)
    
    k=input("enter the value of k ");

    folderCatTest='./DogCat/Testing/Cat/';
    filesCatTest=dir(fullfile(folderCatTest,'*jpg'));
    for i = 1:length(filesCatTest)
        
        disp(i);
        filename = filesCatTest(i,1).name;
        disp(filename);
        img = imread([folderCatTest filename]);
        query = imresize(img,[48 48]);
        J = integralImage(query);
        Sum_w=J(41,41)-J(41,4)-J(4,41)+J(4,4);
        Sum_b=J(49,49)-Sum_w;
        feat=Sum_w-Sum_b;

   
        dists=distChiSq(feat,CatFeat);
        
        [dis,id]=sort(dists);
        diss=dis(1:k);
        index=find(dists==mode(diss));
        
        img_result = imread([folderCat filesCat(index,1).name]);
        img_result = imresize(img_result,[320,480]);
        figure(i);
        figure; subplot(1,2,1);
        imshow(img); title('Query'); 
        subplot(1,2,2);
        imshow(img_result); title('Result'); 
    end


end


k=[1,1,1,1];
for j=1:length(k)
    
    k=input("enter the value of k ");

    folderDogTest='./DogCat/Testing/Dog/';
    filesDogTest=dir(fullfile(folderCatTest,'*jpg'));
    for i = 1:length(filesDogTest)
        
        disp(i);
        filename = filesDogTest(i,1).name;
        disp(filename);
        img = imread([folderDogTest filename]);
        query = imresize(img,[48 48]);
        J = integralImage(query);
        Sum_w=J(41,41)-J(41,4)-J(4,41)+J(4,4);
        Sum_b=J(49,49)-Sum_w;
        feat=Sum_w-Sum_b;

   
        dist=distChiSq(feat,DogFeat);
        
        [dis,id]=sort(dist);
        diss=dis(1:k);
        index=find(dists==mode(diss));
        
        img_result = imread([folderDog filesDog(index,1).name]);
        img_result = imresize(img_result,[320,480]);
        figure(i);
        figure; subplot(1,2,1);
        imshow(img); title('Query'); 
        subplot(1,2,2);
        imshow(img_result); title('Result'); 
    end


end





