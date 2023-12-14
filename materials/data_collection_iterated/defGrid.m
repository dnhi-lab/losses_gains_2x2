function grid = defGrid(screen)
grid.dimensions = min(screen.size.Xpixels, screen.size.Ypixels); % the basic set-up will be a square. We will place the actual grid on top of this
grid.backCoordinates = [0 0 grid.dimensions, grid.dimensions]; % This defines from where to where the square will be drawn
grid.back = CenterRectOnPointd(grid.backCoordinates, screen.size.xCenter, screen.size.yCenter);

grid.tileNumber = 6; % This is a number you can pick somewhat arbitrarily and can be changed if the tile are too large/small on the screen you're using
grid.tileSize = grid.dimensions/grid.tileNumber;
grid.tileCoordinates = [0 0 grid.tileSize grid.tileSize];

grid.structure = zeros(grid.tileNumber); % grid.structure(columns,rows)
grid.structure(3:4, 3:4) = 1; %define the tiles you want to use in the study by setting them to 1
% Note: this might need to be adjusted if the grid.tileNumber is changed

end