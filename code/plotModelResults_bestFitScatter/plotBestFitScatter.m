[codeFolder, dataFolder] = FolderInfo(); % file directory information is located here.
load([dataFolder '\FinalModelResults_NatureComms_DataSource.mat'])

close all
analysisSet = {...  % this contains the model results presented in the paper:
    'Conflict', 'DIFF', 'postSSRT', 'Fig 3e';...        % post-SSRT activity based on difference function
    'GoalMaintenance', 'DIFF', 'postSSRT', 'Fig 5e';... % post-SSRT activity based on difference function
    'EventTiming', 'C', 'preSSRT', 'Fig 4e';...         % pre-SSRT activity based on activity on canceled trials (not diff function)
    'EventTiming_preTone', 'C', 'preTONE', 'Fig 4g';...         % pre-SSRT activity based on activity on canceled trials (not diff function)
    'N2', 'DIFF', 'postSSRT', 'Fig 6d';...                      % post-SSRT activity based on difference function
    'P3', 'DIFF', 'postSSRT', 'Fig 6e';...                      % post-SSRT activity based on difference function
    };
figure;
for analysisIdx = 1:size(analysisSet,1) % for each analysis (rows in analysisSet)
    %%% Extract the relevant data:
    % first, locate the best model:
    resultMatrix = modelSummary.(analysisSet{analysisIdx,1}).(analysisSet{analysisIdx,2}).(analysisSet{analysisIdx,3});
    bestModel_idx = find( resultMatrix.deltaBIC == 0 );  % identify the index for the best model.
    pVal = resultMatrix.pVal_mainEffect( bestModel_idx );
    % then extract the relevant data for plotting.
    resultTable = modelTable.(analysisSet{analysisIdx,1}).(analysisSet{analysisIdx,2}).(analysisSet{analysisIdx,3});
    modelList = fields( resultTable );
    bestModelName = modelList{ bestModel_idx }; % this is the name of the field that contains data for plotting.
    
    bestFitTable = resultTable.(bestModelName);
    
    clear  modelList resultTable bestModel_idx resultMatrix modelOutput  % we don't need these variables anymore.
    %%% Now plotting the scatter plot based on this table:
    
    % the equation used is activity ~ 1 + z_factor + (1 | neuronIdx)
    % to do partial plots between activity vs. z_factor, we need to plot the
    % residuals of each against the remaining predictors (in this case the
    % intercept)
    if strcmpi(analysisSet{analysisIdx,1}, 'N2') == 1 | strcmpi(analysisSet{analysisIdx,1}, 'P3') == 1
        formula_y = 'activity ~ 1 + (1 | sessionIdx)';
        formula_x = 'z_factor ~ 1 + (1 | sessionIdx)';
    else
        formula_y = 'activity ~ 1 + (1 | neuronIdx)';
        formula_x = 'z_factor ~ 1 + (1 | neuronIdx)';
    end
    
    mdl_y = fitlme( bestFitTable, formula_y );
    mdl_x = fitlme( bestFitTable, formula_x );
    residuals_mdl_y = residuals( mdl_y );
    residuals_mdl_x = residuals( mdl_x );
    subplot( 2,  size(analysisSet,1), analysisIdx )
    scatter( residuals_mdl_x, residuals_mdl_y, 'ks', 'MarkerFaceColor', [0 0 0], 'MarkerEdgeColor', [0 0 0], 'MarkerFaceAlpha', 0.1, 'MarkerEdgeAlpha', 0);
    ylabel( 'adjusted activity' )
    bestModelName_label = bestModelName; bestModelName_label( bestModelName_label == '_' ) = [];
    xlabel( ['adjusted z(' bestModelName  ')'] , 'interpreter', 'none')
    title( {[ analysisSet{analysisIdx,4} ], [ analysisSet{analysisIdx,1} ' - ' analysisSet{analysisIdx,3} ], [' p = ' num2str(pVal, 4)]} )
    lsline;
    
end

