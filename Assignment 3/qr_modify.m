function [Q, R] = qr_modify(A)
Q = [];
% q1
v = A(:,1);
q = v./norm(v);
Q = [Q, q];

[row_size, col_size] = size(A);
% get qi by projectors
for i = 2:col_size
    v = (eye(row_size) - Q*Q') * A(:,i);
    q = v./norm(v);
    Q = [Q, q];
end

R = triu(Q' * A);
end
