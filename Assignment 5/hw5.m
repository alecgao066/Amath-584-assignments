%% Symmetric matrix
clc;
clear all;
close all;

m = 10;
A = randn(m,m);
%make A symmetric
A = A'+A; 
[P,D] = eig(A);
ite = 30;
% Power iteration
[~,lamda_p] = power_iteration(A, ite);
mag_D = abs(diag(D));
ind_max = find(mag_D == max(mag_D));
figure(1)
res_p = lamda_p - ones(1,ite+1).*D(ind_max,ind_max);
plot(1:ite+1, res_p,'r-*');
xlabel('iteration')
ylabel('resolution')
title('Accuracy of power iteration')
% Rayleigh Quotient
ini_v = randn(m,1);
eig_vec = [];
lamda_r = [];
for k=1:m
    [V,lamda] = rayleigh_quotient_iteration(A, ite, ini_v);
    eig_vec(:,k) = V(:,end);
    lamda_r(k,:) = lamda; 
    while k~=m
        ini_v0 = randn(m,1);
        ini_v = ini_v0 - eig_vec*eig_vec'*ini_v0;
        if norm(ini_v) > 1e-2 
            break;
        end
    end
end
[~, ind] = sort(lamda_r(:,end), 'ascend');
res_r = lamda_r(ind,:) - repmat(diag(D),1,ite+1);
figure(2)
for k = 1:m
    subplot(2,5,k), plot(1:ite+1, res_r(k,:),'r-*')
    xlabel('iteration')
    ylabel('resolution')
end
sgtitle('Accuracy of Rayleigh Quotient iteration')
%%
A2 = randn(m,m);
[P2,D2] = eig(A2);
ite2 = 100;
% Power iteration
[~,lamda_p2] = power_iteration(A2, ite2);
mag_D2 = abs(diag(D2));
ind_max2 = find(mag_D2 == max(mag_D2));
figure(3)
res_p2 = abs(lamda_p2 - ones(1,ite2+1).*D2(ind_max2,ind_max2));
plot(1:ite2+1, res_p2,'r-*');
xlabel('iteration')
ylabel('resolution')
title('Accuracy of power iteration')
%% Rayleigh Quotient
ini_v2 = randn(m,1);
eig_vec2 = [];
lamda_r2 = [];
for k=1:m
    [V2,lamda2] = rayleigh_quotient_iteration(A2, ite2, ini_v2);
    eig_vec2(:,k) = V2(:,end);
    lamda_r2(k,:) = lamda2; 
    while k~=m
        ini_v02 = randn(m,1);
        ini_v2 = ini_v02 - eig_vec2*eig_vec2'*ini_v02;
        if norm(ini_v2) > 1e-2 
            break;
        end
    end
end
[~, ind2] = sort(lamda_r2(:,end), 'ascend');
res_r2 = abs(lamda_r2(ind,:) - repmat(diag(D2),1,ite2+1));
figure(2)
for k = 1:m
    subplot(2,5,k), plot(1:ite2+1, res_r2(k,:),'r-*')
    xlabel('iteration')
    ylabel('resolution')
end
sgtitle('Accuracy of Rayleigh Quotient iteration')

