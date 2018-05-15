function [best_net, best_tr, endTr, best_Rate, best_Perf] = multipleNNtrain(net, best_net, tr, modes, INPUTS, TARGETS, ContMax, endTr, best_Rate, best_Perf, epoch)

% Maximum number of trainings
count = 0; 

% Training results
best_tr = tr;

% The show begins
while (count < ContMax && ~endTr)
    
    % Counter
    count = count + 1;
    
    % Initialize weights
    net = init(net);
    
    % Begin training
    [net, tr] = train(net, INPUTS, TARGETS);

    % Hit rate
    Rate = calcRate(net, tr, modes, INPUTS, TARGETS);
            
    % Save best network
    if Rate > best_Rate
        
        best_Perf = tr.best_perf;
        best_Rate = Rate;
                       
        best_net = net;
        best_tr = tr;        
                      
        %txt = sprintf('multipleNNtrain (best performance): %5i %5s %5s %10s %10s', epoch, num2str(best_net.layers{1}.size), num2str(best_net.layers{2}.size), num2str(best_Perf), num2str(best_Rate));
        %disp(txt)

    end
    
    % If performance is 100% stops training completely
    if Rate == 100
        endTr = 1;
    end
    
    
    
end



