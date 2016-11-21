clc;
mdata =(importdata('abalone.data'));
data = mdata.data;
classes = mdata.textdata;
x = mean(data)
countc = size(data, 2);
countl = size(data, 1);
for i=1:countc
    c = data(:,i);
    s = sum (c);
    data(:, i) = c*(1/s);
    
end
sum(data)
ndata = zeros(countl,1);
for i=1:countl
   if(strcmp(classes{i},'F'))
       ndata(i) = 1;
   elseif(strcmp(classes{i},'M'))
        ndata(i) = 2;
   elseif(strcmp(classes{i},'F'))
               ndata(i) = 3;
   end
   ndata(i, 2:countc+1) = data(i,1:countc);
end




