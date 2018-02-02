function coordList_GT = make_guideTube_line(sizeXYZ,b_XY,b_ZY,m_XY,m_ZY)

Y_Indices =[1 sizeXYZ(2)];


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
