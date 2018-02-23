function coordList_GT = fit_guideTube_line(guideTube_3D_indices,Y_Indices,sizeXYZ)

%linear fit of guide tube voxels
[P_XY] = polyfit(guideTube_3D_indices(:,1),guideTube_3D_indices(:,2),1); 
[P_ZY] = polyfit(guideTube_3D_indices(:,3),guideTube_3D_indices(:,2),1);
 
m_XY  = P_XY(1);
m_ZY  = P_ZY(1);

b_XY = P_XY(2);
b_ZY = P_ZY(2);
   
%extend linear fit along chosen Y_Indices
coordList_GT = [];
for i = Y_Indices(1): Y_Indices(2)
    newX = (i-b_XY)/m_XY;
    newZ = (i-b_ZY)/m_ZY;
    coordList_GT = [coordList_GT; newX i newZ];
end

%remove coordinates outside the original volume space 
coordList_GT = round(coordList_GT);
for i = 1:3
coordList_GT(union(find(coordList_GT(:,i)<1),find(coordList_GT(:,i)>sizeXYZ(i))),:) = [];
end

