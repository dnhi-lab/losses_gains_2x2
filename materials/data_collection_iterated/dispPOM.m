function dispPOM(screen, grid, study, i, OUich)
POM = study.POM.randomOrder{i};

if OUich == 1
    % Up/left
    DrawFormattedText(screen.window, num2str(POM(2)), screen.size.xCenter-grid.tileSize*2/3, screen.size.yCenter-grid.tileSize/2, screen.colour.Me);
    DrawFormattedText(screen.window, num2str(POM(2)), screen.size.xCenter-grid.tileSize/3, screen.size.yCenter-grid.tileSize/2, screen.colour.You);
    % Up right
    DrawFormattedText(screen.window, num2str(POM(4)), screen.size.xCenter+grid.tileSize/3, screen.size.yCenter-grid.tileSize/2, screen.colour.Me);
    DrawFormattedText(screen.window, num2str(POM(1)), screen.size.xCenter+grid.tileSize*2/3, screen.size.yCenter-grid.tileSize/2, screen.colour.You);
    % Down/left
    DrawFormattedText(screen.window, num2str(POM(1)), screen.size.xCenter-grid.tileSize*2/3, screen.size.yCenter+grid.tileSize/2, screen.colour.Me);
    DrawFormattedText(screen.window, num2str(POM(4)), screen.size.xCenter-grid.tileSize/3, screen.size.yCenter+grid.tileSize/2, screen.colour.You);
    % Down/right
    DrawFormattedText(screen.window, num2str(POM(3)), screen.size.xCenter+grid.tileSize*2/3, screen.size.yCenter+grid.tileSize/2, screen.colour.You);
    DrawFormattedText(screen.window, num2str(POM(3)), screen.size.xCenter+grid.tileSize/3, screen.size.yCenter+grid.tileSize/2, screen.colour.Me);
elseif OUich == 0
    % Up/left
    DrawFormattedText(screen.window, num2str(POM(2)), screen.size.xCenter-grid.tileSize*2/3, screen.size.yCenter-grid.tileSize/2, screen.colour.You);
    DrawFormattedText(screen.window, num2str(POM(2)), screen.size.xCenter-grid.tileSize/3, screen.size.yCenter-grid.tileSize/2, screen.colour.Me);
    % Up right
    DrawFormattedText(screen.window, num2str(POM(4)), screen.size.xCenter+grid.tileSize/3, screen.size.yCenter-grid.tileSize/2, screen.colour.You);
    DrawFormattedText(screen.window, num2str(POM(1)), screen.size.xCenter+grid.tileSize*2/3, screen.size.yCenter-grid.tileSize/2, screen.colour.Me);
    % Down/left
    DrawFormattedText(screen.window, num2str(POM(1)), screen.size.xCenter-grid.tileSize*2/3, screen.size.yCenter+grid.tileSize/2, screen.colour.You);
    DrawFormattedText(screen.window, num2str(POM(4)), screen.size.xCenter-grid.tileSize/3, screen.size.yCenter+grid.tileSize/2, screen.colour.Me);
    % Down/right
    DrawFormattedText(screen.window, num2str(POM(3)), screen.size.xCenter+grid.tileSize*2/3, screen.size.yCenter+grid.tileSize/2, screen.colour.Me);
    DrawFormattedText(screen.window, num2str(POM(3)), screen.size.xCenter+grid.tileSize/3, screen.size.yCenter+grid.tileSize/2, screen.colour.You);
end

end