function [gridCenter] = findCenterPosition(gridpos,gridAPstep,gridLMstep,meanPoint_AP_LR,guideTube_points_transverse_range)


%get number of grids
numberOfGrids = size(gridpos,2);


%find median index of all the transverse slices with all gridpoint represented
    medianIndex_allGrids = round(median(find(sum(~isnan(squeeze(meanPoint_AP_LR(:,:,1))),2)==numberOfGrids)));


%loop through each grid at the median trans slice with all gridpoints
%grab the each gridpoint there

clear gridImage calcCenterImage_AP
for i = 1:numberOfGrids
    gridImage(i).AP     = meanPoint_AP_LR(medianIndex_allGrids,i,1);
    gridImage(i).DV     = guideTube_points_transverse_range(medianIndex_allGrids);
    gridImage(i).LM     = meanPoint_AP_LR(medianIndex_allGrids,i,2);
end

%assign center grid pos name
gridposCenter.positionNameAP = 'C';
gridposCenter.positionNameLM = 'C';


%calculate image center based on all grid points, and the avg. AP, LM step
%size
for i = 1:numberOfGrids
       [grid_vs_center_positionNameAP(i) grid_vs_center_positionNameLM(i)] = findDist_gridposA_rel_gridposB(gridposCenter,gridpos(i));
        calcCenterImage_AP(i) = gridImage(i).AP + grid_vs_center_positionNameAP(i)*gridAPstep.imageAPstep + grid_vs_center_positionNameLM(i)*gridLMstep.imageAPstep;
        calcCenterImage_LM(i) = gridImage(i).LM + grid_vs_center_positionNameLM(i)*gridLMstep.imageLMstep + grid_vs_center_positionNameAP(i)*gridAPstep.imageLMstep;
end

gridCenter.AP = mean(calcCenterImage_AP);
gridCenter.DV = guideTube_points_transverse_range(medianIndex_allGrids);
gridCenter.LM = mean(calcCenterImage_LM);
