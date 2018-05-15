function outputData = generateOutput(inputData, outputNeurons)

% Turn classe number into neuron outputs
[numSamples numberInputs] = size(inputData);
outputData   = -1*ones(numSamples, outputNeurons);

for i = 1: numSamples
    
    outputData(i, inputData(i,end)) = 1; 
    
end

end