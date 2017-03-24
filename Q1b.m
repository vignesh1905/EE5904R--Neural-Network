% Input
min = 0;
max = 0.5;
i = 1;
x(i) = (max - min) .* rand(1) + min;
y(i) = (max - min) .* rand(1) + min;

%Function
f(i) = ((1-x(i)).^2 + (100*(y(i) - x(i).^2).^2));

%Using Newtons method
while f(i) > 1e-6
    dfx(i) = (2*x(i))- 2 -(400 * (x(i) * y(i))) + (400 * (x(i).^3));
    dfy(i) = (200 * y(i)) - (200 * (x(i).^ 2));
    dfx2(i) = (1200 * x(i)^2) + 2 - (400 * y(i));
    dfxy(i) = (-400 * x(i));
    dfy2(i) = 200;
    dfyx(i) = (-400 * x(i));
    H = [dfx2(i) dfxy(i);dfyx(i) dfy2(i)];
    w = [x(i);y(i)];
    E = [dfx(i);dfy(i)];
    i = i + 1 ;
    delw = w - ((pinv(H)) * E);
    x(i) = delw(1);
    y(i) = delw(2);
    f(i) = ((1-x(i)).^2 + (100*(y(i) - x(i).^2).^2));
end

%Plot the output
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
figure
plot(1:i, f ,'g');
title('Trajectory of the function');
xlabel('Iteration');
ylabel('Function value');
