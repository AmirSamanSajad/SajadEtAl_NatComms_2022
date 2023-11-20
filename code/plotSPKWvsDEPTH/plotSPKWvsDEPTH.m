[codeFolder, dataFolder] = FolderInfo();
load([dataFolder '\spikeWidth_depth_relation.mat']) % This file only contains the spikeWidth and depth relation for perpendicular penetrations
load([dataFolder '\samplingBias.mat'])

figure; 
subplot( 3, 3, [1 2] )
hist( spkWidth_depth_relation.spkWidth, 0:50:1500 );
xlim( [0 800])

subplot( 3, 3, [4 5 7 8] )
scatter( spkWidth_depth_relation.spkWidth ,  spkWidth_depth_relation.depth, 'o', 'markerfacecolor' ,'k', 'markeredgecolor', 'k', 'markerfacealpha', 0.2, 'markeredgealpha', 0.2 )
xlim( [0 800])
set(gca,'YDir','reverse')

subplot( 3, 3, [6 9] )
barh( 1:19, samplingBias.countPerDepth )
set(gca,'YDir','reverse')
