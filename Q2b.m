%training set in the range of [-1, 1]
x=-1.0:0.05:1.0;
% generating training data, the desired outputs
y=1.2*sin(3.14*x)-cos(2.4*3.14*x);
t = y;

% Choose a Training Function
trainFcn = 'trainlm';  % Levenberg-Marquardt backpropagation.

% Create a Fitting Network
hiddenLayerSize = [1,2,3,4,5,6,7,10,20,50,100];
count = 1;

for j = 1:length(hiddenLayerSize)

    net = fitnet(hiddenLayerSize(j),trainFcn);

    % Train the Network
    [net,tr] = train(net,x,t);

    %Test the MLP
    xtest=-1.0:0.01:1.0; %Testing input
    ytest=1.2*sin(3.14*xtest)-cos(2.4*3.14*xtest); %Testing output
    net_output=net(xtest);% -- where net_output is the output of the MLP
                              %and ytest is the desired output.
    test_value1  = -3;
    result_value1(count) = net(test_value1);

    test_value2 = 3;
    result_value2(count) = net(test_value2);

    % Plotting the test results
    figure;
    plot(xtest,ytest,'c * ');
    hold on;
    plot(xtest,net_output,'r +');
    hold off;
    xlabel('x'),ylabel('y');
    title(['Batch Mode: TrainBr ' ' ' num2str(hiddenLayerSize(j)) ' ' 'Hidden Neuron']);
    legend('Target Output','Output','Location','NorthWest' );
    count = count + 1 ;
end
