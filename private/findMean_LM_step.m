function [AP_step LM_step] = findMean_LM_step(gridpos_same,gridpos,meanPoint_AP_LR)

%get all possible combinations of gridpositions on same line
gridpos_combos = nchoosek(gridpos_same,2);

%find the difference in grid distance betweeen these combinations
for i = 1:size(gridpos_combos,1)
       [grid_AvsB_positionNameAP(i) grid_AvsB_positionNameLM(i)] = findDist_gridposA_rel_gridposB(gridpos(gridpos_combos(i,1)),gridpos(gridpos_combos(i,2)));
end

%determine number of transverse slices
[num_transSlice numGridPos numPoints] = size(meanPoint_AP_LR);

imageAP_dist = [];
imageLR_dist = [];
gridDist     = [];

%loop through every transverse slice and possible grid combination
for i = 1:num_transSlice
    for j = 1:size(gridpos_combos,1)

        % if both of the grid positions of the current grid combo exist
        % calculate the AP and LR distance
        if ~isnan(meanPoint_AP_LR(i,gridpos_combos(j,1),1)) && ~isnan(meanPoint_AP_LR(i,gridpos_combos(j,2),1))
            
            current_AP_A_vs_B = meanPoint_AP_LR(i,gridpos_combos(j,1),1) - meanPoint_AP_LR(i,gridpos_combos(j,2),1);
            current_LR_A_vs_B = meanPoint_AP_LR(i,gridpos_combos(j,1),2) - meanPoint_AP_LR(i,gridpos_combos(j,2),2);

            imageAP_dist = [imageAP_dist current_AP_A_vs_B];
            imageLR_dist = [imageLR_dist current_LR_A_vs_B];
            gridDist     = [gridDist     grid_AvsB_positionNameLM(j)];
        end

    end
end

%convert image distance per AP and LM step
imageAP_dist_per_gridpoint =     imageAP_dist./gridDist;
imageLR_dist_per_gridpoint =     imageLR_dist./gridDist;


%use a weighted average (based on distance between points) to calc average
%step
weighted_by_gridDist = abs(gridDist)/sum(abs(gridDist));
weightMean_imageAP_dist_per_gridpoint = sum([imageAP_dist_per_gridpoint.* weighted_by_gridDist]);
weightMean_imageLR_dist_per_gridpoint = sum([imageLR_dist_per_gridpoint.* weighted_by_gridDist]);


AP_step = weightMean_imageAP_dist_per_gridpoint;
LM_step = weightMean_imageLR_dist_per_gridpoint;