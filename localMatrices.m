function [stB,stC]=localMatrices(coord);
% function [stB,stC]=local(coord) computes local matrices stB and stC

N=coord(:)*ones(1,3)-repmat(coord,3,1);
stC=diag([norm(N([5,6],2)),norm(N([1,2],3)),norm(N([1,2],2))]);
M=diag(ones(6,1));
for k=1:4
    M(k,k+2)=1;
end
for k=1:2
    M(k,k+4)=1;
end
M=M+M';
absT=det([1,1,1;coord]);
stB=stC*N'*M*N*stC/(24*absT);