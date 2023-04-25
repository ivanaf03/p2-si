clear all;

entradas=xlsread('/New Folder/zoo.xlsx','Entradas RNA');
salidas=xlsread('/New Folder/zoo.xlsx','Salidas RNA');
entradas=entradas';
salidas=salidas';

arquitecturas = {[]};
%arquitecturas={[], [1], [3], [5], [8], [10], [5 3]};

for i=1:length(arquitecturas)
   arquitectura=arquitecturas{i};
   precisionEntrenamiento = [];
   precisionValidacion = [];
   precisionTest = [];

   %for j=1:50
   rna = patternnet(arquitectura);
   %rna.trainParam.showWindow = false; %cambiar para mostrar la ventana
   [rna, tr] = train(rna, entradas, salidas); 
   out = sim(rna, entradas);

    precisionEntrenamiento(end+1) = 1-confusion(salidas(:,tr.trainInd), out(:,tr.trainInd));
    precisionValidacion(end+1) = 1-confusion(salidas(:,tr.valInd),out(:,tr.valInd));
    precisionTest(end+1) = 1-confusion(salidas(:,tr.testInd), out(:,tr.testInd));
   %end
  
   fprintf('Entrenamiento %.2f%% (%.2f), Validación %.2f%% (%.2f), Test: %.2f%% (%.2f)\n', mean(precisionEntrenamiento)*100, std(precisionEntrenamiento)*100, mean(precisionValidacion)*100, std(precisionValidacion)*100,mean(precisionTest)*100, std(precisionTest)*100);
end
