% In the primary illustrations in the paper we did the analysis of ERP-vs-Spk relation based on raw
%       activity on canceled trials. For both ERP and spiking activity we did not
%       look at the difference function. However, we also have done an
%       alternative version in which we corrected the activity on each trial by
%       subtracting off the mean activity on latency-matched no-stop trials (at
%       that SSD). The results for this 2nd approach are show in Supplementary
%       Figure 8b (for N2) and 8d (for P3).
% Output Figures from this code are:
% Figure(1) and (2) --> correspond to analysis using activity on canceled
%                       trials only
% Figure(101) and (102) --> correspond to analysis using activity
%                       difference
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[codeFolder, dataFolder] = FolderInfo(); % file directory information is located here.
load([dataFolder...
     '\SpkErpRelation_Data.mat'])

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%% For N2 vs. Spiking %%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(1)
%%%%%%%%%% % For N2 vs. Conflict Neurons - Figure 5: 
ERP_SPK_relation = 'N2_ConflictNeuron';
activityType = 'canceledTrials'; % DIFFfunction or canceledTrials
tbl = SpkErpRelation_Data.(activityType).(ERP_SPK_relation);
plotColor = [0.7 0.5 0.1];
indepVar = 'ERP'; depVarSet = {'spkUPPER', 'spkLOWER'};

subplot(2,5,1)
var_x = 'spkUPPER';
getPartialRegressionPlot( tbl, indepVar, depVarSet, var_x, plotColor ) % this function outputs the partial regression plot
title({['Figure 5f'], ERP_SPK_relation}, 'interpreter', 'none') 
set(gca,'YDir','reverse') % Increasing N2 (negativity) upwards

subplot(2,5,6)
var_x = 'spkLOWER';
getPartialRegressionPlot( tbl, indepVar, depVarSet, var_x, plotColor ) % this function outputs the partial regression plot
set(gca,'YDir','reverse')  % Increasing N2 (negativity) upwards

%%%%%%%%%%%% % For N2 vs. Event-Timing Neurons - Figure 5: 
ERP_SPK_relation = 'N2_EventTimingNeuron';
activityType = 'canceledTrials'; % DIFFfunction or canceledTrials
tbl = SpkErpRelation_Data.(activityType).(ERP_SPK_relation);
plotColor = [0 0 0.4];
indepVar = 'ERP'; depVarSet = {'spkUPPER', 'spkLOWER'};

subplot(2,5,2)
var_x = 'spkUPPER';
getPartialRegressionPlot( tbl, indepVar, depVarSet, var_x, plotColor )
title({['Figure 5f'], ERP_SPK_relation}, 'interpreter', 'none')
set(gca,'YDir','reverse') % Increasing N2 (negativity) upwards

subplot(2,5,7)
var_x = 'spkLOWER';
getPartialRegressionPlot( tbl, indepVar, depVarSet, var_x, plotColor )
set(gca,'YDir','reverse') % Increasing N2 (negativity) upwards

%%%%%%%%%% % For N2 vs. Goal Maintenance Neurons : 
ERP_SPK_relation = 'N2_GoalMaintenanceNeuron';
activityType = 'canceledTrials'; % DIFFfunction or canceledTrials
tbl = SpkErpRelation_Data.(activityType).(ERP_SPK_relation);
plotColor = [0.4 0 0];
indepVar = 'ERP'; depVarSet = {'spkUPPER', 'spkLOWER'};

subplot(2,5,4)
var_x = 'spkUPPER';
getPartialRegressionPlot( tbl, indepVar, depVarSet, var_x, plotColor )
title({['Supplementary Figure 8'], ERP_SPK_relation}, 'interpreter', 'none')
set(gca,'YDir','reverse') % Increasing N2 (negativity) upwards

subplot(2,5,9)
var_x = 'spkLOWER';
getPartialRegressionPlot( tbl, indepVar, depVarSet, var_x, plotColor )
set(gca,'YDir','reverse') % Increasing N2 (negativity) upwards

%%%%%%%%%% % For N2 vs. unmodulated Neurons : 
ERP_SPK_relation = 'N2_OtherNeuron';
activityType = 'canceledTrials'; % DIFFfunction or canceledTrials
tbl = SpkErpRelation_Data.(activityType).(ERP_SPK_relation);
plotColor = [0.4 0.4 0.4];
indepVar = 'ERP'; depVarSet = {'spkUPPER', 'spkLOWER'};

