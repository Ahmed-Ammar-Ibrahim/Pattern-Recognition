t = imread('cameraman.tif');
subplot(1,2,1)
imshow(t);
title('Base image');
subplot(1,2,2);
distorted = imresize(t,0.7); 
distorted = imrotate(distorted,31);
imshow(distorted);
title('Transformed image');
%% restoration
ptsOriginal  = detectSURFFeatures(t); %detect interest  
ptsDistorted = detectSURFFeatures(distorted);
[featuresOriginal,validPtsOriginal] = ...
    extractFeatures(t,ptsOriginal); %extrat points
[featuresDistorted,validPtsDistorted] = ...
    extractFeatures(distorted,ptsDistorted);
index_pairs = matchFeatures(featuresOriginal,featuresDistorted);
matchedPtsOriginal  = validPtsOriginal(index_pairs(:,1));
matchedPtsDistorted = validPtsDistorted(index_pairs(:,2));
figure; 
showMatchedFeatures(t,distorted,...
    matchedPtsOriginal,matchedPtsDistorted);
title('Matched SURF points,including outliers');
[tform,inlierPtsDistorted,inlierPtsOriginal] = ...
    estimateGeometricTransform(matchedPtsDistorted,matchedPtsOriginal,...
    'similarity');
figure; 
showMatchedFeatures(t,distorted,...
    inlierPtsOriginal,inlierPtsDistorted);
title('Matched inlier points');
outputView = imref2d(size(t));
Ir = imwarp(distorted,tform,'OutputView',outputView);
figure; imshow(Ir); 
title('Recovered image');
