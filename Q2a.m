%training set in the range of [-1, 1]
x=-1.0:0.05:1.0;
% generating training data, the desired outputs 
y=1.2*sin(3.14*x)-cos(2.4*3.14*x);

%Number of Training examples
train_num = length(x);
epochs = 1000;

% 2. Construct and configure the MLP
net = patternnet(20);
net.divideFcn = 'dividetrain'; % input for training only 
net.performParam.regularization = 0.25; % regularization strength 
net.trainFcn = 'trainlm'; % 'trainrp' 'traingdx' 
net.trainParam.epochs = epochs;

% 3. Train the network in sequential mode
for i = 1 : epochs
    display(['Epoch: ', num2str(i)])
    idx = randperm(train_num); % shuffle the input
    net = adapt(net, x(idx), y(idx));
end

%Test the MLP
xtest=-1.0:0.01:1.0; %Testing input
ytest=1.2*sin(3.14*xtest)-cos(2.4*3.14*xtest); %Testing output
net_output=sim(net,xtest);% -- where net_output is the output of the MLP 
                          %and ytest is the desired output.

% Plotting the test results
plot(xtest,ytest,'b o ');
hold on;
plot(xtest,net_output,'r +');
hold off; 
xlabel('x'),ylabel('y');
title('Sequential Mode,1 Hidden Neuron');
legend('Target Output','Output','Location','NorthWest' );