function [recon_error, Q_error, R_error] = qr_algorithm_test(A)
[row_size, col_size] = size(A);
recon_error = zeros(3,1);
Q_error = zeros(3,1);
R_error = zeros(3,1);

[Q1, R1] = qr(A);
A_error_1 = A - Q1 * R1;
Q_error_1 = eye(row_size) - Q1' * Q1;
R_error_1 = tril(Q1' * A, -1);
recon_error(1,1) = sum(sum(A_error_1 .* A_error_1));
Q_error(1,1) = sum(sum(Q_error_1 .* Q_error_1));
R_error(1,1) = sum(sum(R_error_1 .* R_error_1));

[Q2, R2] = qr_modify(A);
A_error_2 = A - Q2 * R2;
Q_error_2 = eye(col_size) - Q2' * Q2;
R_error_2 = tril(Q2' * A, -1);
recon_error(2,1) = sum(sum(A_error_2 .* A_error_2));
Q_error(2,1) = sum(sum(Q_error_2 .* Q_error_2));
R_error(2,1) = sum(sum(R_error_2 .* R_error_2));

[Q3, R3] = qrfactor(A);
A_error_3 = A - Q3 * R3;
Q_error_3 = eye(row_size) - Q3' * Q3;
R_error_3 = tril(Q3' * A, -1);
recon_error(3,1) = sum(sum(A_error_3 .* A_error_3));
Q_error(3,1) = sum(sum(Q_error_3 .* Q_error_3));
R_error(3,1) = sum(sum(R_error_3 .* R_error_3));


