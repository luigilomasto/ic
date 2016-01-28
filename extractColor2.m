imdata = imread('colori.bmp');
color=imdata(9,:,:);
color_squeeze = squeeze(color(1,:,:));
color = unique(color_squeeze,'rows');

blue_rows = color(color(:,3) >= color(:,2),:);
blue_rows = blue_rows(blue_rows(:,3) >= blue_rows(:,1),:);

green_rows = color(color(:,2) >= color(:,3),:);
green_rows = green_rows(green_rows(:,2) >= green_rows(:,1),:);


red_rows = color(color(:,1) >= color(:,2),:);
red_rows = red_rows(red_rows(:,1) >= red_rows(:,3),:);

super_matrix = [blue_rows; green_rows; red_rows];
super_matrix = unique(super_matrix, 'rows');