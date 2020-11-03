clc;
clear all;
close all;

A1 = rand(3,2);
[recon_error1, Q_error1, R_error1] = qr_algorithm_test(A1);
recon_error1
Q_error1
R_error1

A2 = rand(6, 5);
[recon_error2, Q_error2, R_error2] = qr_algorithm_test(A2);
recon_error2
Q_error2
R_error2

A3 = rand(5,3);
A3 = [A3, sum(A3,2)];
[recon_error3, Q_error3, R_error3] = qr_algorithm_test(A3);
recon_error3
Q_error3
R_error3
