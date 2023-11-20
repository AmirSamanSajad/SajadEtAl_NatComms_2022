% After identifying facilitated neurons, we further classified them based
% on their Modulation Duration (modDuration), Modulation Onset (modOnset)
% and activity index (different / sum) for activity before the tone vs.
% activity after the tone.

[codeFolder, dataFolder] = FolderInfo();
load( [dataFolder '\clusteringInputData.mat'] )

% Let's plot the results:
figure(100)
subplot(3,2,1)
plot( clusteringData.kMeans.elbowMatrix(:,1), clusteringData.kMeans.elbowMatrix(:,2), 'ko-')
xlim([0.5 6.5])
xlabel('k')
ylabel('With-in Sum of distance to center')
vline( [2 3], 'r--')
title('K-means Optimal K,  Elbow method')
subplot(3,2,2)
plot( clusteringData.kMeans.silhouetteScoreMatrix(:,1), clusteringData.kMeans.silhouetteScoreMatrix(:,2) , 'ko-' )
ylim([min(clusteringData.kMeans.silhouetteScoreMatrix(:,2))-0.1 max(clusteringData.kMeans.silhouetteScoreMatrix(:,2))+0.1] )
xlim([0.5 6.5])
xlabel('k')
ylabel('Silhouette Score')
vline( find( clusteringData.kMeans.silhouetteScoreMatrix(:,2) == max(clusteringData.kMeans.silhouetteScoreMatrix(:,2)) ), 'k--')
title('K-means Optimal K,  Silhouette method')

% bestK = 2;
% Now let's plot:  Here are the parameters for plotting the two clusters:
ptsymb = {'bs','r^'};
colorSet = {'b', 'r'};
colorSetaxis = {[0 0 1], [1 0 0]};
ClassSet = {'Class1', 'Class2'};

data = [ (clusteringData.kMeans.facNeuronsData.modDuration)  (clusteringData.kMeans.facNeuronsData.modOnset)  (clusteringData.kMeans.facNeuronsData.periToneIndex) ];
% Note that this data contains the facilitated neurons from the clustering
% algorithm output. It does not reflect the finalize manually-curated data.

subplot( 3,2,[3:6] )

for i = 1:2  % for each cluster do:
    plot3(data(clusteringData.kMeans.clusterIndex == i,1),data(clusteringData.kMeans.clusterIndex == i,2),data(clusteringData.kMeans.clusterIndex == i,3),ptsymb{i});
    hold on
    xlabel('modulation duration')
    ylabel('modulation onset')
    zlabel('peri-tone index')
end
