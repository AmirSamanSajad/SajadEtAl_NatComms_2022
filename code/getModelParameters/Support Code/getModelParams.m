function [trls_params, mean_trls_params, paramVals] = getModelParams( trialInfo )
% This function takes in trial information about a session and extracts behavioral and task parameters used for modeling neural activity.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
%%%%%%%%%% INPUTS:
% trialInfo - must be a table with the following columns:
             % trialNumber
             % SSD
             % SSDbin - 1, 2, or 3
             % RT
             % canceled - 1 if the trial is canceled, 0 if not
             % NCerror - 1 if the trial is NCerror, 0 if not
             % NCpremature - 1 if the trial is NCpremature, 0 if not
             % noStop - 1 if the trial is noStop, 0 if not.
             % abort - 1 if neither canceled, NCerror, NCpremature, noStop.
%%%%%%%%% OUTPUTS:
% trl_params - this is a table that gives every parameter value for
        % canceled trials used for the model. The reason this data is per-trial is
        % so the user can choose which trials to include / exclude in further
        % analysis. Note: trials corresponding to non-stationary spiking will be
        % eliminated down the road.
% paramVals - This contains the parameter values calculated for each SSD
        % (not SSDbin). This can be used for visualizing how model parameters
        % evolve as a function of SSD. 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
SSDlist = unique( trialInfo.SSD ); SSDlist( isnan(SSDlist) ) = [];       % This is just the set of SSDs used in this study.
xC_trl = find( trialInfo.trlFlag_canceled == 1);  % xC means, all canceled trials irrespective of what the previous trial is (x means it can be anything).
xNC_trl = find( trialInfo.trlFlag_NCerror == 1  | trialInfo.trlFlag_NCpremature == 1 );   % xNC means non-canceled trials irrespective of the preceding trial.
xNCerror_trl = find( trialInfo.trlFlag_NCerror == 1 );   % xNC means non-canceled error (NCerror) trials irrespective of the preceding trial.
xNoStop_trl = find( trialInfo.trlFlag_noStop == 1 );  % all no-stop trials irrespective of trial history (previous trial denotated by x)
xStopSignal_trl = find( trialInfo.trlFlag_canceled == 1 | trialInfo.trlFlag_NCerror == 1 | trialInfo.trlFlag_NCpremature == 1 );  % all stop-signal trials irrespective of sub-type
xSSseen_trl = find( trialInfo.trlFlag_canceled == 1 | trialInfo.trlFlag_NCerror == 1 );  % all stop-signal trials in which SS is seen! irrespective of sub-type
                                                                          
% In preparation for parameter extraction we need a few values:
SSDdist_all = hist( trialInfo.SSD, SSDlist );  % total stop-signal trial count at each SSD
SSDdist_C = hist( trialInfo.SSD(xC_trl), SSDlist );   % total canceled trial count at each SSD
SSDdist_NC = hist( trialInfo.SSD(xNC_trl), SSDlist );   % total non-canceled trial count at each SSD
SSDdist_NCerror = hist( trialInfo.SSD(xNCerror_trl), SSDlist );   % NCerror count at each SSD
SSDdist_SSseen = SSDdist_C + SSDdist_NCerror; % on C trials and NCerror trials the stop-signal is seen before the response.
% Extracting parameter values (paramVals):
paramVals.pNC(1,:) = SSDdist_NC ./ SSDdist_all; % probability of NC | SS trial, at each SSD
paramVals.pError(1,:) = (SSDdist_NCerror ./ SSDdist_SSseen);
paramVals.SSD(1,:) = SSDlist;  % units in ms.
paramVals.logSSD(1,:) = log10(SSDlist);  % units in ms.
paramVals.ToneTime(1,:) = 1500 - SSDlist;  % units in ms.
paramVals.logToneTime(1,:) = log10(1500 - SSDlist); % units in ms.

