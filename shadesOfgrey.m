A=[0 0.4 0.8 1;0.4 0.4 0.8 1;0.8 0.8 0.8 1;1 1 1 1];
imshow(A);
B=rand(350,350);
imshow(B)
C=rand(700,700);
imshow(C)
D=im2bw(C,0.6);
imshow(D)