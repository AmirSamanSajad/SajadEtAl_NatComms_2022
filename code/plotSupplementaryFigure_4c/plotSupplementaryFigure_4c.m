% This code takes in saved data that contains the R values (raw and fisher-transformed) for activity vs.
% pNC correlation and plots them. It also conducts statistics to test
% whether it deviates from 0.
[~, dataFolder] = FolderInfo();
load([dataFolder '\data_SupplementaryFigure_4c.mat'])
figure;
hist(R_fisherTransformed, binNumber);
vline(0, 'r-')
[h,p]= signrank( R_raw );
title(['non-parametric signrank:  p = ' num2str(h) ])