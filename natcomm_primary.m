%{ 
-------------------------------------------------------------------------
Functional Architecture of Executive Control and Associated Event-Related 
Potentials in the Macaque Monkey
  
Amirsaman Sajad*, Steven P. Errington*, Jeffrey D. Schall

Nature Communications (2022)

Corresponding author: Jeffrey D Schall, schalljd@yorku.ca

% Summary ---------------------------------------------------------
The medial frontal cortex enables executive control by monitoring relevant 
information and using it to adapt behavior. In macaques performing a saccade 
countermanding (stop-signal) task, we recorded electrical potentials over and 
neural spiking across all layers of the supplementary eye field (SEF). 
We report the laminar organization of neurons enabling executive control by 
monitoring the conflict between incompatible responses, the timing of events, 
and sustaining goal maintenance. These neurons were a mix of narrow and 
broad-spiking found in all layers, but those predicting the duration of 
control and sustaining the task goal until the release of operant 
control were more commonly narrow-spiking neurons confined to 
layers 2 and 3 (L2/3). We complement these results with evidence for 
a monkey homologue of the N2/P3 event-related potential (ERP) complex 
associated with response inhibition. N2 polarization varied with error 
likelihood and P3 polarization varied with the duration of expected 
control. The amplitude of the N2 and P3 were predicted by the spike 
rate of different classes of neurons located in L2/3 but not L5/6. 
These findings reveal features of the cortical microcircuitry supporting 
executive control and producing associated ERP. 

Here, we provide code and data to reproduce the figures presented within this
manuscript, and allow readers to further examine aspects of dataset we may
not have considered.
%}

%% Set parameters & setup workspace
% To use this script, first add the main repository to the MATLAB workspace, 
% to allow for called functions to work. This is done by right clicking on
% the main directory ("2022-NComms-SEF"), then:
% -> Add to Path -> Selected Folders and Subfolders

% We start by defining where the repository is located
% and can then state where important directories are, for future use
[codeFolder, dataFolder, mainFolder] = FolderInfo(); % map the directory
addpath(genpath(mainFolder)); % readding the whole directory again, to be sure!

warning off; % Turn off warning pop-ups for clarity.

%% Figure 1
% Fig. 1c: Neuron clustering %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This script will run a clustering algorithm for all neurons within our
% sample and identify common patterns of modulations. These are further
% distinguished using K-means clustering
getClusters(); getKMeans(); % see the function for details.
% -----------------------------------------------------------------------%
% Supplementary Fig. 1c: Activity heatmaps %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This script will generate heatmaps of normalized activity for each
% identified cluster, aligned on stopping (SSRT) and tone.
plotSupplementarySDFheatmaps();

%% Figure 2
% Fig. 2d: Interactive Race Model 2.0 Simulations %%%%%%%%%%%%%%%%%%%%%
% This script generates simulations of race model behaviour, and presents
% estimated conflict values based on the activity of GO & STOP
% accumulators.
fig2d_primary 

%% Figure 3, 4, 5 
%  These figures share a common format and, as such, are produced together
%  within the following scripts.
% -----------------------------------------------------------------------%
%  Fig. 3a, 4a, 5a (top-panel) : Population SDF  %%%%%%%%%%%%%%%%%%%%%%%%
%  This script plots the population average SDF, aligned on SSRT
%  for each neuron class identifed through our clustering process.
plotSDFdata();
% -----------------------------------------------------------------------%
%  Fig. 3a, 4a, 5a (bottom-left panel): Time-depth plots & PDF %%%%%%%%%%
%  Fig. 3b, 4b, 5b (left-panel)
%  Supplementary Fig. 4a, 5a, 6a)

%  This script plots the activity of each neuron class through time and laminar space, 
%  aligned on SSRT for each neuron class identifed through our clustering process.
%  In addition, this code will plot the PDF for each class above the
%  time-depth plot. Finally, this script also produces supplementary figure
%  4a, 5a, and 6a, which show the alignment on SSD, SSRT (integrated
%  weighted), and SSRT (Bayesian).
plot_timeDepth_Figures_SSD_and_SSRT_aligned();
% -----------------------------------------------------------------------%
%  Fig. 3a, 4a, 5a (bottom-right panel): Time-depth plots & PDF %%%%%%%%%%
%  Fig. 3b, 4b, 5b (right-panel)

%  This script plots the activity of each neuron class through time and 
%  laminar space, aligned on tone for each neuron class identifed through
%  our clustering process. In addition, this code will plot the PDF for 
%  each class above the time-depth plot. 
plot_timeDepth_Figures_TONE_aligned();
% -----------------------------------------------------------------------%
%  Fig. 3c, 4c, 4f, 5c: Example neurons SDF %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%  This script plots the activity of an example neuron within each class.
%  See plotSupplementarySDFPlots() for further examples.
plotExampleNeuronSDFs();
% -----------------------------------------------------------------------%
%  Fig. 3d, 4d, 4f, 5d, 6c: Model Comparison - delta BIC  %%%%%%%%%%%%%%%%%

%  This script presents a heatmap of the delta BIC for each neuron class,
%  to demonstrate the functional properties that best explain the neural
%  activity.
plotModelResults();
% -----------------------------------------------------------------------%
%  Fig. 3e, 4e, 4g, 5e, 6d, 6e: Model Comparison - scatter %%%%%%%%%%%%%%%%

%  This script presents a scatterplot for each neuron class which plots the
%  values of the best fitting measure against the neural activity.
%  activity.
plotBestFitScatter();

%% Figure 6
%  Fig. 6a, 6b: N2 and P3 ERP trace %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  This script plots the average event related potential, aligned on target
%  and stop-signal for canceled and latency-matched no-stop trials.
plotERPdata();

%  Fig. 6f, 6g: Spike and ERP relation %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  Supplementary Fig. 8
%  This script plots the relationship between the magnitude of the N2/P3
%  component against the magnitude/firing rate of each class of neuron
%  described in this study, divided by upper and lower layers.
  plotSpkErpRelation();

% Note: the model comparison codes above will also produce the output
% relevant for the N2/P3 components.

%% Supplementary Figures

% Supplementary Fig. 1a: Spike width and depth relationship.
plotSPKWvsDEPTH();

% Supplementary Fig. 2b,4b,5b,6b: Example neuron SDF for each neuron class.
plotSupplementarySDFPlots();

% Supplementary Fig. 3b: Relationship between model comparison factors.
plotModelParametersComparison();

% Supplementary Fig. 4c: R-values for activity x p(NC|SSD) relationship at
% individual neurons level.
plotSupplementaryFigure_4c()

% Supplementary Fig. 5d, 6d: Average SDF aligned on the post-tone
% release of fixation.
plotMeanSDF_postTone_brkLatency_vincentized3Bins();
   
% Supplementary Fig. 6f: Average SDF for goal maintenance neurons on
% abort/non-abort trials.
plotSupplementaryFig_6f();

% Supplementary Fig. 7c: CDF of peak N2/P3 latency.
plotPeakERPdata();

% Supplementary Fig. 9b: CDF of neuronal latencies in SEF, Caudate, and VTA/SN,
% and export of data to CSV for statistical analysis in JASP.
suppfig9bc_primary
