X =[0 0 2 2 1;0 1 1 0 10]';
size(X);

Numerator =(X-repmat(mean(X,1),1))
Denominator=repmat(std(X),size(X,1),1)

Sik=Numerator/Denominator


