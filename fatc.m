clc;%limpa o console
clearvars
mdata =(importdata('abalone.data'));%le do arquivo
data = mdata.data; % importa os dados, aqui eles n tem informaçao da lcasse,o matlab ta ignorando as letras
classes = mdata.textdata;% aqqui o vetor de classes, ta consistente com a tava
countc = size(data, 2); %numero de colunas
countl = size(data, 1);%numero de linhas
for i=1:countc% pra cada atributo
    c = data(:,i);
    s = sum (c);% calcule a soma
   % data(:, i) = c*(1/s);%normaliza a coluna
    
end
sum(data) ;%so confirmando que ta tudo normalizado
ndata = zeros(countl,1); % nova matriz, é a data mais as informacoes de class
% matrizes de dados separados por classe

for i=1:countl % preenche ndata, F, M, I com os exemplos. Enfim, a ndata sao os dados preparados para analise -- ponto de partida
    ndata(i, 2:countc+1) = data(i,1:countc);
    
    if(strcmp(classes{i},'F'))
        ndata(i,1) = 1;
        
    elseif(strcmp(classes{i},'M'))
        ndata(i,1) = 2;
        
    elseif(strcmp(classes{i},'I'))
        ndata(i,1) = 3;
        
    end
end


%sum(ndata)
%so confirmando que ta tudo ok, a soma bateu, e os dados tao normalizados
%no geral.
k = 10;% num of folds


C = cvpartition(ndata(:,1),'KFold',k);
for a= 1:1% C.NumTestSets
    % os conjuntos de teste e treinamento
    
    testData = ndata(C.test(a),2:end);
    testClasses = ndata(C.test(a), 1);
     testSize = size(testData ,1);
    trainData = ndata(C.training(a), 2:end);
    trainClasses = ndata(C.training(a), 1);
    
    trainSize = size(trainData, 1);
    
    
   %{ 
    % valid
    split1 = 1000;
    % train
    split2 = 3000;
    testData = ndata(1: split1, 2:end);
    testClasses = ndata(1:split1, 1);
    testSize = size(testData ,1);
    trainData = ndata(split1+1: split2, 2:end);
    trainClasses = ndata(split1+1:split2, 1);
    trainSize = size(trainData, 1);
   %} 
    % bayes =  fitcnb(ndata(:, 2:end),ndata(:, 1), 'distribution', 'normal')
    partclass =[];
    pw = zeros(1, 3);
    ui = zeros(3,countc);
    yi = zeros(3, countc);
 
    % traine the
    for w=1:3
        % array que contem os exemplos de uma classe do conjunto de
        % treinamento
        partclass= trainData(trainClasses(:,1)==w, :);
        partCount = size(partclass(:,1));
        
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
             erros=erros+1
             
         end
     confusionMatrix(min(indi, testClasses(i)), max(indi, testClasses(i))) = confusionMatrix(min(indi, testClasses(i)), max(indi, testClasses(i))) +1
   
   
        
        
    end
       erros = erros/testSize
    %t1 = mvnpdf(testData, ui, )
end


















