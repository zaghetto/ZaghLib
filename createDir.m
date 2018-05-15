function createDir(ImTempDir)

% Get current folder
currentFolder = pwd;

if (exist([currentFolder '\' ImTempDir], 'dir'));
    rmdir([currentFolder '\' ImTempDir], 's');
end
eval(['mkdir ' ImTempDir]);


end