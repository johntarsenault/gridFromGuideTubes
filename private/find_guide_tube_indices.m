function [guideTube_2D_indices, guideTube_3D_indices] = find_guide_tube_indices(guideTubeMask, anat, guideTube_threshold, guideTube_greaterThen)

%get size of volume space
[size_X, size_Y, size_Z] = size(anat.vol);

%determine number of guide tubes
guideTubeMask_vals = unique(guideTubeMask.vol);
guideTubeMask_vals(find(guideTubeMask_vals == 0)) = [];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%list voxels for each guidetube
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
guideTube_2D_indices = {};
guideTube_3D_indices = {};

%loop through guide tubes
for i = 1:length(guideTubeMask_vals)
    
    %find guide tube  voxels
    guideTubeMask_indices{i} = find(guideTubeMask.vol == guideTubeMask_vals(i));
    
    %find guide tube voxels above threshold (2D and 3D)
    if guideTube_greaterThen
        guideTube_2D_indices{i} = intersect(find(anat.vol > guideTube_threshold), guideTubeMask_indices{i});
    else
        guideTube_2D_indices{i} = intersect(find(anat.vol < guideTube_threshold), guideTubeMask_indices{i});
    end
    
    %convert 1D indices to 3D subscripts
    [curr_targ_I, curr_targ_J, curr_targ_K] = ind2sub([size_X, size_Y, size_Z], guideTube_2D_indices{i});
    guideTube_3D_indices{i} = [curr_targ_I, curr_targ_J, curr_targ_K];
    
end