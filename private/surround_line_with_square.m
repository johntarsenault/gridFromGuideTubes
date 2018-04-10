function expanded_line = surround_line_with_square(x_line,y_line,z_line,nVoxels)

expanded_line = {};
counter = 0;

for i_x = -1*nVoxels:1:nVoxels
    for j_z = -1*nVoxels:1:nVoxels
        counter = counter + 1;
        expanded_line{counter}.x_line =  x_line + i_x;
        expanded_line{counter}.y_line =  y_line;
        expanded_line{counter}.z_line =  z_line + j_z;
    end
end


