% visualization of flux components

function visFlux(element,coordinate,p);
hold on
for j=1:size(element,1)
     subplot(2,1,1)
     trisurf([1 2 3],coordinate(element(j,:),1),coordinate(element(j,:),2),p(3*(j-1)+[1,2,3],1),'facecolor','interp');
     title('p_x');
     view(-60,50);
     hold on
     subplot(2,1,2)
     trisurf([1 2 3],coordinate(element(j,:),1),coordinate(element(j,:),2),p(3*(j-1)+[1,2,3],2),'facecolor','interp');
     title('p_y');
     view(-60,50);
     hold on
 end    