subplot(2,5,5)
var_x = 'spkUPPER';
getPartialRegressionPlot( tbl, indepVar, depVarSet, var_x, plotColor )
title({['Supplementary Figure 8'], ERP_SPK_relation}, 'interpreter', 'none')
set(gca,'YDir','reverse') % Increasing N2 (negativity) upwards

subplot(2,5,10)
var_x = 'spkLOWER';
getPartialRegressionPlot( tbl, indepVar, depVarSet, var_x, plotColor )
set(gca,'YDir','reverse') % Increasing N2 (negativity) upwards


sgtitle( 'N2 vs Spikes - main figure and Supplementary' )

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%% For P3 vs. Spiking %%%%%%%%%%%%%%%%%%%%%%%%%%%

figure(2)
%%%%%%%%%% % For P3 vs. Goal Maintenance Neurons - Figure 5: 
ERP_SPK_relation = 'P3_GoalMaintenanceNeuron';
activityType = 'canceledTrials'; % DIFFfunction or canceledTrials
tbl = SpkErpRelation_Data.(activityType).(ERP_SPK_relation);
plotColor = [0.4 0 0];
indepVar = 'ERP'; depVarSet = {'spkUPPER', 'spkLOWER'};

subplot(2,5,1)
var_x = 'spkUPPER';
getPartialRegressionPlot( tbl, indepVar, depVarSet, var_x, plotColor )
title({['Figure 5g'], ERP_SPK_relation}, 'interpreter', 'none')

subplot(2,5,6)
var_x = 'spkLOWER';
getPartialRegressionPlot( tbl, indepVar, depVarSet, var_x, plotColor )

%%%%%%%%%% % For P3 vs. Conflict Neurons - Figure 5: 
ERP_SPK_relation = 'P3_ConflictNeuron';
activityType = 'canceledTrials'; % DIFFfunction or canceledTrials
tbl = SpkErpRelation_Data.(activityType).(ERP_SPK_relation);
plotColor = [0.7 0.5 0.1];
indepVar = 'ERP'; depVarSet = {'spkUPPER', 'spkLOWER'};

subplot(2,5,3)
var_x = 'spkUPPER';
getPartialRegressionPlot( tbl, indepVar, depVarSet, var_x, plotColor ) % this function outputs the partial regression plot
title({['Supplementary Figure 8'], ERP_SPK_relation}, 'interpreter', 'none') 

subplot(2,5,8)
var_x = 'spkLOWER';
getPartialRegressionPlot( tbl, indepVar, depVarSet, var_x, plotColor ) % this function outputs the partial regression plot

%%%%%%%%%%%% % For P3 vs. Event-Timing Neurons - Figure 5: 
ERP_SPK_relation = 'P3_EventTimingNeuron';
activityType = 'canceledTrials'; % DIFFfunction or canceledTrials
tbl = SpkErpRelation_Data.(activityType).(ERP_SPK_relation);
plotColor = [0 0 0.4];
indepVar = 'ERP'; depVarSet = {'spkUPPER', 'spkLOWER'};

subplot(2,5,4)
var_x = 'spkUPPER';
getPartialRegressionPlot( tbl, indepVar, depVarSet, var_x, plotColor )
title({['Supplementary Figure 8'], ERP_SPK_relation}, 'interpreter', 'none')

subplot(2,5,9)
var_x = 'spkLOWER';
getPartialRegressionPlot( tbl, indepVar, depVarSet, var_x, plotColor )

%%%%%%%%%%%% % For P3 vs. Unmodulated Neurons : 
ERP_SPK_relation = 'P3_OtherNeuron';
activityType = 'canceledTrials'; % DIFFfunction or canceledTrials
tbl = SpkErpRelation_Data.(activityType).(ERP_SPK_relation);
plotColor = [0.4 0.4 0.4];
indepVar = 'ERP'; depVarSet = {'spkUPPER', 'spkLOWER'};

subplot(2,5,5)
var_x = 'spkUPPER';
getPartialRegressionPlot( tbl, indepVar, depVarSet, var_x, plotColor )
title({['Supplementary Figure 8'], ERP_SPK_relation}, 'interpreter', 'none')

