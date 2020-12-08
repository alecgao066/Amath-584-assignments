function [v, lamda] = power_iteration(A, ite)
v(:,1) = randn(size(A,1),1);
lamda(1) = v'*A*v;
for k = 1:ite
    w = A*v(:,k);
    v(:,k+1) = w/norm(w);
    lamda(k+1) = v(:,k+1)'*A*v(:,k+1);
end