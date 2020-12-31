%A=zeros(rows,columns,colour combo)
A=zeros(750,750,3);
imshow(A);

A=ones(450,450,3);
imshow(A)
A(:, :, 1)=130/255;
A(:, :, 2)=17/255;
A(:, :, 3)=120/255;
imshow(A)