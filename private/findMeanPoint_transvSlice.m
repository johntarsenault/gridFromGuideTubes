function meanPoint_AP_LR = findMeanPoint_transvSlice(guideTube_3D_indices,guideTube_points_transverse_range,anat,weightedMean)

%empty matrix of mean guide tube points for all transverse slices
%rows each transverse slice containing a guidetube
%columns midpoint of all guidetube voxels

meanPoint_AP_LR = NaN(length(guideTube_points_transverse_range),length(guideTube_3D_indices),2);

%loop through transverse slice and each guide tube and find the midpoint
for i = 1:length(guideTube_points_transverse_range)
    for j = 1:length(guideTube_3D_indices)

        if weightedMean
            meanPoint_AP_LR(i,j,:) = currentMeanPoint_transvSlice_weightedMean(guideTube_3D_indices,j,guideTube_points_transverse_range(i),anat);
        else
            meanPoint_AP_LR(i,j,:) = currentMeanPoint_transvSlice(guideTube_3D_indices,j,guideTube_points_transverse_range(i));
        end

    end
end
end

function current_meanPoint_AP_LR = currentMeanPoint_transvSlice(guideTube_3D_indices,currentGuideTube,current_transverse_slice)

    %check if guidetube points at this transverse slice
    current_transv_slice_indices = find(guideTube_3D_indices{currentGuideTube}(:,2) == current_transverse_slice);
    %if points then find mean; else fill with NaN
    if length(current_transv_slice_indices)
        current_meanPoint_AP_LR = mean(guideTube_3D_indices{currentGuideTube}(current_transv_slice_indices,[1 3]),1);
    else
        current_meanPoint_AP_LR = NaN;
    end
end

function current_meanPoint_AP_LR = currentMeanPoint_transvSlice_weightedMean(guideTube_3D_indices,currentGuideTube,current_transverse_slice,anat)

    %check if guidetube points at this transverse slice
    current_transv_slice_indices = find(guideTube_3D_indices{currentGuideTube}(:,2) == current_transverse_slice);

    %if points then find mean; else fill with NaN
    if length(current_transv_slice_indices)
        current_points = guideTube_3D_indices{currentGuideTube}(current_transv_slice_indices,:);
            %if currentGuideTube==5; keyboard; end

        val_per_point = [];
        for i = 1:size(current_points,1)
            val_per_point = [val_per_point anat.vol(current_points(i,1),current_points(i,2),current_points(i,3))];
        end
        
        [current_meanPoint_AP_LR(1,1) current_meanPoint_AP_LR(1,2) ] = findPeak_XY_from_polyFitOfGuideTube(guideTube_3D_indices{currentGuideTube}(current_transv_slice_indices,[1]),...
        guideTube_3D_indices{currentGuideTube}(current_transv_slice_indices,[3]), val_per_point');

    else
        current_meanPoint_AP_LR = NaN;
    end

end