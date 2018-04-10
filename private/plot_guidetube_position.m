function plot_guidetube_position(guideTube_points_transverse_range,meanPoint_AP_LR,anat,imageLocation)

%get directory where anatomy is stored to print into
[printDir, anatomy_name] = fileparts(imageLocation.anatomy);

%get range of plot
for i = 1:size(meanPoint_AP_LR,3)
    dim(i).min = min(round(min(meanPoint_AP_LR(:,:,i))));
    dim(i).max = max(round(max(meanPoint_AP_LR(:,:,i))));
    dim(i).min_to_max = [dim(i).min:dim(i).max];
end

%initiliaze & open video object
vid = VideoWriter( fullfile(printDir,['guidetube_position_estimate.avi']));
open(vid);
        
%loop through slices
for  i_transverse_slice = 1:numel(guideTube_points_transverse_range)
    
    %initiliaze figure
    figure('visible','off');
    set(gcf,'Position',[195   75   270   235]);

    %plot anatomical image with guide tubes
    imagesc(squeeze(anat.vol(dim(1).min_to_max, guideTube_points_transverse_range(i_transverse_slice),dim(2).min_to_max))); colormap(gray); hold on;

    %plot estimates of guidetube center
    for i = 1:size(meanPoint_AP_LR,2)
        x_position = meanPoint_AP_LR(i_transverse_slice,i,1)-dim(1).min + 1;
        y_position = meanPoint_AP_LR(i_transverse_slice,i,2)-dim(2).min + 1;
        plot(y_position,x_position,'.r'); hold on;
    end

    %title
    title(sprintf('slice number: %d',guideTube_points_transverse_range(i_transverse_slice)));
    
    %save and delete figure
    ouputFileName = fullfile(printDir,['current_guidetube_position.png']);
    print(gcf,ouputFileName,'-dpng');
    close(gcf)
    
    %read in figure as image
    I = imread(ouputFileName);
    
    %write image to video
    try
        writeVideo(vid,I);
    catch
        disp(sprintf('slice number: %d could not be added',i_transverse_slice));
    end
    

end

%close video and delete temporary image
close(vid);
delete(ouputFileName);
