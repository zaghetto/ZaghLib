function normInputData = nomalizeData(inputData)

% Normalize input vector
meansInput = mean(inputData);
stdInput = std(inputData);

[h, w] = size(inputData);
normInputData = zeros(h,w);

% The last column is the class index
for i = 1:length(meansInput)-1
    normInputData(:,i) = (inputData(:,i)-meansInput(i))/stdInput(i);    
end

% Copy targets
normInputData(:,end) = inputData(:,end);

end