function [data, mu, var, weight] = GMMcreate(M, dim, N)

% 生成实验样本集，由M组正态分布的数据构成

% % GMM模型的原理就是仅根据数据估计参数：每组正态分布的均值、方差，

% 以及每个正态分布函数在GMM的权重alpha。

% 在本函数中，这些参数均为随机生成，

% 

% 输入

%   M    : 高斯函数个数

%   dim  : 数据维数

%   N    : 数据总个数

% 返回值

%   data : dim-by-N, 每列为一个数据

%   miu  : dim-by-M, 每组样本的均值，由本函数随机生成

%   var  : 1-by-M, 均方差，由本函数随机生成

%   weight: 1-by-M, 每组的权值，由本函数随机生成

% ---------------------------------------------------- 

%

% 随机生成不同组的方差、均值及权值

weight = rand(1,M);
weight = weight / norm(weight, 1); % 归一化，保证总合为1
var = double(mod(int16(rand(1,M)*100),10) + 1);  % 均方差，取1~10之间，采用对角矩阵
mu = double(round(randn(dim,M)*100));            % 均值，可以有负数

 

for(i = 1: M)
  if (i ~= M)
    n(i) = floor(N*weight(i));
  else
    n(i) = N - sum(n);
  end
end

start = 0;

for (i=1:M)
  X = randn(dim, n(i));
  X = X.* var(i) + repmat(mu(:,i),1,n(i));
  data(:,(start+1):start+n(i)) = X;
  start = start + n(i);
end

