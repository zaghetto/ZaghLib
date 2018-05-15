function confMatrix = calcConfMatrix(best_net, tr, modes, INPUTS, TARGETS)

% Simulate outputs
SimOutputs = calcSimOutputs(best_net, tr, modes, INPUTS);

% Get correspondent subset of TARGETS
SimTargets = TARGETS(:,tr.testInd);
confMatrix = zeros(modes,modes);

% Construct confusion matrix
for i = 1:length(SimOutputs)
    outputSim = SimOutputs(:,i);
    TARGET = SimTargets(:, i);
    pred = find(outputSim == 1);
    act = find(TARGET == 1);
    confMatrix(act, pred) = confMatrix(act, pred) + 1;
end

end