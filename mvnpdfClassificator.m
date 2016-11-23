function [ classificated, erros, confusionMatrix ] = mvnpdfClassificator( testData, testClasses,trainData, trainClasses )




%trainSize = size(trainData, 1);
testSize = size(testData ,1);
countc = size(testData, 2);
pw = zeros(1, 3);
ui = zeros(3,countc);
yi = zeros(3, countc);

% traine the
for w=1:3
    % array que contem os exemplos de uma classe do conjunto de
    % treinamento
    partclass= trainData(trainClasses(:,1)==w, :);
    % probabilidade da classe é exemplos da classe sobre exemplos
    % totais
    pw(w) = size(partclass(:,1))/ size(trainData(:, 1));
    % vetor de medias
    ui(w, :) = mean(partclass) ;
    %vetor de variancias
    yi(w, :) = var( partclass, 1);
end
d = size(ui, 2);

% testing

%  cx=zeros(size(testData(:, 1)), 1)
classificated = ones(testSize, 1);
erros = 0;
ptest = zeros(testSize, 3);
confusionMatrix = zeros(3, w);
for i=1: testSize;
    x = testData(i,:);
    for w=1:3
        
        ptest(i, w) = mvnpdf(x,ui(w,:), yi(w,:))* pw(w);
    end
    for w=1:3
        ptest(i, w) = ptest(i, w)/sum(ptest(i, :));
        
    end
    
    for w=1:3
        ptest(i, w) = ptest(i, w)/sum(ptest(i, :));
        
    end
    [prob(i,1), indi] = max(ptest(i, :));
    classificated(i) = indi;
    if(indi ~=testClasses(i))
        erros=erros+1;
        
    end
    confusionMatrix(min(indi, testClasses(i)), max(indi, testClasses(i))) = confusionMatrix(min(indi, testClasses(i)), max(indi, testClasses(i))) +1;
    
    
    
    
end
erros = erros/testSize;

%t1 = mvnpdf(testData, ui, )


end

