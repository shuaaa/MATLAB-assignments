 a=0.01:0.1:1;
 g=0.1:0.1:1;
 for j=1:length(g)
    for i=1:length(a)
        c(i)=complement1(a(i),g(j));
    end
 hold on
 plot(a,c)
end