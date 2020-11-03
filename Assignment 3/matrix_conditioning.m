clc;
clear all;
close all;

%% Question 1
m = 2:1:10;
m_size = length(m);
cond_num = zeros(m_size * (m_size + 1) / 2,1);

for i = 1:m_size
    n = 1:m(i) - 1;
    for j = 1:length(n)
        A2 = rand(m(i),n(j));
        cond_num(i * (i-1) / 2 + j,1) = cond(A2);
    end
end

% When m is fixed, increasing n causes the increase of condition number
% of A
figure(1);
grid on;
plot(n, cond_num(m_size * (m_size-1) / 2 + 1 : m_size * (m_size+1) / 2, 1),'*');
title('Condition number of A with respect to column number n');ylabel('cond(A)');xlabel('n')
legend(['cond(A), m = ', num2str(m(m_size))] );

% When n = m-1, increasing m causes the increasing tendancy of condition number
% of A
ind = ones(m_size, 1);
for k = 2:m_size
    ind(k,1) = ind(k-1,1) + m(k-1);
end
figure(2);
grid on;
plot(m, cond_num(ind, 1),'o');
title('Condition number of A with respect to row number m');ylabel('cond(A)');xlabel('m')
legend('cond(A), n = m-1');

%% Question 2
m = 5;
n = 4;
A2 = rand(m,n);
A3 = [A2,A2(:,1)];
cond_A = cond(A3);
det_A = det(A3);

%% Question 3
e = -14:1:0;
e_size = length(e);
noise_col = rand(m,1);
A2_col = A2(:,1);
cond_noise = zeros(length(e),1);

for k = 1:e_size
    A_noise = [A2,A2_col + noise_col.*10^e(k)];
    cond_noise(k,1) = cond(A_noise);
end

figure(3);
grid on;
plot(e, log(cond_noise),'x');
title('Log of condition number of A with respect to nosie e');ylabel('log(cond(A))');xlabel('e')
legend('log(cond(A))');