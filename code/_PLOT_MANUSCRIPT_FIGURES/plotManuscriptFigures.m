% This code plots the following figures:

% Figure 1c
% Figure 3a, 3b, 3c, 3d
% Figure 4a, 4b, 4c, 4d, 4e, 4f
% Figure 5a, 5b, 5c, 5d
% Figure 6a, 6b, 6c, 6d, 6e, 6f, 6g, 6h
% Supplementary Figure 1a, 1c
% Supplementary Figure 2b
% Supplementary Figure 3b
% Supplementary Figure 4a, 4b, 4c
% Supplementary Figure 5a, 5b, 5c
% Supplementary Figure 6a, 6b, 6c, 6d, 6e, 6f
% Supplementary Figure 7a, 7b, 7c
% Supplementary Figure 8
% Supplementary Figure 9

%% Figure subpanels:

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% NEURON CLASSIFICAITON:

    % MAIN FIGURES:
        % 1c:
    getClusters(); getKMeans(); % see the function for details.
    
    % SUPPLEMENTARY FIGURES:
        % S-1c:
    plotSupplementarySDFheatmaps();

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Population Spike-density Function:

    % MAIN FIGURES:
        % 3a top panel: 
        % 4a top panel:
        % 5a top panel:
    plotSDFdata();
    
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SSRT-aligned time-depth plots:

    % MAIN FIGURES:
     % 3a bottom-left panel & 3b left panel: 
     % 4a bottom-left panel & 4b left panel: 
     % 5a bottom-left panel & 5b left panel: 
     % 6b
    % SUPPLEMENTARY FIGURES:
     % S-4a
     % S-5a
     % S-6a
    plot_timeDepth_Figures_SSD_and_SSRT_aligned(); % This code will generate several other panels as well (indicated in the title of the figure)

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% TONE-aligned time-depth plots:
    
    % MAIN FIGURES:
        % 3a bottom-right panel & 3b right panel:
        % 4a bottom-right panel & 4b right panel:
        % 5a bottom-right panel & 5b right panel:
    plot_timeDepth_Figures_TONE_aligned();

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% EXAMPLE NEURONS

    % MAIN FIGURES:
        % 3c 
        % 4c, 4f 
        % 5c
    plotExampleNeuronSDFs();
    
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SUPPLEMENTARY SPIKE-DENSITY FUNCTIONS:

    % SUPPLEMENTARY FIGURES:
        % S-2b
        % S-4b
        % S-5b
        % S-6b
    plotSupplementarySDFPlots();

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% MIXED-EFFECTS MODELING RESULTS - delta BIC tables:

    % MAIN FIGURES:
        % 3d
        % 4d, 4f
        % 5d
        % 6c
    plotModelResults();

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% MIXED-EFFECTS MODELING RESULTS - Regression scatterplots:

    % MAIN FIGURES:
        % 3e
        % 4e, 4g
        % 5e
        % 6d, 6e
    plotBestFitScatter();
    
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ERP results - N2 and P3 ERP trace:

   % MAIN FIGURES:
    % 6a
    % 6b
   % SUPPLEMENTARY FIGURES: 
    % S-7a
    % S-7b
   plotERPdata();
   
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ERP results - peak ERP data:

   % SUPPLEMENTARY FIGURES: 
    % S-7c
   plotPeakERPdata();

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ERP-Spike relationship:

  % MAIN FIGURES:
    % 6f, 6g
  % SUPPLEMENTARY FIGURES:
    % S-8 (all panels)
  plotSpkErpRelation();

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% COMPARISON BETWEEN MODEL PARAMETERS:

    % SUPPLEMENTARY FIGURES:
        % S-3b:
  plotModelParametersComparison();    

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ADDITIONAL SUPPLEMENTARY FIGURES:

% depth-spikeWidth relationship:
    % S-1a
    plotSPKWvsDEPTH();

% Comparison between Goal Maintenance and Conflict neurons:
    % S-6e
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% R values for conflict neurons (activity vs. p(NC|SSD):
    % S-4c
    plotSupplementaryFigure_4c();

% Goal Maintenance neurons - activity on abort vs. non-abort trials:  
    % S-6f
    plotSupplementaryFig_6f();
    
% Activity on post-tone release of fixation for different latencies:
   % S-5d
   % S-6d
   plotMeanSDF_postTone_brkLatency_vincentized3Bins();
   