subplot(2,5,10)
var_x = 'spkLOWER';
getPartialRegressionPlot( tbl, indepVar, depVarSet, var_x, plotColor )

sgtitle( 'P3 vs Spikes - main figure and Supplementary' )

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%% Other Supplementary 8 Figure panels %%%%%%%%%%%%%%%%

figure(101)
%%%%%%%%%% % 
ERP_SPK_relation = 'N2_ConflictNeuron';
activityType = 'DIFFfunction'; % DIFFfunction or canceledTrials
tbl = SpkErpRelation_Data.(activityType).(ERP_SPK_relation);
plotColor = [0.7 0.5 0.1];
indepVar = 'ERP'; depVarSet = {'spkUPPER', 'spkLOWER'};

subplot(2,5,1)
var_x = 'spkUPPER';
getPartialRegressionPlot( tbl, indepVar, depVarSet, var_x, plotColor ) % this function outputs the partial regression plot
title({['Supplementary Figure 8'], ERP_SPK_relation}, 'interpreter', 'none') 
set(gca,'YDir','reverse') % Increasing N2 (negativity) upwards

subplot(2,5,6)
var_x = 'spkLOWER';
getPartialRegressionPlot( tbl, indepVar, depVarSet, var_x, plotColor ) % this function outputs the partial regression plot
set(gca,'YDir','reverse')  % Increasing N2 (negativity) upwards

%%%%%%%%%%%% % For N2 vs. Event-Timing Neurons - Figure 5: 
ERP_SPK_relation = 'N2_EventTimingNeuron';
activityType = 'DIFFfunction'; % DIFFfunction or canceledTrials
tbl = SpkErpRelation_Data.(activityType).(ERP_SPK_relation);
plotColor = [0 0 0.4];
indepVar = 'ERP'; depVarSet = {'spkUPPER', 'spkLOWER'};

subplot(2,5,2)
var_x = 'spkUPPER';
getPartialRegressionPlot( tbl, indepVar, depVarSet, var_x, plotColor )
title({['Supplementary Figure 8'], ERP_SPK_relation}, 'interpreter', 'none')
set(gca,'YDir','reverse') % Increasing N2 (negativity) upwards

subplot(2,5,7)
var_x = 'spkLOWER';
getPartialRegressionPlot( tbl, indepVar, depVarSet, var_x, plotColor )
set(gca,'YDir','reverse') % Increasing N2 (negativity) upwards

%%%%%%%%%% % For N2 vs. Goal Maintenance Neurons : 
ERP_SPK_relation = 'N2_GoalMaintenanceNeuron';
activityType = 'DIFFfunction'; % DIFFfunction or canceledTrials
tbl = SpkErpRelation_Data.(activityType).(ERP_SPK_relation);
plotColor = [0.4 0 0];
indepVar = 'ERP'; depVarSet = {'spkUPPER', 'spkLOWER'};

subplot(2,5,4)
var_x = 'spkUPPER';
getPartialRegressionPlot( tbl, indepVar, depVarSet, var_x, plotColor )
title({['Supplementary Figure 8'], ERP_SPK_relation}, 'interpreter', 'none')
set(gca,'YDir','reverse') % Increasing N2 (negativity) upwards

subplot(2,5,9)
var_x = 'spkLOWER';
getPartialRegressionPlot( tbl, indepVar, depVarSet, var_x, plotColor )
set(gca,'YDir','reverse') % Increasing N2 (negativity) upwards

%%%%%%%%%% % For N2 vs. unmodulated Neurons : 
ERP_SPK_relation = 'N2_OtherNeuron';
activityType = 'DIFFfunction'; % DIFFfunction or canceledTrials
tbl = SpkErpRelation_Data.(activityType).(ERP_SPK_relation);
plotColor = [0.4 0.4 0.4];
indepVar = 'ERP'; depVarSet = {'spkUPPER', 'spkLOWER'};

subplot(2,5,5)
var_x = 'spkUPPER';
getPartialRegressionPlot( tbl, indepVar, depVarSet, var_x, plotColor )
title({['Supplementary Figure 8'], ERP_SPK_relation}, 'interpreter', 'none')
set(gca,'YDir','reverse') % Increasing N2 (negativity) upwards

