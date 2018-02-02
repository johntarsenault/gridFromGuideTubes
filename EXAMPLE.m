
currDIR = '/data/fmri_monkey_03/PROJECT/codeshare/example/surgery/guideTube_outsideBrain_p2mm/';

%specify location 
guideTubeMask_imageName           = [currDIR,'/trajPoints_1to5_p2mm.nii'];
anat_imageName                    = [currDIR,'/anat_p2mm.nii'];


%definition of guide tube threshold and greater then  or less than
guideTube_greaterThen   = 1;
guideTube_threshold     = 500;

%find center of guide tube using the mean position weighted by voxel
%intensity
weightedMean = 1;

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

%define grid positions that are in the same
%LM = lateral to medial line
%AP = same anterior to posterior line
gridpos_same_LM = [1 2 3];
gridpos_same_AP = [1 4 5];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%% check volume is in correct orientation  %%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%order of dimensions [Coronal Transverse Sagittal]
dimOrder = [1 3 2];

%volume flips to perform [dorsal-ventral  anterior-posterior left-right]
flipVals = [1 1 1];

%%make sure volume in correct orientation
%necessary for further calculations!
checkVolOrientation(anat_imageName,dimOrder,flipVals);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%     calculate mean trajectories and positions and draw grid volume     %%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
makeGridImage(anat_imageName,guideTubeMask_imageName,dimOrder,flipVals,guideTube_greaterThen,guideTube_threshold,gridpos,gridpos_same_LM,gridpos_same_AP,weightedMean);

%get target region
findGridPos_fromVal(75);


