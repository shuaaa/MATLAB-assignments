X=[0 0 2 2 1;0 1 1 0 10]  

W=X';
mindata = mean(W);
maxdata = max(W);
normalised = (W-mindata)/(maxdata - mindata)