% Now, we get to hazard rate model calculations:
%%% FOR STOP-SIGNAL:
      stopSignal_prob = 0.5;  % If the task is designed such that Stop-signal doesn't appear after response (i.e., on premature NC trials) then 
                      % this probability can be obtained from those stop-signal trials in which the stop-signal is seen.
                      % In our experiment design, SS appeared eventually even if response was made. Therefore, probability of stop-trial is sampled based on all stop-signal trials.
    %%% HAZARD RATE: hazard rate models test how likely is an event at any moment in time provided that it has not happened yet.
        % If the stop-signal distribution is obtained from C trials, then:
        paramVals.hazardRate_stopSignal_absolute_C(1,:) = hazardF( SSDdist_C, stopSignal_prob ); % This is the mathematical calculation of hazard rate, with no consideration for perceptual errors (Weber's law).
        % If the stop-signal distribution is obtained from SS seen trials, then:
        paramVals.hazardRate_stopSignal_absolute_SSseen(1,:) = hazardF( SSDdist_SSseen, stopSignal_prob ); % This is the mathematical calculation of hazard rate, with no consideration for perceptual errors (Weber's law).
             % IMPORTANT: HazardF.m  calculates hazard rate in its standard
             % definition when the 2nd input (probability of event) = 1. Here,
             % because event probability (i.e., stopSignal_prob) < 1, it calculates
             % the *conditional hazard rate*, incorporating the probabilitistic
             % nature of the event. More elaboration in the "hazardF.m" function.
        WeberFactor = 0.26;
        % If the stop-signal distribution is obtained from C trials, then:
        paramVals.hazardRate_stopSignal_subjective_C(1,:) = hazardF_subjective( SSDdist_C, SSDlist, stopSignal_prob, WeberFactor, min(diff(SSDlist))/2 );
        % If the stop-signal distribution is obtained from SS seen trials, then:
        paramVals.hazardRate_stopSignal_subjective_SSseen(1,:) = hazardF_subjective( SSDdist_SSseen, SSDlist, stopSignal_prob, WeberFactor, min(diff(SSDlist))/2 );
        %%%%% For Dynamic hazard rate we need to run some additional
        %%%%% functions:
        perTrial_restricted_pdf_element = stairPDFextract( trialInfo, {}, {'C', [1 2 3]} );
        hF_Matrix_C = hazardF_subjective_dynamic( SSDdist_C, SSDlist, stopSignal_prob, perTrial_restricted_pdf_element, WeberFactor, min(diff(SSDlist))/2 );
        paramVals.hazardRate_stopSignal_dynamic_C(1,:) = nanmean( hF_Matrix_C, 1);
        
        perTrial_restricted_pdf_element = stairPDFextract( trialInfo, {'NCerror', [-1 -2 -3]}, {'C', [1 2 3]} );
        hF_Matrix_ssSeen = hazardF_subjective_dynamic( SSDdist_SSseen, SSDlist, stopSignal_prob, perTrial_restricted_pdf_element, WeberFactor, min(diff(SSDlist))/2 );
        paramVals.hazardRate_stopSignal_dynamic_SSseen(1,:) = nanmean( hF_Matrix_ssSeen, 1);
          
   %%% SURPRISE: Because Hazard Rate tells us what is the probability of an 
                % event happening at time T provided that it has not happened yet, 
                % from hazard rate we can calculate surprise: The surprise
                % associated with an event happening at time T provided
                % that it has not happend yet. In our analyses we have
                % considered two calculations for surprise. The results for
                % both very virtually identical, so we chose the method
                % that's in agreement with previous literature:
                % Method 1) surprise = 1 - hazard rate
                % Our hazard rate models already account for this. 
                % Method 2) surprise = -log2(hazard rate)
        paramVals.surprise_stopSignal_absolute_C = -log(  paramVals.hazardRate_stopSignal_absolute_C );
        paramVals.surprise_stopSignal_absolute_SSseen = -log( paramVals.hazardRate_stopSignal_absolute_SSseen ); 
        paramVals.surprise_stopSignal_subjective_C = -log(  paramVals.hazardRate_stopSignal_subjective_C );
        paramVals.surprise_stopSignal_subjective_SSseen = -log( paramVals.hazardRate_stopSignal_subjective_SSseen ); 
%         paramVals.surprise_stopSignal_dynamic_C = nanmean( -log(hF_Matrix_C), 1 );
%         paramVals.surprise_stopSignal_dynamic_SSseen = nanmean( -log(hF_Matrix_ssSeen) , 1 );
        paramVals.surprise_stopSignal_dynamic_C =  -log(  nanmean(hF_Matrix_C, 1 ) );           
        paramVals.surprise_stopSignal_dynamic_SSseen = -log( nanmean(hF_Matrix_ssSeen , 1 ) );