subplot(2,5,10)
var_x = 'spkLOWER';
getPartialRegressionPlot( tbl, indepVar, depVarSet, var_x, plotColor )
set(gca,'YDir','reverse') % Increasing N2 (negativity) upwards

sgtitle( {['N2 - Supplementary Figures'], ['(N2 sampled based on difference from'],  ['mean no-stop latency-matched trials'] })

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%% For P3 vs. Spiking %%%%%%%%%%%%%%%%%%%%%%%%%%%

figure(102)
%%%%%%%%%% % For P3 vs. Goal Maintenance Neurons - Figure 5: 
ERP_SPK_relation = 'P3_GoalMaintenanceNeuron';
activityType = 'DIFFfunction'; % DIFFfunction or canceledTrials
tbl = SpkErpRelation_Data.(activityType).(ERP_SPK_relation);
plotColor = [0.4 0 0];
indepVar = 'ERP'; depVarSet = {'spkUPPER', 'spkLOWER'};

subplot(2,5,1)
var_x = 'spkUPPER';
getPartialRegressionPlot( tbl, indepVar, depVarSet, var_x, plotColor )
title({['Supplementary Figure 8'], ERP_SPK_relation}, 'interpreter', 'none')

subplot(2,5,6)
var_x = 'spkLOWER';
getPartialRegressionPlot( tbl, indepVar, depVarSet, var_x, plotColor )

%%%%%%%%%% % For P3 vs. Conflict Neurons - Figure 5: 
ERP_SPK_relation = 'P3_ConflictNeuron';
activityType = 'DIFFfunction'; % DIFFfunction or canceledTrials
tbl = SpkErpRelation_Data.(activityType).(ERP_SPK_relation);
plotColor = [0.7 0.5 0.1];
indepVar = 'ERP'; depVarSet = {'spkUPPER', 'spkLOWER'};

subplot(2,5,3)
var_x = 'spkUPPER';
getPartialRegressionPlot( tbl, indepVar, depVarSet, var_x, plotColor ) % this function outputs the partial regression plot
title({['Supplementary Figure 8'], ERP_SPK_relation}, 'interpreter', 'none') 

subplot(2,5,8)
var_x = 'spkLOWER';
getPartialRegressionPlot( tbl, indepVar, depVarSet, var_x, plotColor ) % this function outputs the partial regression plot

%%%%%%%%%%%% % For P3 vs. Event-Timing Neurons - Figure 5: 
ERP_SPK_relation = 'P3_EventTimingNeuron';
activityType = 'DIFFfunction'; % DIFFfunction or canceledTrials
tbl = SpkErpRelation_Data.(activityType).(ERP_SPK_relation);
plotColor = [0 0 0.4];
indepVar = 'ERP'; depVarSet = {'spkUPPER', 'spkLOWER'};

subplot(2,5,4)
var_x = 'spkUPPER';
getPartialRegressionPlot( tbl, indepVar, depVarSet, var_x, plotColor )
title({['Supplementary Figure 8'], ERP_SPK_relation}, 'interpreter', 'none')

subplot(2,5,9)
var_x = 'spkLOWER';
getPartialRegressionPlot( tbl, indepVar, depVarSet, var_x, plotColor )

%%%%%%%%%%%% % For P3 vs. Unmodulated Neurons : 
ERP_SPK_relation = 'P3_OtherNeuron';
activityType = 'DIFFfunction'; % DIFFfunction or canceledTrials
tbl = SpkErpRelation_Data.(activityType).(ERP_SPK_relation);
plotColor = [0.4 0.4 0.4];
indepVar = 'ERP'; depVarSet = {'spkUPPER', 'spkLOWER'};

subplot(2,5,5)
var_x = 'spkUPPER';
getPartialRegressionPlot( tbl, indepVar, depVarSet, var_x, plotColor )
title({['Supplementary Figure 8'], ERP_SPK_relation}, 'interpreter', 'none')

subplot(2,5,10)
var_x = 'spkLOWER';
getPartialRegressionPlot( tbl, indepVar, depVarSet, var_x, plotColor )


sgtitle( {['P3 - Supplementary Figures'], ['(P3 sampled based on difference from'],  ['mean no-stop latency-matched trials'] })