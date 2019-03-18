function imageLocation = fill_in_guidetube(imageLocation,imageOrient,n_voxels)

guidetube_sparse = MRIread(imageLocation.guideTubeMask);
anatomy = MRIread(imageLocation.anatomy);

guidetube_sparse.vol = reorientVol(guidetube_sparse.vol, imageOrient.dimOrder, imageOrient.isFlipped);
anatomy.vol = reorientVol(anatomy.vol, imageOrient.dimOrder, imageOrient.isFlipped);

%size of current volume
sizeXYZ = size(guidetube_sparse.vol);

%initiliaze new volume
new_vol = zeros(sizeXYZ);

%get the number of guidetubes specified
guidetube_IDX = unique(guidetube_sparse.vol);
guidetube_IDX(find(guidetube_IDX == 0)) = [];

for i = 1:numel(guidetube_IDX)
    
    %get current guide tube points
    current_points_IDX = find(guidetube_sparse.vol == guidetube_IDX(i));
    [x_current_points, y_current_points, z_current_points] = ind2sub(sizeXYZ,current_points_IDX); 
    
    %check the number of guidetube points is correct
    n_current_points = numel(current_points_IDX);
    if n_current_points ~= 2
        error('guidetubes should be marked with 2 points\nguidetube %d has %d points', i, n_current_points);
    end
    
    %fit a line between the points
    polyfit(x_current_points,z_current_points,1);
 
    [P_YX] = polyfit(y_current_points,x_current_points,1); 
    [P_YZ] = polyfit(y_current_points,z_current_points,1);
    
    %draw the line for intermediate points
    y_line = min(y_current_points):1:max(y_current_points);
    
    x_line = polyval(P_YX,y_line);
    z_line = polyval(P_YZ,y_line);

    x_line = round(x_line);
    z_line = round(z_line);
    
    if n_voxels == 0 % if n_voxels is 0 will not expand the line
       line_IDX = sub2ind(sizeXYZ,x_line,y_line,z_line);
       new_vol(line_IDX) = i;
       
    else
    %expand the size of the line
    expanded_line = surround_line_with_square(x_line,y_line,z_line,n_voxels);
    
    %write line to new volume
    for j = 1:numel(expanded_line)
        line_IDX = sub2ind(sizeXYZ,expanded_line{j}.x_line,expanded_line{j}.y_line,expanded_line{j}.z_line);
        new_vol(line_IDX) = i;
    end
    end
end

guidetube_sparse.vol = new_vol;

guidetube_sparse.vol = reverse_reorientVol(guidetube_sparse.vol, imageOrient.dimOrder, imageOrient.isFlipped);

imageLocation.guideTubeMask = [imageLocation.anatomy(1:end-4),'_guidetube_full.nii'];

MRIwrite(guidetube_sparse,imageLocation.guideTubeMask);
