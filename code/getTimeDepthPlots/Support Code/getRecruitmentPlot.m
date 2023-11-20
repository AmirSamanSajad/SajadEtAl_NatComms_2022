function [recruitmentData] = getRecruitmentPlot(modTimes, timeRange, neuronInfo, Color_RGB, spkWidthDivideFlag)
% This code generates recruitment plots:
% NOTE: the recruitment plot represents the dynamics of neuron modulations across time:
%       It plots the cumulative recruitment at each unit time.

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
% Color_RGB - User can indicate the color to use.
%
% spkWidthDivideFlag - if 1 it means spk width differentiation will be
%                shown. If 0, all will be in the same pool

%%%%%% OUTPUTS:
% recruitmentData
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if nargin < 4; Color_RGB = [0 0 0]; % Color_RGB can be empty. If empty, the default will be black.
end
if nargin < 5; spkWidthDivideFlag = 1; % dividing visualization between narrow and broad-spiking is the default.
end
% need to restrict our data only to neurons from perpendicular penetrations:
numberOfNeurons = size(modTimes,1);
timeRange = timeRange(1):timeRange(end); % in case the full array is not in the input.
timeDur = range(timeRange);
timeRef = find( timeRange == 0 );
Matrix_01 = zeros( numberOfNeurons, timeDur ); % Matrix_01 is a matrix that contains 1's for significant period.
for neuron = 1:numberOfNeurons  % for each neuron do (neuron indicates row index in Matrix_01.
    if ~isnan( modTimes(neuron,1) ) & ~isnan( modTimes(neuron,2) )
    mod_index = [ modTimes(neuron,1):modTimes(neuron,2) ] + timeRef;  % this is now the index in the Matrix_01 column where we need to switch 0's to 1's.
    mod_index( mod_index < 0 ) = []; mod_index( mod_index > (timeDur-1) ) = [];  % we cut out those 1's that fall outside of timeRange.
    Matrix_01( neuron, mod_index ) = 1;
    end
end
% now let's extract other relevant information
spkWidthInfo = neuronInfo.spikeWidth_ms; % convert the sampling
% Now we have all the inputs needed to run recruitPlotter.

%%%%%%%%[depthArray, depthMatrix, h_timeDepthPlot] = recruitPlotter(Matrix_01, timeRef, depthInfo_knownDepth, spkWidthInfo_knownDepth, samplingBiasArray, mapColor)
for spkCateg = 1:2   % for each neuron spike-width category do:
    spkCateg_01 = spkWidthInfo <= 250;  % if narrow spiking it's 1, if broad-spiking it's 0
    cellsInSpkCateg = find( spkCateg_01 == (spkCateg-1) ); % find neurons in that spike-width category
    if isempty(cellsInSpkCateg) == 0               % is there are neurons at that spike-width category then:
        for cell_idx = 1:numel(cellsInSpkCateg)    % for each neuron do:
            cell = cellsInSpkCateg(cell_idx);      % identify the index
            recruitmentvals{spkCateg}(cell_idx,:) = Matrix_01( cell, :);  % the corresponding row in Matrix_01 is extracted.
        end
        recruitmentData.values(spkCateg,:) = sum(recruitmentvals{spkCateg}, 1);  % 1st row shows recruitment of broad-spiking. 2nd row shows recruitment of narrow-spiking.
    else  % if there is no neuron, clearly we will stick with 0's for that spike-width type.
        recruitmentData{spkCateg} = zeros( 1, size( Matrix_01, 2) );
        recruitmentData.values(spkCateg,:) = zeros( 1, size( Matrix_01, 2) );
    end
    if spkCateg == 1
        recruitmentData.rowLabel{spkCateg} = 'broad-spiking';
    elseif spkCateg == 2
        recruitmentData.rowLabel{spkCateg} = 'narrow-spiking';
    end
end
% Counting all modulated neurons at each unit time.
spkCategArray_all = sum( recruitmentData.values, 1 ) / numberOfNeurons; % normalizing by dividing by the total number of neurons.
spkCategArray_broad = recruitmentData.values( 1, : ) / numberOfNeurons; % 1st row is broad-spiking
% generating the figure:
% h_recruitmentPlot = figure;
aucFill(timeRange(1:end-1),spkCategArray_all, Color_RGB); hold on;
if spkWidthDivideFlag == 1  % if we want to visualize narrow, vs. broad-spiking, then we overlay the broad one.
    aucFill(timeRange(1:end-1),spkCategArray_broad, Color_RGB)
end
xlabel('Time from SSRT (ms)')
ylabel('p(modulated | time)')
vline( 0, 'k-' )
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% SUBFUNCTION: filling the area under the curve. %%%%%%%%%%%%%%%%%%%%%%
function aucFill(X,Y, color, transparency, line_flag)
if nargin <5
    line_flag = 1;
end
if nargin <4
    transparency = 0.3;
end
if nargin <3
    color = [0.5 0.5 0.5];
end
X = reshape(X, [],1);
Y = reshape(Y, [],1);
Yfill = Y/2;
dY = Y/2;
NonanIndex = find(isnan( X + Y + dY) == 0);
X = X(NonanIndex);
Yfill = Yfill(NonanIndex);
dY = dY(NonanIndex);
if line_flag == 0
    fill([X;flipud(X)],[Yfill-dY;flipud(Yfill+dY)],color,'linestyle','none', 'edgealpha', transparency, 'facealpha', transparency);
elseif line_flag == 1
    fill([X;flipud(X)],[Yfill-dY;flipud(Yfill+dY)],color, 'edgealpha', transparency, 'facealpha', transparency);
end
end
