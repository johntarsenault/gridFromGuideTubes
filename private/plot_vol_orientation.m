function plotVolOrientation(vol)

currentWindowSize = [27   189   942   823];

figure;
subplot(2,2,1);
x_mean = squeeze(mean(squeeze(mean(vol,2)),2));
x_prct = prctile(x_mean,[20]);
x_over_pctile = find((x_mean -x_prct)>0);
mid_x_index = x_over_pctile(round(length(x_over_pctile)/2));
imagesc(squeeze(vol(mid_x_index,:,:)));

colormap('gray');
title('coronal');
xlabel('increases right');
ylabel('increase ventral');

subplot(2,2,3);
y_mean = squeeze(mean(squeeze(mean(vol,1)),2));
y_prct = prctile(y_mean,[20]);
y_over_pctile = find((y_mean -y_prct)>0);
mid_y_index = y_over_pctile(round(length(y_over_pctile)/2));
imagesc(squeeze(vol(:,mid_y_index,:)));

colormap('gray');
title('transverse');
ylabel('increases posterior');
xlabel('increase right');

subplot(2,2,4);
z_mean = squeeze(mean(squeeze(mean(vol,1)),1));
z_prct = prctile(z_mean,[20]);
z_over_pctile = find((z_mean - z_prct)>0);
mid_z_index = z_over_pctile(round(length(z_over_pctile)/2));
imagesc(squeeze(vol(:,:,mid_z_index)));
colormap('gray');
title('sagittal');
xlabel('increases ventral');
ylabel('increases posterior');

set(gcf,'Position',currentWindowSize)

currentWindowSize = [998   149   902   930];


intervals = floor((length(x_over_pctile))/20);
sliceToShow = intervals:intervals:length(x_over_pctile);

figure;
for i = 1:20
    subplot(5,4,i);imagesc(squeeze(vol(x_over_pctile(sliceToShow(i)),:,:)));
    colormap('gray');
    title('coronal');
    xlabel('increases right');
    ylabel('increases ventral');
end

set(gcf,'Position',currentWindowSize)
