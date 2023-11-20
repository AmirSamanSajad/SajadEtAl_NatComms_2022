function [timeDepth_values, depthMatrix] = getTimeDepthPlot(modTimes, timeRange, neuronInfo, samplingBias_flag, Color_RGB)
% This code generates time-depth plots:
% NOTE: the time-depth plot represents neuron distribution across depth and time in two
% ways:
%        1) It plots the (depth,modulation onset time) coordinates for each
%        neuron with a symbol - the symbol for broad-spiking is a triangle
%        and for narrow-spiking is a star.
%        2) It plots a heatmap that represents the duration of modulation
%        for each neuron at each depth with a colormap. This way one can
%        see how long the modulation lasts at each depth.
%        NOTE: There are two ways of generating this colormap:
% a) each neuron's contribution to the colormap is equal
% irrespective of depth
% b) each neuron's contribution to the colormap is corrected
% by the number of neurons sampled at that depth.
% In Sajad et al., 2019 and 2021 time-depth plots we use the
% method in (b) - correcting for the sampling distribution.
%%%%%%%%%%%%% NESTED FUNCTIONS:
% [depthArray, depthMatrix] = TDPlotter(Matrix_01, timeRef, depthInfo_knownDepth, spkWidthInfo_knownDepth, samplingBiasArray, mapColor)
% the code preceding this function arranges the data in the format
% needed for this function to operate. This is where most of the
% process related to plotting occurs.

% mapColor = mapColorGen(color1, color2)
% This code simply takes in a color1 and color2 and generates a
% continuous colormap from it. Very simple!

