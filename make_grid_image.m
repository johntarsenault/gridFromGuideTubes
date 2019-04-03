function gridInfo = make_grid_image(imageLocation, imageOrient, guideTube, gridpos)

%% step 1A. read in anatomy and guide tube
anat = MRIread(imageLocation.anatomy);
guideTubeMask = MRIread(imageLocation.guideTubeMask);


%% step 1B. ensure that image is isotropic
if ~isequal(round(anat.volres(1:end-1),5), round(anat.volres(2:end),5))
    error('images need to be isotropic');
end


%% step 1C. get anatomy filename parts to write files later
[anat_dir, anat_filename, anat_ext] = fileparts(imageLocation.anatomy);


%% step 2. reorient anatomy and guidetube
anat.vol = reorient_vol(anat.vol, imageOrient.dimOrder, imageOrient.isFlipped);
guideTubeMask.vol = reorient_vol(guideTubeMask.vol, imageOrient.dimOrder, imageOrient.isFlipped);
[size_X, size_Y, size_Z] = size(anat.vol);
sizeXYZ = [size_X, size_Y, size_Z];


%% step 3. find guide tube indices at threshold
%guideTube_3D_indices{guideTube#} = matrix rows: voxels, columns: image X,Y,Z coordinates
[guideTube_2D_indices, guideTube_3D_indices] = find_guide_tube_indices(guideTubeMask, anat, guideTube.threshold, guideTube.isGreaterThen);

guideTubeImage = anat;
guideTubeImage.vol = zeros(size_X, size_Y, size_Z);
for i = 1:length(guideTube_2D_indices)
    guideTubeImage.vol(guideTube_2D_indices{i}) = i;
end

guideTubeImage.vol = reverse_reorient_vol(guideTubeImage.vol, imageOrient.dimOrder, imageOrient.isFlipped);

% make grid dir if it doesn't exist
if ~exist(fullfile(anat_dir, 'grid'))
    mkdir(fullfile(anat_dir, 'grid'));
end
new_guideTubeImage_name = fullfile(anat_dir, 'grid', [anat_filename, '_GT.nii']);
MRIwrite(guideTubeImage, new_guideTubeImage_name);


%% step 4. find range of transverse points with a guide tube
all_guideTube_points = cell2mat(guideTube_3D_indices');
guideTube_points_transverse_range = unique(all_guideTube_points(:, 2));


%% step 5A. find mean position of each guide tube at each transverse slice
meanPoint_AP_LR = findMeanPoint_transvSlice(guideTube_3D_indices, guideTube_points_transverse_range, anat, guideTube.isWeightedMean);


%% step 5B. save positions to a .avi file
plot_guidetube_position(guideTube_points_transverse_range, meanPoint_AP_LR, anat, imageLocation)


%% step 6. find average step size in image voxel units for movement along grid in

% get grid poistions along the LM and AP axis
[gridpos_same_LM, gridpos_same_AP] = find_gridPositionsOnSameLine(gridpos);

%AP direction
[gridAPstep.imageAPstep, gridAPstep.imageLMstep] = findMean_AP_step(gridpos_same_LM, gridpos, meanPoint_AP_LR);
%LM direction
[gridLMstep.imageAPstep, gridLMstep.imageLMstep] = findMean_LM_step(gridpos_same_AP, gridpos, meanPoint_AP_LR);


%% step 7. find center based on average step size
%**could be improved by finding a center for each trans slice
%**calculating b for each slice
[gridCenter] = findCenterPosition(gridpos, gridAPstep, gridLMstep, meanPoint_AP_LR, guideTube_points_transverse_range);


%% step 7b.create new guide tube 3D indicies cell array passed on the mean
% position calculated in step 5
clear new_guideTube_3D_indices
for i = 1:size(meanPoint_AP_LR, 2)
    new_guideTube_3D_indices{i} = [meanPoint_AP_LR(:, i, 1), guideTube_points_transverse_range, meanPoint_AP_LR(:, i, 2)];
    new_guideTube_3D_indices{i}(isnan(new_guideTube_3D_indices{i}(:, 1)), :) = [];
end


%% step 8. get average slope of all guidetubes
for i = 1:length(guideTube_3D_indices)
    [m_XY(i), m_ZY(i), b_XY(i), b_ZY(i)] = fit_guideTube_line_equation(new_guideTube_3D_indices{i});
end
mean_m_XY = mean(m_XY);
mean_m_ZY = mean(m_ZY);


%% step 9A. load standard grid configuration
load('standGrid.mat');


%% step 9B. make/save gridInfo structure
gridInfo.gridAPstep = gridAPstep;
gridInfo.gridLMstep = gridLMstep;
gridInfo.gridCenter = gridCenter;
gridInfo.m_XY = mean_m_XY;
gridInfo.m_ZY = mean_m_ZY;

mat_filename = fullfile(anat_dir, 'grid', [anat_filename, '_grid_info.mat']);
save(mat_filename, 'gridInfo');


%% step 10. get the trajectory of every grid position
% gridVoxels_voxValues =  2D array
% rows =  individual voxels;
% column 1 = 2D volume index;
% column 2 = value index
[gridVoxels_voxValues] = get_fullGrid_TrajCoords(standGrid, gridCenter, gridAPstep, gridLMstep, mean_m_XY, mean_m_ZY, sizeXYZ);


%% step 11. build empty grid volume
gridImage = anat;
gridImage.vol = zeros(size_X, size_Y, size_Z);


%% step 12. fill with grid trajectory
%each grid point has a unique value = 1:177
%also flip image back to original orientation
gridImage.vol(gridVoxels_voxValues(:, 1)) = gridVoxels_voxValues(:, 2);
gridImage.vol = reverse_reorientVol(gridImage.vol, imageOrient.dimOrder, imageOrient.isFlipped);


%% step 13. write out grid image
new_gridImage_name = fullfile(anat_dir, 'grid', [anat_filename, '_gridImage.nii']);
MRIwrite(gridImage, new_gridImage_name);


end