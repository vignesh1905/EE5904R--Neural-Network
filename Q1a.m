%Input
min = 0;
max = 0.5;
i = 1;
x(i) = (max - min) .* rand(1) + min;
y(i) = (max - min) .* rand(1) + min;

%Rosenbrock Function
f(i) = ((1-x(i)).^2 + (100*(y(i) - x(i).^2).^2));
eta = 0.2;

%Using Steepest Gradient descent
while f(i) > 1e-6
    dfx(i) = (2*x(i))- 2 -(400 * (x(i) * y(i))) + (400 * (x(i).^3));
    dfy(i) = (200 * y(i)) - (200 * (x(i).^ 2));
    i = i + 1 ;
    x(i) = x(i-1) - (eta * dfx(i-1));
    y(i) = y(i-1) - (eta * dfy(i-1));
    f(i) = ((1-x(i)).^2 + (100*(y(i) - x(i).^2).^2));
end

%Plotting 
plot(x,y,'b');
title('X vs Y trajectory');
xlabel('X');
ylabel('Y');
figure;
plot(x,'r');
hold on;
plot(y,'b');
hold off;
title('X and Y trajectories');
xlabel('Iteration');
ylabel('Values of X and Y');
figure;
plot(1:i, f ,'m');
title('Trajectory of the function');
xlabel('Iteration');
ylabel('Function value');
