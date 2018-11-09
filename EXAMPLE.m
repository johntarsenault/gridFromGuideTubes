%% input parameters %%
currDIR = '/data/fmri_monkey_03/PROJECT/Marina/Wells_VVInjection/st04_secondHEM';
sparseGT = 0;

%specify location 
imageLocation.guideTubeMask           = [currDIR,'/Jango181107_GT_RAS_up03_mask.nii'];
imageLocation.anatomy                 = [currDIR,'/Jango181107_GT_RAS_up03.nii'];


%definition of guide tube threshold and greater then  or less than
guideTube.isGreaterThen   = 1;
guideTube.threshold       = 10;

%find center of guide tube using the mean position weighted by voxel
%intensity
guideTube.isWeightedMean = 1;

%definition of grid positions  for each mask in guideTubeMask_imageName
%mask1 should indicate the pos gridpos 
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

%% check volume is in correct orientation  %%

%order of dimensions [Coronal Transverse Sagittal]
imageOrient.dimOrder = [1 3 2];

%volume flips to perform [dorsal-ventral  anterior-posterior left-right]
imageOrient.isFlipped = [1 1 0];

%%make sure volume in correct orientation
%necessary for further calculations!
checkVolOrientation(imageLocation.anatomy,imageOrient);

%% If sparse guide tube (defined only by start and end point) used
% then fill line between points and dilate line using n_dilate_voxels
if(sparseGT==1)
    n_dilate_voxels = 5;
    imageLocation = fill_in_guidetube(imageLocation,imageOrient,n_dilate_voxels);
end

%% calculate mean trajectories and positions and draw grid volume %%
makeGridImage(imageLocation,imageOrient,guideTube,gridpos);


%% get grid position from nifti output of makeGridImage %%
findGridPos_fromVal(32);
