[total_accuracyLinear,results,real_results,resultROC,realResulROC,ROC,vectorAccuracyLinear] = ClassificationPiattoVsCavoVsNormale ('first','standard');
[total_accuracyNonLinear,results,real_results,resultROC,realResulROC,ROC,vectorAccuracyNonLinear] = ClassificationPiattoVsCavoVsNormaleNonLinearSVM ('first','standard');
% figure(1)
% boxplot(vectorAccuracyLinear);
% figure(2)
% boxplot(vectorAccuracyNonLinear);
% matrix=zeros(100,2);
% matrix(:,1)=vectorAccuracyLinear';
% matrix(:,2)=vectorAccuracyNonLinear';
% figure(4)
[p,tbl] = anova2(matrix,2);
[p,tbl,stats] = anova2(matrix,2,'off');
figure(3)
c = multcompare(stats)