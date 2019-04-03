%% 1. specify image location
currDIR = '/data/location/here/';
imageLocation.guideTubeMask = [currDIR, '/mask.nii'];
imageLocation.anatomy = [currDIR, '/anat.nii'];


%% 2. guide tube information 
% definition of guide tube threshold and whether
% greater then (hyperintense tube) or less than (hypointense tube)
guideTube.isGreaterThen = 1;
guideTube.threshold = 10;

% find center of guide tube using the mean position weighted by voxel intensity
% otherwise just use mean
guideTube.isWeightedMean = 1;

% Is a sparse guide tube mask used?
guideTube.sparseGT = 0;


%% 3. grid information
% definition of grid positions of guidetubes as defined in  
% imageLocation.guideTubeMask where numbers > 0 in mask define gridpos
% imageLocation.guideTubeMask == 1 is equal to gridpos(1)
clear gridpos
gridpos(1).positionNameAP = 'C';
gridpos(1).positionNameLM = 'C';

gridpos(2).positionNameAP = '7A';
gridpos(2).positionNameLM = 'C';

gridpos(3).positionNameAP = '7P';
gridpos(3).positionNameLM = 'C';

gridpos(4).positionNameAP = 'C';
gridpos(4).positionNameLM = '7L';

gridpos(5).positionNameAP = 'C';
gridpos(5).positionNameLM = '7M';


%% 4. check volume is in correct orientation 
% order of dimensions [Coronal Transverse Sagittal]
imageOrient.dimOrder = [1, 3, 2];
% volume flips to perform [dorsal-ventral  anterior-posterior left-right]
imageOrient.isFlipped = [1, 1, 0];

% make sure volume in correct orientation
% necessary for further calculations!
checkVolOrientation(imageLocation.anatomy, imageOrient);

%% 5. fill sparse guidtube
% If sparse guide tube (defined only by start and end point) used
% then fill line between points and dilate line using n_dilate_voxels
% else just use guidetube
if guideTube.sparseGT == 1
    n_dilate_voxels = 5; % option: setting n_dilate_voxels to 0, no dilation
    imageLocation = fill_in_guidetube(imageLocation, imageOrient, n_dilate_voxels);
end

%% 6. calculate mean trajectories and positions and draw grid volume
make_grid_image(imageLocation, imageOrient, guideTube, gridpos);

%% 7. Example find position
% allows user to get anterior-posterior, medial-lateral position
% from grid intensity of 

find_grid_pos_from_val(32);
