function checkVolOrientation(Anat_imageName,imageOrient)
addpath /fmri/apps/freesurfer-6.0.0/matlab/

% Anat_imageName = 'Gaston_Anat_171002_LPS_VSdouble.nii';

%order of dimensions [Coronal Transverse Sagittal]
%imageOrient.dimOrder = [1 3 2];

%volume flips to perform [dorsal-ventral  anterior-posterior left-right]
%imageOrient.flipVals = [1 1 1]


%read in images
Anat = MRIread(Anat_imageName);

Anat.vol = reorientVol(Anat.vol,imageOrient.dimOrder,imageOrient.isFlipped);

plotVolOrientation(Anat.vol);

