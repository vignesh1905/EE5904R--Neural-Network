%Preprocessing the input accordingly
info = dir('/Users/vigneshk/Desktop/NN Assignment/Homework2/group_3/train');
info(1) = [];
info(1) = [];
for j = 1:length(info)
    filename = strcat('/Users/vigneshk/Desktop/NN Assignment/Homework2/group_3/train/',info(j).name);
    I = double(imread(filename));
    V(:,j) = I(:);
    tmp = strsplit(info(j).name,{'_','.'});
    L(:,j) = str2double(tmp{2});
end

train_data = V;
train_label = L;

%Validation data
info1 = dir('/Users/vigneshk/Desktop/NN Assignment/Homework2/group_3/val');
info1(1) = [];
info1(1) = [];
for i = 1:length(info1)
    filename = strcat('/Users/vigneshk/Desktop/NN Assignment/Homework2/group_3/val/',info1(i).name);
    I1 = double(imread(filename));
    V1(:,i) = I1(:);
    tmp = strsplit(info1(i).name,{'_','.'});
    L1(:,i) = str2double(tmp{2});
end
val_data = V1;
val_label = L1;

%Standardise the input
norm_train = mapstd(train_data);
norm_val = mapstd(val_data);

x = norm_train;
t = train_label;

% Choose a Training Function

 %trainFcn = 'traingdx';  % Scaled conjugate gradient backpropagation.

% Create a Pattern Recognition Network
%hiddenLayerSize = [10,20,50,100,150,200,250];
hiddenLayerSize = 250;

for loop = 1 : length(hiddenLayerSize)
    net = patternnet(hiddenLayerSize(loop));

    %net.divideFcn = '';

    %net.performParam.normalization = 'standard';
    net.performParam.regularization = 0.15;
    %net.layers{1}.transferFcn = 'logsig';
    net.trainFcn = 'traingd';
    net.trainParam.max_fail = 20;

    % Train the Network
    [net,tr] = train(net,x,t);

    % Test the Network
    y = net(x);

    %Test on val set
    y_val = net(norm_val);

    %Accuracy Calculation
    for j = 1:length(train_label)
        if y(j) > 0.5
            y(j) = 1;
        else
            y(j) = 0;
        end
    end

    for k = 1:length(val_label)
        if y_val(k) > 0.5
            y_val(k) = 1;
        else
            y_val(k) = 0;
        end
    end

    error_train = (y == train_label);
    error_val = (y_val == val_label);

    train_accu(loop) = (((sum(error_train) / length(train_label))) * 100) ;
    val_accu(loop) = (((sum(error_val) / length(val_label))) * 100) ;

end
