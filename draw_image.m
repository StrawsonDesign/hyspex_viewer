function draw_image(data,band)

    imagesc(data(:,:,band))
    colormap(gray)
    colorbar
    axis equal
    fprintf('drawing band: %d\n', band);


end