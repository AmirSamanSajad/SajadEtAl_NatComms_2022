[codeFolder, dataFolder] = FolderInfo(); % file directory information is located here.
load([dataFolder '\FinalModelResults_NatureComms_DataSource.mat'])
analysisSet = {...  % this contains the model results presented in the paper:
    'Conflict', 'DIFF', 'postSSRT', 'Fig 2c-d';...        % post-SSRT activity based on difference function
    'GoalMaintenance', 'DIFF', 'postSSRT', 'Fig 4c-d';... % post-SSRT activity based on difference function
    'EventTiming', 'C', 'preSSRT', 'Fig 3c-d';...         % pre-SSRT activity based on activity on canceled trials (not diff function)
    'EventTiming_preTone', 'C', 'preTONE', 'Fig 3e-f';...         % pre-SSRT activity based on activity on canceled trials (not diff function)
    'N2', 'DIFF', 'postSSRT', 'Fig 5c';...                      % post-SSRT activity based on difference function
    'P3', 'DIFF', 'postSSRT', 'Fig 5d';...                      % post-SSRT activity based on difference function
    };
for analysisIdx = 1:size(analysisSet,1) % for each analysis (rows in analysisSet)
    resultMatrix = modelSummary.(analysisSet{analysisIdx,1}).(analysisSet{analysisIdx,2}).(analysisSet{analysisIdx,3});
    ii_1 = 0;  % counter for significant models.
    ii_2 = 0;  % counter for significant models.
    ii_3 = 0;  % counter for significant models.
    sigDataPoint = [];
    candidateModelDataPoint = [];
    sig_but_noCand_DataPoint = [];
    bestModelDataPoint = [];
    for m = 1:size( resultMatrix , 1)
        % removing '_' from model names:
        modelName{ 1,m } = resultMatrix.model{ m };
        modelName{ 1,m }(  modelName{ m } == '_'  ) = ' ';
        % For every significant point, we want to draw a plot in the imageSC element corresponding to that model.
        if resultMatrix.pVal_mainEffect(m) < 0.05
            ii_1 = ii_1 + 1;  % is significant, counter goes up. This counter becomes the row of...
            sigDataPoint(ii_1,:) = [1, m];  %... this array, which will be plotted.
        end 
        if resultMatrix.pVal_mainEffect(m) < 0.05  & resultMatrix.deltaBIC(m) > 2
            ii_2 = ii_2 + 1;  % is significant, counter goes up. This counter becomes the row of...
            sig_but_noCand_DataPoint(ii_2,:) = [1, m];  %... this array, which will be plotted.
        end 
        if resultMatrix.pVal_mainEffect(m) < 0.05   &   resultMatrix.deltaBIC(m) == 0  % we also want to know the coordinates of the best model.
            bestModelDataPoint(1,:) = [1, m];  %... this array, which will be plotted.
        end 
        if resultMatrix.pVal_mainEffect(m) < 0.05   &   resultMatrix.deltaBIC(m) < 2  &   resultMatrix.deltaBIC(m) > 0  % we also want to know the coordinates of the best model.
            ii_3 = ii_3 + 1;  % is significant, counter goes up. This counter becomes the row of...
            candidateModelDataPoint(ii_3,:) = [1, m];  %... this array, which will be plotted.
        end 
    end
    % for plotting purposes, I will convert deltaBIC > 10 to 10.
    resultMatrix.deltaBIC( resultMatrix.deltaBIC > 10 ) = 10;
    h_plots(analysisIdx) = figure(analysisIdx);
    subplot(1,4,[1 2])
    imagesc( resultMatrix.deltaBIC ); hold on;
    colormap('hot'); caxis([0 11]) % indicating colormap info.
    colorbar
    yticks( 1:size( resultMatrix , 1) )
    yticklabels( modelName )
    xticklabels( [] );
    
%     if isempty( sigDataPoint ) == 0
%     plot( sigDataPoint(:,1), sigDataPoint(:,2) , 'bo', 'markersize', 4 )
%     end
    plot( bestModelDataPoint(1), bestModelDataPoint(2) , 'gh', 'markersize', 12 , 'markerfacecolor', [0 1 0] )
    if isempty( sig_but_noCand_DataPoint ) == 0
       plot( sig_but_noCand_DataPoint(:,1), sig_but_noCand_DataPoint(:,2) , 'bo', 'markersize', 3, 'markerfacecolor', [0 0 1] )
    end 
    if isempty( candidateModelDataPoint ) == 0
    plot( candidateModelDataPoint(:,1), candidateModelDataPoint(:,2) , 'wh', 'markersize', 8, 'markerfacecolor', [1 1 1] )
    end
    xlabel( 'delta BIC (colormap)' );
    title( [analysisSet{analysisIdx, 4} ' - ' analysisSet{analysisIdx, 1} ] )
    clearvars -except modelSummary analysisSet analysisIdx h_plots
end
clear analysisIdx
