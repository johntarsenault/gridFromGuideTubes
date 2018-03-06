function [peak_x peak_y] = findPeak_XY_from_polyFitOfGuideTube(x_coord,y_coord,guideTubeIntensity)
% x_coord = guideTube_3D_indices{currentGuideTube}(current_transv_slice_indices,[1]);
% y_coord = guideTube_3D_indices{currentGuideTube}(current_transv_slice_indices,[3]);
% guideTubeIntensity = val_per_point';

%get mean x and y coordinate
mean_x_coord = mean(x_coord);
mean_y_coord = mean(y_coord);

if numel(x_coord) <5
    peak_x = mean(x_coord);
    peak_y = mean(y_coord);
    
else
%remove mean from x and y coordinate
x_coord = x_coord - mean_x_coord;
y_coord = y_coord - mean_y_coord;

if numel(x_coord) < 9
%fit data with poly23
sf = fit([x_coord, y_coord],guideTubeIntensity,'lowess');
else
    sf = fit([x_coord, y_coord],guideTubeIntensity,'poly23');
end
%get all values in the grid of possible values 10th of voxel sampling
x_range = [min(x_coord):.1:max(x_coord)]';
y_range = [min(y_coord):.1:max(y_coord)]';
[mesh_x_range, mesh_y_range] =  meshgrid(x_range,y_range);
mesh_x_range = reshape(mesh_x_range,1,numel(mesh_x_range));
mesh_y_range = reshape(mesh_y_range,1,numel(mesh_y_range));

%get guide tube intensity  based on the fit
guideTubeIntensityFit_range = sf(mesh_x_range,mesh_y_range);

%find max guide tube intensity based on the fit
[maxVal maxIndex ] = max(guideTubeIntensityFit_range);

%determine x y coordinates of max guide tube value
peak_x = mesh_x_range(maxIndex) + mean_x_coord;
peak_y = mesh_y_range(maxIndex) + mean_y_coord;
end

%plot current guide tube 
%plot(sf,[x_coord, y_coord],guideTubeIntensity);