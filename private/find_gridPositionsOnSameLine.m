function  [gridpos_same_LM gridpos_same_AP] = find_gridPositionsOnSameLine(gridpos)

%grab AP positions
 positionNameAP = cat(2,{gridpos.positionNameAP});
 
 %find number of guide tubes per AP position 
 unique_positionNameAP = unique(positionNameAP);
 numbOf_thisAP_Positon = [];
 for i = unique_positionNameAP
     numbOf_thisAP_Positon =  [numbOf_thisAP_Positon sum(cell2mat(strfind(positionNameAP,i)))];
 end

 %get the position number of the most common AP positon
 [maxVal maxIndex] = max(numbOf_thisAP_Positon);
 mostCommon_AP_Index = unique_positionNameAP(maxIndex);
 gridpos_same_AP = find(cellfun(@(x) ~isempty(x),strfind(positionNameAP,mostCommon_AP_Index)));
 
 
%grab LM positions
 positionNameLM = cat(2,{gridpos.positionNameLM});
 
 %find number of guide tubes per LM position 
 unique_positionNameLM = unique(positionNameLM);
 numbOf_thisLM_Positon = [];
 for i = unique_positionNameLM
     numbOf_thisLM_Positon =  [numbOf_thisLM_Positon sum(cell2mat(strfind(positionNameLM,i)))];
 end

 %get the position number of the most common LM positon
 [maxVal maxIndex] = max(numbOf_thisLM_Positon);
 mostCommon_LM_Index = unique_positionNameLM(maxIndex);
 gridpos_same_LM = find(cellfun(@(x) ~isempty(x),strfind(positionNameLM,mostCommon_LM_Index)));
 
 