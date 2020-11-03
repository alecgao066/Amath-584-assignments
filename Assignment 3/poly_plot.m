clc
clear all;
close all;

x = 1.920: 0.001 :2.080;% in a row
x_size = length(x);
coeff = [1, -18, 144, -672, 2016, -4032, 5376, -4608, 2304, -512];
poly = ones(10,x_size);

for k = 9: -1: 1
    poly(k,:) = x.*poly(k+1,:);
end

y1 = coeff * poly;

poly_x = x - 2;
y2 = ones(1,x_size);
for k = 1:9
    y2 = y2.*poly_x;
end

figure;hold on; grid on;xlim([min(x),max(x)]);
plot(x, y1, 'x');
plot(x, y2, 'o');
title('Error induced by machinary float system');ylabel('y');xlabel('x')
legend('Right-hand side result','Left-hand side result')
