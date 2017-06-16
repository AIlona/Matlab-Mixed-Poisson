    
function p=fluxEB(element,coordinate,u,noedges,nodes2edge,edge2element)
p=zeros(3*size(element,1),2);
for j=1:size(element,1)
  signum=ones(1,3);
  signum(find(j==edge2element(diag(nodes2edge(element(j,[2 3 1]),...
  element(j,[3 1 2]))),4)))=-1;
  c=coordinate(element(j,[2 3 1]),:)-coordinate(element(j,[3 1 2]),:);
  n=[norm(c(1,:)),norm(c(2,:)),norm(c(3,:))];
  coord=coordinate(element(j,:),:)';
  N=coord(:)*ones(1,3)-repmat(coord,3,1);
  pc=reshape(N*diag(signum)*diag(n)*u(diag(nodes2edge(element(j,[2 3 1]),...
             element(j,[3 1 2]))))/det([1 1 1;coordinate(element(j,:),:)']),2,3);
  p(3*(j-1)+[1,2,3],:)=[pc(1,:)',pc(2,:)'];
end


