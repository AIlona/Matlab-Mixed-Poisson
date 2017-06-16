
% mesh: 
load coordinate.dat;
load element.dat;
[nodes2element,nodes2edge,noedges,edge2element]=edge(element,coordinate);


% Assemble matrices B and C  from local matrices stB and stC  

B=zeros(noedges,noedges);
C=zeros(noedges,size(element,1)); 
for j=1:size(element,1)
    coord=coordinate(element(j,:),:)';
    % edges of each element:
     I(1,1)=nodes2edge(element(j,2),element(j,3));
     I(2,1)=nodes2edge(element(j,3),element(j,1));
     I(3,1)=nodes2edge(element(j,1),element(j,2));
     % signs of edges:
    signum=ones(1,3);
    signum(find(j==edge2element(I,4)))=-1;
    % assembling global matrices:
    [stB,stC]=localMatrices(coord);
    B(I,I)=B(I,I)+diag(signum)*stB*diag(signum);
    C(I,j)=diag(signum)*diag(stC);
end

% Global stiffness matrix A
A=zeros(noedges+size(element,1),noedges+size(element,1));
A=[B,C;C',zeros(size(C,2),size(C,2))];
   
% Volume force 
b = zeros(noedges+size(element ,1),1);
for j = 1:size(element ,1)    
  absT=0.5*det([1,1,1; coordinate(element(j,:),:)']);
  b(noedges+j)= -absT *  f(sum(coordinate(element(j,:),:))/3);
end

% Boundary conditions
% each row of matrix exterior contains initial and end nodes 
% of boundary edges
exteriror=edge2element(find (edge2element(:,4)==0),[1 2]);
for k = 1:size(exteriror,1)
  b(nodes2edge(exteriror(k,1),exteriror(k,2)))=...
    norm(coordinate(exteriror(k,1),:)-...
    coordinate(exteriror(k,2),:))*u_D(sum(coordinate(exteriror(k,:),:))/2);
end   
% Solution
    x = A\b;


%Visualization
figure(1)
visDisplacement(element,coordinate,x);
p=fluxEB(element,coordinate,x,noedges,nodes2edge,edge2element);
figure(2)
visFlux(element,coordinate,p);
            





