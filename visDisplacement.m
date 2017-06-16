% visualization of displacement

function visDisplacement(element,coordinate,u)
hold on
for j=1:size(element,1)
    trisurf([1 2 3],coordinate(element(j,:),1),coordinate(element(j,:),2),ones(3,1)*u(j+16)');
end    
view(-60,50);
 
