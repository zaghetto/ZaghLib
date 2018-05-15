%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Alexandre Zaghetto                               %
% zaghetto@unb.br                                  %
% University of Brasília                           %
% Department of Computer Science                   %
% Laboratory of Images, Signals and Acoustics      %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Add ZaghLib to path                              % 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

FOLDER = uigetdir([], 'Select ZaghLib folder');

extra_paths = {FOLDER};

for k = 1:length(extra_paths)
	if length(strfind(path, extra_paths{k}))==0
		addpath(genpath(extra_paths{k}))
	end
end
