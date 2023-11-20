% This code loads the Spike-Density function (SDF) for all neurons
% modulated around the time of SSRT, organizes the data in the format
% needed for the clustering algorithm, and then runs the clusterimg
% algorithm (consensusCluster.m).

%%%%% List of functions used here:
% consensusCluster.m
% dendrogram.m
% klDendroClustChange.m

% NOTE: The clustering algorithm is developed by Kaleb Lowe, with the full
% set of codes and logic behind the algorithm published in Lowe and Schall,
% 2018 (eNeuro).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[codeFolder, dataFolder] = FolderInfo(); % file directory information is located here.

load([dataFolder '\clusteringInputData.mat'], 'clusteringData' )
% ORGANIZING THE DATA IN THE FORMAT NEEDED FOR THE CLUSTERING ALGORITHM:
SDFdata = {...   % organizing SDF data in the format the algorithm takes in.
         clusteringData.SDFinputData.canceled_SSD1, ...
         clusteringData.SDFinputData.noStop_SSD1_latencyMatched, ...
         };

SDFtimeWindow = {...  % organzing timing information in the format needed for the algorithm
                 clusteringData.SDFtimeRange,...
                 clusteringData.SDFtimeRange,...
                 };            
myEpocs = {...    % organzing other data in the format needed for the algorithm
           clusteringData.Windows4Clustering{1}, clusteringData.Windows4Clustering{2},  ...
           clusteringData.Windows4Clustering{1}, clusteringData.Windows4Clustering{2},  ...
           };
       
myEpocInds = [...      % this indicates which element in SDFinputData is used. 
              1,1,...  % 1 corresponds to SDF_trials_C.SSD1
              2,2,...
              ];

% Running the primary part of the clustering algorithm:         
[sortIDs,idxDist, raw, respSumStruct, rawLink] = consensusCluster( SDFdata, SDFtimeWindow, '-e', myEpocs, '-ei', myEpocInds);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Extracting and plotting relevant data from the output of consensusCluster algorithm.

myK = 5; % Based on inspection of different cluster outputs, 5 clusters captured the population the best.
nPerClust = hist(sortIDs(:,myK),1:myK);
% plotting the mean SDF of each cluster:
figure
for i = 1:myK   % for each cluster ID do:
    subplot( ceil(sqrt(myK)) , ceil(sqrt(myK)) , i )  % a square panel arrangement.
    sortedNeurons_idx{i} = find( sortIDs(:,myK) == i );  % find the neurons in that cluster
    clusterSDF_canceled{i} = SDFdata{1}( sortedNeurons_idx{i}, : ); % extract the neurons' SDFs.
    clusterSDF_noStop{i} = SDFdata{2}( sortedNeurons_idx{i}, : ); % extract the neurons' SDFs.
    plot( clusteringData.SDFtimeRange, mean( clusterSDF_canceled{i}, 1 ), 'k-', 'lineWidth', 3 ); hold on;
    plot( clusteringData.SDFtimeRange, mean( clusterSDF_noStop{i}, 1 ), 'k-', 'lineWidth', 0.5 );
    title(['Fig 1c - cluster ' int2str(i) ' - n = ' int2str( numel(sortedNeurons_idx{i}) ) ]);
    xlabel('mean firing rate(spk/sec)')
    if i == ceil(myK/2)   % for the middle panel column place the x-axis. it's shared across all panels.
    xlabel('time from SSRT (ms)')
    end
end

% plot the dendrogram and similarity matrix:
figure
subplot(2,2,2)
[h, t, outperm] = dendrogram(rawLink, 0);
klDendroClustChange(h, rawLink, sortIDs(:,myK) );
title(['Fig 1c - cluster dendrogram'])
xticklabels([])
dist_mat_ordered_raw = raw(outperm, outperm);  % This calculates distances. We need to equate (i,j) and (j,i).
for i = 1:size(dist_mat_ordered_raw,1)
    for j = 1:size(dist_mat_ordered_raw,2)
        if j > i
            dist_mat_ordered(i,j) = dist_mat_ordered_raw(j,i);
        else
            dist_mat_ordered(i,j) = dist_mat_ordered_raw(i,j);
        end
    end
end
C_mat = 0 ; % max(max(dist_mat_ordered)) - (range(range(dist_mat_ordered)) /2);
subplot(2,2,1)
imagesc( C_mat + dist_mat_ordered); colormap('jet') ; caxis([ -1 2])
title(['Fig 1c - cluster similarity matrix'])