
function outv=myvar(P)
mysum1=0;
for i=1:length(P)
    mysum1=mysum1+P(i);
end
outv=mysum1/length(P)
mysum2=0;
for i =1:length(P)
    mysum2=mysum2+(P(i)-outv)^2;
end
outv=mysum2/length(P);
end