alpha=2/3;
acut
[a1,b1]=acut(2,4,8,alpha)
%complement
[a,b]=cofi([a1,b1])

X=[-inf, inf];
[a2,b2]=acutleft(2,4,alpha,X)
[a2,b2]=acutright(4,8,alpha,X)
