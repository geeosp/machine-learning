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
k = 100;% num of folds


C = cvpartition(ndata(:,1),'KFold',k);
acuracy = zeros(C.NumTestSets,1);
for a= 1:C.NumTestSets
    % os conjuntos de teste e treinamento
    
    testData = ndata(C.test(a),2:end);
    testClasses = ndata(C.test(a), 1);
     testSize = size(testData ,1);
    trainData = ndata(C.training(a), 2:end);
    trainClasses = ndata(C.training(a), 1);
    
    trainSize = size(trainData, 1);
    
    
    [class, acuracy(a), confusion] = mvnpdfClassificator( testData, testClasses,trainData, trainClasses );
    
   
end 

%[h, pvalue, ci] =ztest(mean(acuracy), mean(acuracy), std(acuracy))
















