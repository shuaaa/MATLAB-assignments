x=-3:2:15;
mu=3;
si=2;
norm=normpdf(x,mu,si);
figure;
plot(x,norm)

hold on
x=-3:2:15;
mu=3;
mu=7;
si=1;
norm=normpdf(x,mu,si);
plot(x,norm)