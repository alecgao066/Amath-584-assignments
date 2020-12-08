function [v, lamda] = rayleigh_quotient_iteration(A, ite,v)
%v(:,1) = randn(size(A,1),1);
lamda(1) = v'*A*v;
for k = 1:ite
    w = (A-lamda(k)*eye(size(A,1)))\v(:,k);
    v(:,k+1) = w/norm(w);
    lamda(k+1) = v(:,k+1)'*A*v(:,k+1);
end