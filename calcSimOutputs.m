function SimOutputs = calcSimOutputs(best_net, tr, modes, INPUTS)

% Number of output vectors
numOutputs = length(tr.testInd);

% Simulate output
SimOutputsRaw = best_net(INPUTS(:,tr.testInd));

% Initialize binary output matrix
SimOutputs = -1*ones(modes, numOutputs);

% Maximum value will be set to 1
for i = 1:numOutputs    
    j = find(SimOutputsRaw(:,i) == max(SimOutputsRaw(:,i)));
    SimOutputs(j,i) = 1;   
end

end