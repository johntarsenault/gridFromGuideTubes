function checkVolOrientation(Anat_imageName,dimOrder,flipVals)
addpath /fmri/apps/freesurfer-6.0.0/matlab/

% Anat_imageName = 'Gaston_Anat_171002_LPS_VSdouble.nii';

%order of dimensions [Coronal Transverse Sagittal]
%dimOrder = [1 3 2];

%volume flips to perform [dorsal-ventral  anterior-posterior left-right]
%flipVals = [1 1 1]


%read in images
Anat = MRIread(Anat_imageName);

Anat.vol = reorientVol(Anat.vol,dimOrder,flipVals);

plotVolOrientation(Anat.vol);

