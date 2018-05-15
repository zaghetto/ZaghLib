function x264QPfile(Np, qpf)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Alexandre Zaghetto                               %
% zaghetto@unb.br                                  %
% University of Brasília                           %
% Department of Computer Science                   %
% Laboratory of Images, Signals and Acoustics      %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Generate QP file for x264: IPPPPPP...            %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

qpfile = '  0 I';
for frNum = 1:Np-1
    if frNum < 10
        qpfile = [qpfile; '  ' num2str(frNum) ' P'];
    elseif frNum < 100
        qpfile = [qpfile; ' ' num2str(frNum) ' P'];
    else
        qpfile = [qpfile; num2str(frNum) ' P'];
    end
end

% Save qpfile
if ~exist(qpf, 'file')
    delete(qpf)
end

fid = fopen(qpf,'wt');
for i = 1:Np
    fprintf(fid,'%d %s\n', uint8(str2double(qpfile(i,1:3))), qpfile(i,4:end));
end
fclose(fid);


return