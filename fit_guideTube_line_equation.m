function [m_XY m_ZY b_XY b_ZY] = fit_guideTube_line_equation(guideTube_3D_indices)

%linear fit of guide tube voxels
[P_XY] = polyfit(guideTube_3D_indices(:,1),guideTube_3D_indices(:,2),1); 
[P_ZY] = polyfit(guideTube_3D_indices(:,3),guideTube_3D_indices(:,2),1);
 
m_XY  = P_XY(1);
m_ZY  = P_ZY(1);

b_XY = P_XY(2);
b_ZY = P_ZY(2);
  
 