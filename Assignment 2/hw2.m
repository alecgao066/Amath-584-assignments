clc;
clear all;
close all;
%% Question 1
data = scan_dir ('D:/Gan/study/Applied Linear Algebra and Introductory Numerical Analysis/hw2/CroppedYale');
% Perform SVD on training set
data = data';
data = im2double(data);
mean_data = mean(data, 2);
face = data - repmat(mean_data, 1,size(data, 2));% Decentrailize
[U, S, V] = svd(face,'econ');

%% Question 2
% Plot the first 4 reshaped column of U
[~, index] = sort(diag(S), 'descend');
figure(1)
sgtitle('Plot the first 4 reshaped column of U')
subplot(2,2,1), facel = reshape(U(:, index(1)), 192, 168);
pcolor(flipud(facel)), shading interp, colormap(gray), set(gca,'xtick',[],'ytick',[]);
title('The 1st reshaped column')
subplot(2,2,2), facel = reshape(U(:, index(2)), 192, 168);
pcolor(flipud(facel)), shading interp, colormap(gray), set(gca,'xtick',[],'ytick',[]);
title('The 2nd reshaped column')
subplot(2,2,3), facel = reshape(U(:, index(3)), 192, 168);
pcolor(flipud(facel)), shading interp, colormap(gray), set(gca,'xtick',[],'ytick',[]);
title('The 3rd reshaped column')
subplot(2,2,4), facel = reshape(U(:, index(4)), 192, 168);
pcolor(flipud(facel)), shading interp, colormap(gray), set(gca,'xtick',[],'ytick',[]);
title('The 4th reshaped column')

%% Question 3
% Singular value spectrum
vec_S = diag(S);
vec_S_indep = vec_S(find(vec_S > 1e-5));
figure(2)
sgtitle('Singular value spectrum of cropped data')
subplot(1,1,1), semilogy(vec_S_indep,'ko','Linewidth',[2])
set(gca,'Fontsize',[14])
% Modes needed for good construction
val = 0.95;
modes_sum = vec_S_indep'*vec_S_indep;
for i= 1:length(vec_S_indep)
    good_cons_modes_sum = vec_S_indep(1:i)'*vec_S_indep(1:i);
    if good_cons_modes_sum/modes_sum > val
        good_cons_modes_num = i;
        break;
    end
end

%% Question 4
% Singular value decay of uncropped data
uncropped_data = scan_dir ('D:/Gan/study/Applied Linear Algebra and Introductory Numerical Analysis/hw2/yalefaces');
uncropped_data = uncropped_data';
uncropped_data = im2double(uncropped_data);
uncropped_mean_data = mean(uncropped_data, 2);
uncropped_face = uncropped_data - repmat(uncropped_mean_data, 1, size(uncropped_data, 2));
[U2, S2, ~] = svd(uncropped_face,'econ');
figure(3)
vec_S2 = diag(S2);
vec_S2_indep = vec_S2(find(vec_S2 > 1e-5));
sgtitle('Singular value spectrum of uncropped data')
subplot(1,1,1), semilogy(diag(vec_S2_indep),'ko','Linewidth',[2])
set(gca,'Fontsize',[14])
%% Cropped reconstruction
% Average
ave_cropped = [];
for i = 1:38
    ave_cropped = [ave_cropped, mean(data(:,i*1:i*64), 2)];
end
% Projection
proj_ave_cropped = [];
for i = 1:38
    proj_ave_cropped = [proj_ave_cropped, U(:,1:good_cons_modes_num)'*ave_cropped(:,i)];
end
% Reconstruction
recons_ave_cropped = [];
for i = 1:38
    recons_ave_cropped = [recons_ave_cropped, U(:,1:good_cons_modes_num)*proj_ave_cropped(:,i)];
end
% Validation
vec_ave_cropped = reshape(ave_cropped, [numel(ave_cropped), 1]);
vec_recons_ave_cropped = reshape(recons_ave_cropped, [numel(recons_ave_cropped), 1]);
error = (vec_recons_ave_cropped - vec_ave_cropped)' * (vec_recons_ave_cropped - vec_ave_cropped);
error_rate = error/(vec_ave_cropped' * vec_ave_cropped);

%% Uncropped reconstruction
% Good construction mode
val2 = 0.95;
modes_sum2 = vec_S2_indep'*vec_S2_indep;
for i= 1:length(vec_S2_indep)
    good_cons_modes_sum2 = vec_S2_indep(1:i)'*vec_S2_indep(1:i);
    if good_cons_modes_sum2/modes_sum2 > val2
        good_cons_modes_num2 = i;
        break;
    end
end
% Average
ave_cropped2 = [];
for i = 1:15
    ave_cropped2 = [ave_cropped2, mean(uncropped_data(:,i*1:i*11), 2)];
end
% Projection
proj_ave_cropped2 = [];
for i = 1:15
    proj_ave_cropped2 = [proj_ave_cropped2, U2(:,1:good_cons_modes_num2)'*ave_cropped2(:,i)];
end
% Reconstruction
recons_ave_cropped2 = [];
for i = 1:15
    recons_ave_cropped2 = [recons_ave_cropped2, U2(:,1:good_cons_modes_num2)*proj_ave_cropped2(:,i)];
end
% Validation
vec_ave_cropped2 = reshape(ave_cropped2, [numel(ave_cropped2), 1]);
vec_recons_ave_cropped2 = reshape(recons_ave_cropped2, [numel(recons_ave_cropped2), 1]);
error2 = (vec_recons_ave_cropped2 - vec_ave_cropped2)' * (vec_recons_ave_cropped2 - vec_ave_cropped2);
error_rate2 = error2/(vec_ave_cropped2' * vec_ave_cropped2);

%%
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



