clear;
close all;
[data,mu,var,weight]=GMMcreate(3,2,500);
figure;
for i=1:500
    plot(data(1,i),data(2,i),['r','.']);
    hold on;
end
title('Gaussian mixture model');

data=data';
N=3;
[m, n]=size(data);
centroid=zeros(N,n);
u=zeros(1,N);
L=zeros(m,1);
count=zeros(N,1);
literation=20;

%Centroids
centroid(1,:)=[0 0];
centroid(2,:)=[5 5 ];
centroid(3,:)=[10 10];

for XW=2:literation+1

    u=zeros(1,N);
    for i=1:m
        for j=1:N
            u(1,j)=norm(data(i,:)-centroid(j,:));
        end
        [x]=find(u==(min(u)));
        L(i,1)=x;
    end

    centroid=zeros(N,n);
    pz=centroid;
    count=zeros(N,1);

    for i=1:m
        if(L(i,1)==1)
            centroid(1,:)=data(i,:)+centroid(1,:);
            count(1,1)= count(1,1)+1;
        elseif (L(i,1)==2)
            centroid(2,:)=data(i,:)+centroid(2,:);
            count(2,1)= count(2,1)+1;
        else
            centroid(3,:)=data(i,:)+centroid(3,:);
            count(3,1)= count(3,1)+1;
        end
    end
    centroid(1,:)= centroid(1,:)/count(1,1);
    centroid(2,:)= centroid(2,:)/count(2,1);
    centroid(3,:)= centroid(3,:)/count(3,1);

end
figure;
for i=1:m
    if(L(i,1)==1)
        plot(data(i,1),data(i,2),['r','*']);
        hold on
    elseif (L(i,1)==2)
        plot(data(i,1),data(i,2),['g','O']);
        hold on
    else
        plot(data(i,1),data(i,2),['b','.']);
        hold on
    end
end
title('final classified samples');