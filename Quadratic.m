  %ax^2+bx+c
x=-1:0.1:3;
a=3;
b=2;
c=8;
y=x.^2;
term1=y*a;
term2=b*x;
term3=c*ones(size(term1));
f=term1+term2+term3;
plot(x,f)