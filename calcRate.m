function Rate = calcRate(net, tr, modes, INPUTS, TARGETS)

% Simulated outputs
SimOutputs = calcSimOutputs(net, tr, modes, INPUTS);

% Compute rate
Rate = 100*length(find(sum(abs(SimOutputs-TARGETS(:,tr.testInd)))==0))/length(SimOutputs);

end

