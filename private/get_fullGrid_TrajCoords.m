function [gridVoxels_voxValues] = get_fullGrid_TrajCoords(standGrid,gridCenter,gridAPstep,gridLMstep,mean_m_XY,mean_m_ZY,sizeXYZ)

%build empty list for grid image position
    image_AP_List = zeros(1,size(standGrid.full_gridpos_posNameAP,2));
    image_LM_List = zeros(1,size(standGrid.full_gridpos_posNameAP,2));

    gridposCenter.positionNameAP = 'C';
    gridposCenter.positionNameLM = 'C';

gridVoxels_voxValues = [];

%loop through every grid in the standard grid
%based on estimated step size and estimated center point determine the
%grid position at transverse = gridCenter.DV

for i=1:size(standGrid.full_gridpos_posNameAP,2)

    %get current grid name
    curr_gridpos.positionNameAP = standGrid.full_gridpos_posNameAP{i};
    curr_gridpos.positionNameLM = standGrid.full_gridpos_posNameLM{i};

    %tell relative positions on grid
    [grid_vs_center_positionNameAP grid_vs_center_positionNameLM] = findDist_gridposA_rel_gridposB(curr_gridpos,gridposCenter);

    %use relative position estimated step size and estimated center point 
    %to determine grid position
    currImage_AP = gridCenter.AP + grid_vs_center_positionNameAP*gridAPstep.imageAPstep + grid_vs_center_positionNameLM*gridLMstep.imageAPstep;
    currImage_LM = gridCenter.LM + grid_vs_center_positionNameLM*gridLMstep.imageLMstep + grid_vs_center_positionNameAP*gridAPstep.imageLMstep;
    image_AP_List(i) = currImage_AP;
    image_LM_List(i) = currImage_LM;

    %calculate b of (y=mx + b) using current grid point
    b_XY_List(i) = gridCenter.DV - mean_m_XY*image_AP_List(i);
    b_ZY_List(i) = gridCenter.DV - mean_m_ZY*image_LM_List(i);

    curr_coordList_3D_GT = make_guideTube_line(sizeXYZ,b_XY_List(i),b_ZY_List(i),mean_m_XY,mean_m_ZY);
    curr_coordList_2D_GT = sub2ind([sizeXYZ(1) sizeXYZ(2) sizeXYZ(3)],curr_coordList_3D_GT(:,1),curr_coordList_3D_GT(:,2),curr_coordList_3D_GT(:,3));
    
    curr_gridVoxels_voxValues = [curr_coordList_2D_GT ones(size(curr_coordList_2D_GT,1),1)*i];
    gridVoxels_voxValues = [gridVoxels_voxValues; curr_gridVoxels_voxValues];
end
