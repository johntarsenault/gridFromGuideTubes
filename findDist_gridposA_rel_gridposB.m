function [grid_AvsB_positionValAP grid_AvsB_positionValLM] = findDist_gridposA_rel_gridposB(gridposA,gridposB)

    %positive AP values more anterior
    %positive LM values more 
        [gridposA.positionValAP gridposA.positionValLM] = gridpointName_to_gridpointValue(gridposA.positionNameAP,gridposA.positionNameLM);
        [gridposB.positionValAP gridposB.positionValLM] = gridpointName_to_gridpointValue(gridposB.positionNameAP,gridposB.positionNameLM);

        
        grid_AvsB_positionValAP = gridposA.positionValAP - gridposB.positionValAP;
        grid_AvsB_positionValLM = gridposA.positionValLM - gridposB.positionValLM;
