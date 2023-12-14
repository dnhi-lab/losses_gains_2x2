function dispGrid(screen, grid, OUich, text)
% Draw a white backdrop for the grid
Screen('FillRect', screen.window, screen.colour.white, grid.back)
% This now draws the grid onto the background, dependent on which tiles you set to 1 in the settings
for j = 1:grid.tileNumber % rows
    for i = 1:grid.tileNumber % columns
        if grid.structure(i, j) == 1
            grid.tile = CenterRectOnPointd(grid.tileCoordinates, screen.size.xCenter-grid.dimensions/2+grid.tileSize/2+grid.tileSize*(j-1), screen.size.yCenter-grid.dimensions/2+grid.tileSize/2+grid.tileSize*(i-1));
            Screen('FillRect', screen.window, screen.colour.black, grid.tile) % Draw the tiles you want to use
        end
    end
end

% Draw the lines to distinguish the tiles from each other
for r = 1:grid.tileNumber+1
    % Draw vertical lines
    Screen('DrawLine', screen.window, screen.colour.white, screen.size.xCenter-grid.dimensions/2+grid.tileSize*(r-1), screen.size.yCenter-grid.dimensions/2, screen.size.xCenter-grid.dimensions/2+grid.tileSize*(r-1), screen.size.Ypixels+grid.dimensions/2, 6);
    % Draw horizontal lines
    Screen('DrawLine', screen.window, screen.colour.white, screen.size.xCenter-grid.dimensions/2, screen.size.yCenter-grid.dimensions/2+grid.tileSize*(r-1), screen.size.xCenter+grid.dimensions/2, screen.size.yCenter-grid.dimensions/2+grid.tileSize*(r-1), 6);
end

% Draw a black background for the text
baseRect = [0 0 screen.size.Xpixels 300];
centeredRect = CenterRectOnPointd(baseRect, screen.size.xCenter, screen.size.yCenter-0.4*screen.size.Ypixels);
Screen('FillRect', screen.window, screen.colour.black, centeredRect)
% Draw the text
if OUich == 1
    DrawFormattedText(screen.window, text.OU, 'center', screen.size.dotCenter(1,2)-0.4*screen.size.Ypixels, screen.colour.Me);
elseif OUich == 0
    DrawFormattedText(screen.window, text.LR, 'center', screen.size.dotCenter(1,2)-0.4*screen.size.Ypixels, screen.colour.Me);
end

end