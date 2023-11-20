[codeFolder, dataFolder] = FolderInfo() % file directory information is located here.
load([dataFolder '\trialInfo.mat'])
for session = 1:29
    trialInfo_perSession = trialInfo.(['session_' int2str(session)]);
    [trls_params.(['session_' int2str(session)]), mean_trls_params.(['session_' int2str(session)]), paramVals.(['session_' int2str(session)])] = getModelParams( trialInfo_perSession );
    clear trialInfo_perSession
end