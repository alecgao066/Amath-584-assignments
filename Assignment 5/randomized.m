function [U_r,S_r,V_r] = randomized(A, ite)
col_num = size(A,2);
Omega = randn(col_num, ite);

Y = A*Omega;

[Q, ~] = qr(Y,0);

B = Q'*A;

[U, S_r, V_r] = svd(B,'econ');
U_r = Q*U;