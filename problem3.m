clear;
x=load('TwoSquares.dat','r');
sigmasqr=2;
epsilon=1.5;
figure;
plot(x(:,1),x(:,2),'.');
title('original figure');
[a,b]=size(x);
W=zeros(a,a);
D=zeros(a,a);
L=zeros(a,a);
for i=1:a
    for j=1:a
        if (norm(x(i,:)-x(j,:)))<epsilon
            W(i,j)=exp(-(norm(x(i,:)-x(j,:)))*(norm(x(i,:)-x(j,:)))/(2*sigmasqr));
        else W(i,j)=0;
        end
    end
end
for i=1:a
    D(i,i)=sum(W(i,:));
end
L=D-W;
sqrtD=D^(-1/2);

[V,E]=eig(L,D);
figure;
plot(E,['b','.']);
grid on;
title('eigenvalue E');
[vector omega]=eigs(L,D,2,'sm');

y=sqrtD*vector;
figure;
plot(y,['b','.']);
grid on;
title('eigenvector y corresponding to the second smallest eigenvalue');
C=kmeans(y',2);
figure;
plot(C);
title('kmeans y');

C1=kmeans(vector',2);
figure;
for i=1:a
    if C1(1,i)==1
    plot(x(i,1),x(i,2),['r','.']);
    hold on;
    else 
    plot(x(i,1),x(i,2),['b','.']);
    hold on;
    end
end
title('classfied data samples');