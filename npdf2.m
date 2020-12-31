x = 3:1:10;
mu=5;
si=0.2;
norm=normpdf(x,mu,si);
figure;
plot(x,norm)

x=3:1:10;
mu=6;
si=0.2;
norm=normpdf(x,mu,si);
hold on
plot(x,norm)
