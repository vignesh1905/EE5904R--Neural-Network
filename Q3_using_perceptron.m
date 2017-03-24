%Preprocessing the input accordingly
info = dir('/Users/vigneshk/Desktop/NN Assignment/Homework2/group_3/train');
info(1) = [];
info(1) = [];
for i = 1:length(info)
    filename = strcat('/Users/vigneshk/Desktop/NN Assignment/Homework2/group_3/train/',info(i).name);
    I = double(imread(filename));
    V(:,i) = I(:);
    tmp = strsplit(info(i).name,{'_','.'});
    L(:,i) = str2double(tmp{2});
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


%Normalising the data
norm_train = mapminmax(train_data);
norm_val = mapminmax(val_data);


net = perceptron;
%net.trainFcn = 'traingd';
%net.performParam.normalization = 'standard';
net.performFcn = 'mse';

net = train(net,norm_train, train_label);

y_train = net(norm_train);
y_val = net(norm_val);

error_train = (y_train == train_label);
error_test = (y_val == val_label);

%Calculating the accuracy
accuracy_train =( (sum(error_train) / length(train_label))) * 100 ;
accuracy_val = ( (sum(error_test) / length(val_label))) * 100 ;

figure,plotconfusion(train_label,y_train)
figure,plotconfusion(val_label,y_val)

disp(accuracy_train)
disp(accuracy_val)