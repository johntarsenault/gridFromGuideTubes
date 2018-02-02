function makeGridImage(anat_imageName,guideTubeMask_imageName,dimOrder,flipVals,guideTube_greaterThen,guideTube_threshold,gridpos,gridpos_same_LM,gridpos_same_AP,weightedMean)

%step 1 - %read in anatomy and guide tube
anat = MRIread(anat_imageName);
guideTubeMask = MRIread(guideTubeMask_imageName);


%step 2 - %reorient anatomy and guidetube
anat.vol = reorientVol(anat.vol,dimOrder,flipVals);
guideTubeMask.vol = reorientVol(guideTubeMask.vol,dimOrder,flipVals);
[size_X size_Y size_Z] = size(anat.vol);
sizeXYZ=[size_X size_Y size_Z];

%step 3 - %find guide tube indices at threshold
%guideTube_3D_indices{guideTube#} = matrix rows: voxels, columns: image X,Y,Z coordinates
[guideTube_2D_indices guideTube_3D_indices] = findGuideTubeIndices(guideTubeMask,anat,guideTube_threshold,guideTube_greaterThen);

guideTubeImage       = anat;
guideTubeImage.vol   = zeros(size_X,size_Y,size_Z);

for i = 1:length(guideTube_2D_indices)
            guideTubeImage.vol(guideTube_2D_indices{i}) = i;
end
MRIwrite(guideTubeImage,[anat_imageName(1:end-4),'_GT_noFlip.nii']);


%step 4 - %find range of transverse points with a guide tube 
all_guideTube_points = cell2mat(guideTube_3D_indices');
guideTube_points_transverse_range = unique(all_guideTube_points(:,2));


%step 5 - %find mean position of each guide tube at each transverse slice
meanPoint_AP_LR = findMeanPoint_transvSlice(guideTube_3D_indices,guideTube_points_transverse_range,anat,weightedMean);


%step 6 - 
%find average step size in image voxel units for movement along grid in
%AP direction
[gridAPstep.imageAPstep gridAPstep.imageLMstep] = findMean_AP_step(gridpos_same_LM,gridpos,meanPoint_AP_LR);
%LM direction
[gridLMstep.imageAPstep gridLMstep.imageLMstep] = findMean_LM_step(gridpos_same_AP,gridpos,meanPoint_AP_LR);



%%step 7 - find center based on average step size 
%**could be improved by finding a center for each trans slice
%**calculating b for each slice
[gridCenter] = findCenterPosition(gridpos,gridAPstep,gridLMstep,meanPoint_AP_LR,guideTube_points_transverse_range);

%step 8 - get average slope of all guidetubes
for i = 1:length(guideTube_3D_indices)
    [m_XY(i) m_ZY(i) b_XY(i) b_ZY(i)] = fit_guideTube_line_equation(guideTube_3D_indices{i});
end
mean_m_XY = mean(m_XY(i));
mean_m_ZY = mean(m_ZY(i));

%step 9 -load standard grid configuration
load('standGrid.mat');

%step 10 -get the trajectory of every grid position
%gridVoxels_voxValues =  2D array 
%rows =  individual voxels;  
%column 1 = 2D volume index; 
%column 2 =  value index
[gridVoxels_voxValues] = get_fullGrid_TrajCoords(standGrid,gridCenter,gridAPstep,gridLMstep,mean_m_XY,mean_m_ZY,sizeXYZ);


%step 11 -build empty grid volume
gridImage       = anat;
gridImage.vol   = zeros(size_X,size_Y,size_Z);

%step 12 -fill with grid trajectory
%each grid point has a unique value = 1:177
%also flip image back to original orientation
gridImage.vol(gridVoxels_voxValues(:,1)) = gridVoxels_voxValues(:,2);
gridImage.vol = reorientVol(gridImage.vol,dimOrder,flipVals);


%step 13 -write out grid image
MRIwrite(gridImage,[anat_imageName(1:end-4),'_gridImage.nii']);


end