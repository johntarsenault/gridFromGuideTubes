function findGridPos_fromVal(val)

%load the standard grid
load('standGrid.mat');

disp(sprintf('position on the (m)edial - (l)ateral axis: %s',standGrid.full_gridpos_posNameLM{val}));
disp(sprintf('position on the (a)nterior - (p)osterior axis: %s',standGrid.full_gridpos_posNameAP{val}));

