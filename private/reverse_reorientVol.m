function vol = reverse_reorientVol(vol,dimOrder,flipVals)
%reverse change in orientation of volume to original 
%inputs should be same dimorder and flipVals used for reorientVol

%step 1 - flip back volumes

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
   vol = permute(vol,[1 3 2]);
   vol = fliplr(vol);
   vol = permute(vol,[1 3 2]);
end

[ordered newDimOrder] = sort(dimOrder);

vol = permute(vol,newDimOrder);




