function fitGaussHist(EXPERIMENTOS, xlab, ylab)

figure

index = histfit(EXPERIMENTOS, round(sqrt(length(EXPERIMENTOS))), 'normal');
index(1).FaceColor = [.9 .9 .9];

i = find( abs(index(2).XData-mean(EXPERIMENTOS)) == min(abs(index(2).XData-mean(EXPERIMENTOS))));
hold on

stem(index(2).XData(i), index(2).YData(i),'ob','LineWidth',2);

j = find(abs((abs(index(2).XData) - abs(mean(EXPERIMENTOS) - std(EXPERIMENTOS)))) == min(abs((abs(index(2).XData) - abs(mean(EXPERIMENTOS) - std(EXPERIMENTOS)))))  );
k = find(abs((abs(index(2).XData) - abs(mean(EXPERIMENTOS) + std(EXPERIMENTOS)))) == min(abs((abs(index(2).XData) - abs(mean(EXPERIMENTOS) + std(EXPERIMENTOS)))))  );

stem([index(2).XData(j) index(2).XData(k)], [index(2).YData(j) index(2).YData(k) ],'xk','LineWidth',2);
grid on

% j = find(abs((abs(index(1).XData) - abs(mean(EXPERIMENTOS) - std(EXPERIMENTOS)))) == min(abs((abs(index(1).XData) - abs(mean(EXPERIMENTOS) - std(EXPERIMENTOS)))))  );
% k = find(abs((abs(index(1).XData) - abs(mean(EXPERIMENTOS) + std(EXPERIMENTOS)))) == min(abs((abs(index(1).XData) - abs(mean(EXPERIMENTOS) + std(EXPERIMENTOS)))))  );

count = sum(index(2).YData(j:k));

titl = ['M \pm S = ' num2str(100*count/sum(index(2).YData)) '%'];
xlabel(xlab)
ylabel(ylab)
title(titl)

set(gca,'fontsize', 12)

h = legend('Histogram', 'Gaussian fit', ['M = ' num2str(round(1000*mean(EXPERIMENTOS))/1000)], ['S = \pm' num2str(round(1000*std(EXPERIMENTOS))/1000)]);


return