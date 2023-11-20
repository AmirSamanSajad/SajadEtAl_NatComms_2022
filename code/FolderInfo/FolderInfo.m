function [codeFolder, dataFolder, mainFolder] = FolderInfo()
% This function allows you to set the folder in one place, and seeing the
% effect in all the functions calling CODES and DATA folders.
mainFolder = 'C:\Users\Steven\Desktop\2022-NComms-SEF';
codeFolder = fullfile(mainFolder, 'code');
dataFolder = fullfile(mainFolder, 'data');