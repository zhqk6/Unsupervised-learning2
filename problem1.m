clear;
K=3;%2,4,5
m=[14 10 -4 -4 0 0;
   6 -1 6 -1 14 1];
for i=1:K
    Mean(:,i)=m(:,i);
    Sigma(:,:,i)=eye(2);
    Pai(i)=(1/K);
end
data=load('GMD_F16.dat');
figure;
plot(data(:,1),data(:,2),['b','.']);
title('original data samples');
[a,b]=size(data);
lt=1;
iteration=0;
likelihood=zeros(1,25);
while(lt>=0.0001)
iteration = iteration +1;
%E step begins
for i=1:a
    for j=1:K
        rk(i,j)=Pai(j)*mvnpdf(data(i,:)',Mean(:,j),Sigma(:,:,j));
    end
    temp_rk(i)=sum(rk(i,:));
    for j=1:K
        rk(i,j)=rk(i,j)/temp_rk(i);
        Nk(j)=sum(rk(:,j));
    end
end


%M step begins
sigmaNew=zeros(2,2,K);
result=zeros(1000,2,K);
for i=1:K
    PaiNew(i)=Nk(i)/a;  %new paik
    MeanNew(:,i)=(data'*rk(:,i))/Nk(i); % new mean
    for j=1:a
   result(j,:,i)=data(j,:)-MeanNew(:,i)';
    end
    rk_tmp=[rk(:,i) rk(:,i)];
    sigmaNew(:,:,i)=(result(:,:,i)'*(rk_tmp.*result(:,:,i)))/Nk(i);%new sigma
end
    
for i=1:a
    for j=1:K
        rk_new(i,j)= PaiNew(j)*mvnpdf(data(i,:)',MeanNew(:,j),sigmaNew(:,:,j));
    end
    temp_rknew(i)=sum(rk_new(i,:));
    for j=1:K
        rk_new(i,j)=rk_new(i,j)/temp_rknew(i);
    end
end

likelihood(iteration)=sum(log(temp_rk));
likelihood(iteration+1)=sum(log(temp_rknew));
lt=abs((likelihood(iteration)-likelihood(iteration+1))/likelihood(iteration));
Mean=MeanNew;
Pai=PaiNew;
Sigma=sigmaNew;
result(:,:,:)=0;
rk(:,:)=0;
Nk(:)=0;
end

figure;
plot(likelihood);
title(' log likelihood ');

figure;
%K=3
for i=1:a
    p=[rk_new(i,1),rk_new(i,2),rk_new(i,3)];
    [p1,e1]=max(p);
    if e1==1   
        plot(data(i,1),data(i,2),['r','.']);hold on;
    elseif   e1==2
        plot(data(i,1),data(i,2),['b','.']);hold on;
    else
        plot(data(i,1),data(i,2),['g','.']);hold on;
    end
end
title('samples result');

