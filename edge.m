function [nodes2element,nodes2edge,noedges,edge2element]=...
    edge(element,coordinates);



nodes2element=zeros(length(coordinates),length(coordinates));
% nodes2element is a matrix that describes elements in terms of edges
% node2element(i,j)=number of element, if (i,j)-edge belongs to this
% element
% node2element(i,j)=0 otherwise

% each row in 'element' consists of its vertices, 
% thus for each i-th element, its edges are :
% {element(i,1),element(i,2)}
% {element(i,2),element(i,3)}
% {element(i,3),element(i,1)}
% note that {i,j} and {j,i} describe the same edge up to orientation
% and therefore these edges belong to adjacent triangles

for k=1:length(element)
    nodes2element(element(k,1),element(k,2))=k;
    nodes2element(element(k,2),element(k,3))=k;
    nodes2element(element(k,3),element(k,1))=k;
end



nodes2edge=zeros(length(coordinates),length(coordinates));
% nodes2edge is a matrix that describes edges in terms of nodes
% node2eledge(i,j)=number of edge, if conv(i,j) = edge 
% node2eledge(i,j)=0 otherwise

% in this case we don't consider orientation of the edges, thus
% nodes2edge is symmetric matrix

B=nodes2element+nodes2element'; 
[I,J]=find(triu(B));

for k=1:length(I)
    nodes2edge(I(k,1),J(k,1))=k;
end
nodes2edge=nodes2edge+nodes2edge';
noedges=size(I,1);


edge2element=zeros(noedges,4);
% nodes2element is a matrix that describes edges in terms of nodes and
% triangles 
% each row of the matrix corresponds to one edge and
% first entry of this row is the initial node of edge
% second entry is the end node of the edge
% third entry is number the triangle that has this edge wrt positive
% orientation
% fourth entry is number the triangle that has this edge wrt negative
% orientation 



for m=1:length(element)
    for k=1:3
        initial_node=element(m,k);
        if k<3
            end_node=element(m,k+1);
        else
            end_node=element(m,1);
        end
        p=nodes2edge(element(m,k),element(m,rem(k,3)+1));
        if edge2element(p,1)==0
            edge2element(p,:)=[initial_node end_node ...
            nodes2element(initial_node,end_node) ...
            nodes2element(end_node,initial_node)];
        end
    end
end

