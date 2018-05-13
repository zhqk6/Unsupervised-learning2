data=load('GKlines.dat');
[m,n]=size(data);
N = 2;
%number of clusters
Fuzzifier = 2;
%fuzzifier
L = 2;

c1=[-1 0]';
c2=[0 1]';
x1=[1 0;0 1];
x2=x1;

DSGK1=zeros(m,1);
DSGK2=DSGK1;
MIND=DSGK1;

u1=zeros(m,1);
u2=u1;
H1=zeros(1,n);
H2=H1;
H3=0;
H4=H3;
H5=zeros(2,2);
H6=H5;

DV=zeros(5,1);

for iteration=1:1
H1=zeros(1,n);
H2=H1;
H3=0;
H4=H3;
H5=zeros(2,2);
H6=H5;   
MIND=zeros(m,1);   
for i=1:m
DSGK1(i,1)=(det(x1)^(1/L))*((data(i,:)'-c1)')*(x1^-1)*(data(i,:)'-c1);
end

for i=1:m
DSGK2(i,1)=(det(x2)^(1/L))*((data(i,:)'-c2)')*(x2^-1)*(data(i,:)'-c2);
end
figure;
for i=1:m
    if DSGK1(i,1)>=DSGK2(i,1)
        plot(data(i,1),data(i,2),['r','*']);hold on;
    else
        plot(data(i,1),data(i,2),['b','*']);hold on;
    end
end
end
title('first iteration');

for iteration=1:6
H1=zeros(1,n);
H2=H1;
H3=0;
H4=H3;
H5=zeros(2,2);
H6=H5;   
MIND=zeros(m,1);   
for i=1:m
DSGK1(i,1)=(det(x1)^(1/L))*((data(i,:)'-c1)')*(x1^-1)*(data(i,:)'-c1);
end

for i=1:m
DSGK2(i,1)=(det(x2)^(1/L))*((data(i,:)'-c2)')*(x2^-1)*(data(i,:)'-c2);
end

for i=1:m
u1(i,1)=1/((DSGK1(i,:)/DSGK1(i,:))+(DSGK1(i,:)/DSGK2(i,:)));
u2(i,1)=1/((DSGK2(i,:)/DSGK1(i,:))+(DSGK2(i,:)/DSGK2(i,:)));
end

for i=1:m
H1(1,:)=(u1(i,:)^2)*data(i,:)+H1(1,:);
H2(1,:)=(u2(i,:)^2)*data(i,:)+H2(1,:);
H3=u1(i,1)^2+H3;
H4=u2(i,1)^2+H4;
H5=(u1(i,:)^2)*(data(i,:)'-c1)*(data(i,:)'-c1)'+H5;
H6=(u2(i,:)^2)*(data(i,:)'-c2)*(data(i,:)'-c2)'+H6;
end

for i=1:m
MIND(i,1)= min(DSGK1(i,:),DSGK2(i,:));
end

DV(iteration,1)=sum(MIND);
c1=(H1/H3)';
c2=(H2/H4)';
x1=H5/H3;
x2=H6/H4;
end

figure;
for i=1:m
    if DSGK1(i,1)>=DSGK2(i,1)
        plot(data(i,1),data(i,2),['r','*']);hold on;
    else
        plot(data(i,1),data(i,2),['b','*']);hold on;
    end
end
title('5th iteration');