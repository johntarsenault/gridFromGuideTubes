function vol = reorient_vol(vol, dimOrder, flipVals)

%change orientation of volume so corresponds to:
%dimension 1 Coronal    - increasing steps in this dim move from Posterior toAnterior
%dimension 2 Transverse - increasing steps in this dim move from Dorsal to Ventral
%dimension 3 Sagittal   - increasing steps in this dim move from Left to Right

vol = permute(vol, dimOrder);


%flip volume
%dorsal ventral flip
flipDV_vol = flipVals(1);

%anterior posterior flip
flipAP_vol = flipVals(2);

%left right flip
flipLR_vol = flipVals(3);


if flipDV_vol
    vol = fliplr(vol);
end

if flipAP_vol
    vol = flipud(vol);
end

if flipLR_vol
    vol = permute(vol, [1, 3, 2]);
    vol = fliplr(vol);
    vol = permute(vol, [1, 3, 2]);
end
