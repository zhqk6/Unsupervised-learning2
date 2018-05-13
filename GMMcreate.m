function [data, mu, var, weight] = GMMcreate(M, dim, N)

% ����ʵ������������M����̬�ֲ������ݹ���

% % GMMģ�͵�ԭ����ǽ��������ݹ��Ʋ�����ÿ����̬�ֲ��ľ�ֵ�����

% �Լ�ÿ����̬�ֲ�������GMM��Ȩ��alpha��

% �ڱ������У���Щ������Ϊ������ɣ�

% 

% ����

%   M    : ��˹��������

%   dim  : ����ά��

%   N    : �����ܸ���

% ����ֵ

%   data : dim-by-N, ÿ��Ϊһ������

%   miu  : dim-by-M, ÿ�������ľ�ֵ���ɱ������������

%   var  : 1-by-M, ������ɱ������������

%   weight: 1-by-M, ÿ���Ȩֵ���ɱ������������

% ---------------------------------------------------- 

%

% ������ɲ�ͬ��ķ����ֵ��Ȩֵ

weight = rand(1,M);
weight = weight / norm(weight, 1); % ��һ������֤�ܺ�Ϊ1
var = double(mod(int16(rand(1,M)*100),10) + 1);  % �����ȡ1~10֮�䣬���öԽǾ���
mu = double(round(randn(dim,M)*100));            % ��ֵ�������и���

 

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

