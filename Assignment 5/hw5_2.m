clc;
clear all;
close all;
%% Read and do SVD decomposition
data = scan_dir ('D:/Gan/study/Applied Linear Algebra and Introductory Numerical Analysis/hw2/CroppedYale');
% Perform SVD on training set
data = data';
data = im2double(data);
mean_data = mean(data, 2);
face = data - repmat(mean_data, 1,size(data, 2));% Decentrailize
[U, S, V] = svd(face,'econ');
%% Power iteration
face_correlation = face*face';% Corelation matrix
ite = 100;
[eig_vecs,eig_val1] = power_iteration(face_correlation, ite);
error = (U(:,1) - sign(eig_val1(end))*eig_vecs(:,end))'*(U(:,1) - sign(eig_val1(end))*eig_vecs(:,end));
fprintf('error to groundtruth = %.5f', error);
figure(1)
plot(1:size(U,1), U(:,1),'ro',1:size(U,1), sign(eig_val1(end))*eig_vecs(:,end),'b*');
xlabel('Dimension'),ylabel('Eigenvector'),title('Comparision between leading eigenvector by SVD and power iteration');
%% Randomized sampling
clear face_correlation;
k = [2 5 10 100 1000];
GT = U*S*V;
error_ite = [];
figure(2)
subplot(6,1,1), plot(diag(S)/sum(diag(S)), 'r-*'),xlabel('Singular value number'),ylabel('Ratio'),title('Ground truth');
for i = 1:length(k)
    [U_r,S_r,V_r] = randomized(face, k(i));
    error_ite(i) = sum(sum((GT - U_r*S_r*V_r').*(GT - U_r*S_r*V_r')));
    subplot(6,1,i+1), plot(diag(S_r)/sum(diag(S_r)), 'r-*'),xlabel('Singular value number'),ylabel('Ratio'),title(['Ramdomized sample number = ' num2str(k(i))]);
end
sgtitle('Singular value decay comparision')
figure(3)
plot(k, error_ite, 'r-*'),xlabel('Ramdomized sample number'),ylabel('Error'),title('Reconstruction error as a function of randomized sample number');
clear GT;
function data = scan_dir (root_dir)
    data = [];
    
    if root_dir(end)~='/'
        root_dir=[root_dir,'/'];
    end
    
    fileList=dir(root_dir);  
    n=length(fileList);
    
    for i=1:n       
        if strcmp(fileList(i).name,'.')==1||strcmp(fileList(i).name,'..')==1
            continue;
        else    
            if ~fileList(i).isdir % 如果不是目录
                full_name=[root_dir,fileList(i).name];
                img = imread(full_name);
                img_column_vector = reshape(img, 1, numel(img));
                data = [data; img_column_vector];
            else
                new_data = scan_dir([root_dir,fileList(i).name]);
                data = [data;new_data];
            end
        end
    end
end