%%% FOR TONE:
    tone_prob = 1.0; % whenever stopping is successful, the success tone was reliably presented.
    % NOTE: The task design was such that SSD + Tone Time (re SSD) = 1500 on canceled-trials (C).
    % Therefore, we probability distribution of Tone Time can be easily derived from SSDdist_C.
    TONEdist_C = flip(SSDdist_C); % Note that SSD bins 1,2,3 now correspond to the last set of bins here.
    toneTimeList = flip(paramVals.ToneTime); % values should be ascending to match TONEdist_C index.
    %%% HAZARD RATE: this is easy because it's deterministic!
        paramVals.hazardRate_tone_absolute_C(1,:) =  flip(  hazardF( TONEdist_C, tone_prob )  ); % flip is done so that the indeces match those of SSD. (notet that tone time dist was flip of ssd dist)
        paramVals.hazardRate_tone_subjective_C(1,:) =  flip(  hazardF_subjective( TONEdist_C, toneTimeList, tone_prob, WeberFactor, min(diff(toneTimeList))/2 )  );
    %%% SURPRISE: Again, from hazard rate values we can calculate surprise associated with the time at each tone time:
%         paramVals.surprise_tone_absolute_C(1,:) = -log( paramVals.hazardRate_tone_absolute_C );
%         paramVals.surprise_tone_subjective_C(1,:) = -log( paramVals.hazardRate_tone_subjective_C );
        
    %%%%% DYNAMIC:
    % NOTE: For the dynamic version of HAZARD RATE and SURPRISE, we need to
    % restrict the tone-time based on the experienced SSD.
    
    indexFlip_flag = 'flip';
    perTrial_restricted_pdf_element_forTone = toneRulePDFextract( trialInfo, indexFlip_flag ) ;
    hF_Matrix_C_tone = hazardF_subjective_dynamic( TONEdist_C, toneTimeList , tone_prob, perTrial_restricted_pdf_element_forTone, WeberFactor, min(diff(SSDlist))/2 );
    paramVals.hazardRate_tone_dynamic_C(1,:) = flip( nanmean( hF_Matrix_C_tone, 1) );
    
    
%%%%%%%%%%%
%% Now that we have the parameter values, we can extract the relevant one for each trial. 
   % NOTE: paramVals gives the parameter estimates/calculations for each
   % SSD. However, not every SSD is of interest to us and each trial is
   % only associated with one SSD value.
   % We only care about these parameters for Canceled trials.
paramNames = fields(paramVals);   
trls_params = table;
for trl = 1:numel(xC_trl) % for each canceled trial do:
    trls_params.trial(trl,1) = xC_trl(trl);  % real trial index in the entire session.
    trls_params.SSDbin(trl,1) = trialInfo.C_SSDbin( trls_params.trial(trl,1) ,1 ); % identify whether it falls into SSD1, SSD2, or SSD3. 
    trls_params.SSDListIdx(trl,1) = find( SSDlist == trialInfo.SSD( trls_params.trial(trl,1) ,1) ); % what SSD index? This indicates where in paramVal arrays to extract that trial's relevant info.
    for paramIdx = 1:numel(paramNames)
        trls_params.(paramNames{paramIdx})(trl,1) = paramVals.( paramNames{paramIdx} )( trls_params.SSDListIdx(trl,1) );
    end
end
% We are only including trials with SSDbin = 1, 2, or 3 in our analysis.
% Note that only a few trials do not fall under these categories. This is
% because canceled trials are typically early-SSD trials.
SSDbinList = [ 1 2 3 ];
trls_params( ~ismember( trls_params.SSDbin, SSDbinList ), : ) = [];
%% let's also get the mean for each SSDbin:
mean_trls_params = table;
for SSDbinIdx = 1:3
    for paramIdx = 1:numel(paramNames)
        mean_trls_params.SSDbin(SSDbinIdx,1) = mean( trls_params.SSDbin( trls_params.SSDbin == SSDbinIdx ) );
        mean_trls_params.(paramNames{paramIdx})(SSDbinIdx,1) = mean( trls_params.(paramNames{paramIdx})( trls_params.SSDbin == SSDbinIdx ) );
    end
end