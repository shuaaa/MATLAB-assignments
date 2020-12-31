
X =[0 0 2 2 1;0 1 1 0 10]';
mindata = min(X);
maxdata = max(X);

minmax=bsxfun(@rdivide, bsxfun(@minus,X,mindata),maxdata-mindata)