% xy_matrix_noOverlap = resolveOverlap(xy_matrix, percShift)
% This function takes in a bunch of x-y values in a matrix (stacked in
% rows) and adds an offset to y-values to points that fall exactly on
% eachother. So: if (x1, y1) falls on (x2, y2), with x1 = x2 = x, and
% y1 = y2 = y, then:
% (x1, y1) = (x, y - offset) and
% (x2, y2) = (x, y + offset)
% offset is defined as the percShift relative to the smallest y-unit.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% INPUTS:
% modTimes     - modulation times relative to the aligned event. (the nature of the event is irrelevant here).
%                NOTE: the row index on modTimes matches that in
%                neuronInfo. Otherwise you will get incorrect results.
%
% timeRange    - x-axis of time-depth plot (can go from before to after the
%                aligned event.
%                IMPORTANT:timeRange(1) MUST be a negative value or zero and
%                timerange(2) MUST be a positive value.
%
% neuronInfo   - this contains depthInfo and spike width info, necessary for
%                plotting time-depth plots. Note, only neurons from
%                perpendicular penetrations are used for time-depth plots.
%
% samplingBias_flag - this contains the overall sampling bias across all
%                recording sessions. The colormap in time-depth plots accounts for uneven
%                sampling frequency.
%
% Color_RGB - User can indicate the color to use.

%%%%%% OUTPUTS:
% depthArray    -
% depthMatrix   -
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[~, dataFolder] = FolderInfo() % file directory information is located here.
if nargin < 4; samplingBias_flag = 0;  % setting default as no correction for sampling bias.
end
if nargin < 5; Color_RGB = [0 0 0]; % Color_RGB can be empty. If empty, the default will be black.
end
% need to restrict our data only to neurons from perpendicular penetrations:
perpNeuronIdx = find( strcmpi(neuronInfo.penetrationType, 'perpendicular - known depth') == 1 );
modTimes_knownDepth = modTimes( perpNeuronIdx , : ); % removing non-perpendicular sessions
numberOfNeurons = size(modTimes_knownDepth,1);
timeRange = timeRange(1):timeRange(end); % in case the full array is not in the input.
timeDur = range(timeRange);
timeRef = find( timeRange == 0 );
Matrix_01 = zeros( numberOfNeurons, timeDur ); % Matrix_01 is a matrix that contains 1's for significant period.
for neuron = 1:numberOfNeurons  % for each neuron do (neuron indicates row index in Matrix_01.
    if ~isnan( modTimes_knownDepth(neuron,1) ) & ~isnan( modTimes_knownDepth(neuron,2) )
    mod_index = [ modTimes_knownDepth(neuron,1):modTimes_knownDepth(neuron,2) ] + timeRef;  % this is now the index in the Matrix_01 column where we need to switch 0's to 1's.
    mod_index( mod_index < 0 ) = []; mod_index( mod_index > (timeDur-1) ) = [];  % we cut out those 1's that fall outside of timeRange.
    Matrix_01( neuron, mod_index ) = 1;
    end
end
% now let's extract other relevant information
depthInfo_knownDepth = neuronInfo.depth_idx( perpNeuronIdx ); % depth_idx goes in channel units (150 microns in Sajad et al., 2019, 2021)
spkWidthInfo_knownDepth = neuronInfo.spikeWidth_ms( perpNeuronIdx ); % convert the sampling
% now let's set up the samplingBiasArray:
if samplingBias_flag == 0
    samplingBiasArray = ones(1:19,1); % Note: 19 is our maximum depth.
elseif samplingBias_flag == 1
    load([dataFolder '\samplingBias.mat'])
    samplingBiasArray = samplingBias.countPerDepth;
end
% Now let's generate the color map needed for plotting:
mapColor = mapColorGen( [1 1 1] , Color_RGB); % different intensity of color indicated by user.
% Now we have all the inputs needed to run timeDepthPlotter.
[timeDepth_values, depthMatrix] = TDPlotter(Matrix_01, timeRef, depthInfo_knownDepth, spkWidthInfo_knownDepth, samplingBiasArray, mapColor);

end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%  TIME-DEPTH PLOTTING  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [depthArray, depthMatrix] = TDPlotter(Matrix_01, timeRef, depthInfo_knownDepth, spkWidthInfo_knownDepth, samplingBiasArray, mapColor)
depthRange = 1:19; % This is the maximum depth across ALL sessions after alignment.
for depthUnit = depthRange(1):depthRange(end)  % for each depth unit do:
    cellsAtDepth = find( depthInfo_knownDepth == depthUnit ); % find neurons at that depth
    if isempty(cellsAtDepth) == 0               % is there are neurons at that depth then:
        for cell_idx = 1:numel(cellsAtDepth)    % for each neuron do:
            cell = cellsAtDepth(cell_idx);      % identify the index
            depthMatrix{depthUnit}(cell_idx,:) = Matrix_01( cell, :);  % the corresponding row in Matrix_01 is extracted.
        end
        depthArray_count(depthUnit,:) = sum(depthMatrix{depthUnit}, 1);  % This is the overall recruitment at that depth. sums of 1's and 0's across all neurons in that depth.
    else  % if there is no neuron, clearly we will stick with 0's for that depth.
        depthMatrix{depthUnit} = zeros( 1, size( Matrix_01, 2) );
        depthArray_count(depthUnit,:) = zeros( 1, size( Matrix_01, 2) );
    end
end
% depthArray_count contains the count of modulations at each unit time for
% each depth. So, we need to normalize it by dividing it by the samplingBiasArray at that depth.
depthArray = depthArray_count ./ repmat(samplingBiasArray,1,size(depthArray_count,2));

for neuronIdx = 1:size(depthInfo_knownDepth, 1)
    if  sum(Matrix_01(neuronIdx,:)) > 0
        dataPoint(neuronIdx,2) = depthInfo_knownDepth( neuronIdx );   % This is the onset time
        dataPoint(neuronIdx,1) =  find( Matrix_01(neuronIdx,:) == 1, 1 );   % this is the depth
        dataPoint(neuronIdx,3) = spkWidthInfo_knownDepth( neuronIdx ) > 250;   % this is the broad-spiking threshold.
    end
end
% add some offset to the depth-data in case there are overlapping points
dataPoint(:,[1 2]) = resolveOverlap(dataPoint(:,[1 2]),0.2);
%%%%%%%%%%%%%%%%%%%%%%%%%
% generating the figure:
imagesc(depthArray)
colormap(gca, mapColor); hold on
edgeColor = 'k'; faceColor = 'k';

dataPoint_narrowSpk = dataPoint( dataPoint(:,3) == 0, : );  % separating narrow and broad-spiking for plotting
dataPoint_broadSpk = dataPoint( dataPoint(:,3) == 1, : );
plot( dataPoint_broadSpk(:,1)-0.5, dataPoint_broadSpk(:,2),'^','MarkerEdgeColor',edgeColor,'MarkerFaceColor', faceColor); hold on;
plot( dataPoint_narrowSpk(:,1)-0.5, dataPoint_narrowSpk(:,2),'h','MarkerEdgeColor',edgeColor,'MarkerFaceColor', [1 1 1], 'markersize', 7); hold on;

yticks( 0:1:19 )
yticklabels( {[],[],[],[],'L2/3',[],[],[],[],[],[],[],[],'L5/6',[],[],[],[],[];} )
hline( 8.5, 'k--')
vline( timeRef, 'k-')
%%%% OK, now we have the necessary values to plot. Let's do the plotting:

xticks( 0:200:size(Matrix_01,2) );
xticklabels( [0:200:size(Matrix_01,2)] - timeRef + 1 );
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%  GENERATING MAP COLOR   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function mapColor = mapColorGen(color1, color2)
R = [linspace(color1(1),color2(1),100)  ];
G = [linspace(color1(2),color2(2),100)  ];
B = [linspace(color1(3),color2(3),100)  ];
mapColor = [R' G' B'];
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%  AVOIDING OVERLAPPING DATA POINTS FOR VISUALIZATION  %%%%%%%%%%%%%
function xy_matrix_noOverlap = resolveOverlap(xy_matrix, percShift)
% this function shifts x and y values of the matrix slightly to avoid
% overlapping datapoints. The dimension along which they can afford some shifting is the Y-axis (depth).
% perShift is the percentage by which the user is OK to shift data points
% if they fall on each other:

scaleShift = min( abs( diff(xy_matrix(:,2)) ) ).*percShift;
xy_points = unique( xy_matrix, 'rows' );
for xy_points_idx = 1:size(xy_points,1)
    overlappingPoints_idx = find( ismember( xy_matrix, xy_points(xy_points_idx, :), 'rows' ) );
    overlappingPoints_yValue = xy_points(xy_points_idx, 2);
    xValues = xy_points(xy_points_idx, 1); % this is shared amongst all
    yValues = [];
    yValues = linspace( (overlappingPoints_yValue - scaleShift) ,  (overlappingPoints_yValue + scaleShift) , numel( overlappingPoints_idx ) );
    addedPoints = [];
    for ii = 1:numel( overlappingPoints_idx )
        addedPoints( ii, : ) = [xValues, yValues(ii)];
    end
    xy_matrix_noOverlap( overlappingPoints_idx, : ) = addedPoints;
end
end

