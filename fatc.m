clc;%limpa o console
mdata =(importdata('abalone.data'));%le do arquivo
data = mdata.data; % importa os dados, aqui eles n tem informaçao da lcasse, o matlab ta ignorando as letras
classes = mdata.textdata;% aqqui o vetor de classes, ta consistente com a tava
countc = size(data, 2); %numero de colunas
countl = size(data, 1);%numero de linhas
for i=1:countc% pra cada atributo
    c = data(:,i);
    s = sum (c);% calcule a soma
    data(:, i) = c*(1/s);%normaliza a coluna
    
end
sum(data) %so confirmando que ta tudo normalizado
ndata = zeros(countl,1); % nova matriz, é a data mais as informacoes de class
% matrizes de dados separados por classe
F = []
M = []
I = []

for i=1:countl % preenche ndata, F, M, I com os exemplos. Enfim, a ndata sao os dados preparados para analise -- ponto de partida
   ndata(i, 2:countc+1) = data(i,1:countc);

    if(strcmp(classes{i},'F'))
       ndata(i,1) = 1;
     
    F=[F;ndata(i,:)];
   elseif(strcmp(classes{i},'M'))
        ndata(i,1) = 2;
        
    M=[M;ndata(i,:)];
   elseif(strcmp(classes{i},'I'))
        ndata(i,1) = 3;

    I=[I;ndata(i,:)];
    end
end
sum(F)
sum(M)
sum(I)
countF = size(F,1)

countM = size(M,1)

countI = size(I,1)


countF+countI+countM
%sum(ndata)
%so confirmando que ta tudo ok, a soma bateu, e os dados tao normalizados
%no geral.
k = 10% num of folds
ndata(:, 1);
C = cvpartition(ndata(:,1),'KFold',k)


for a= 1:C.NumTestSets
    % os conjuntos de teste e treinamento 
    test = ndata(C.test(a),:);
    train = ndata(C.training(a), :);
end
















