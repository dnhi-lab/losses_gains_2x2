function data = dispOutcome(screen, study, grid, i, OUich, text, data, trials_loop, col)
% A function to display which of the 4 outcomes the participants got
[Links, Rechts, Oben, Unten] = codeQuadrant(data, trials_loop, col);
dispGrid(screen, grid, OUich, text);
POM = study.POM.randomOrder{i};
if OUich == 1
    if Oben == 1 && Links == 1
        DrawFormattedText(screen.window, num2str(POM(2)), screen.size.xCenter-grid.tileSize*2/3, screen.size.yCenter-grid.tileSize/2, screen.colour.Me);
        DrawFormattedText(screen.window, num2str(POM(2)), screen.size.xCenter-grid.tileSize/3, screen.size.yCenter-grid.tileSize/2, screen.colour.You);
    elseif Oben == 1 && Rechts == 1
        DrawFormattedText(screen.window, num2str(POM(4)), screen.size.xCenter+grid.tileSize/3, screen.size.yCenter-grid.tileSize/2, screen.colour.Me);
        DrawFormattedText(screen.window, num2str(POM(1)), screen.size.xCenter+grid.tileSize*2/3, screen.size.yCenter-grid.tileSize/2, screen.colour.You);
    elseif Unten == 1 && Links == 1
        DrawFormattedText(screen.window, num2str(POM(1)), screen.size.xCenter-grid.tileSize*2/3, screen.size.yCenter+grid.tileSize/2, screen.colour.Me);
        DrawFormattedText(screen.window, num2str(POM(4)), screen.size.xCenter-grid.tileSize/3, screen.size.yCenter+grid.tileSize/2, screen.colour.You);
    elseif Unten == 1 && Rechts == 1
        DrawFormattedText(screen.window, num2str(POM(3)), screen.size.xCenter+grid.tileSize*2/3, screen.size.yCenter+grid.tileSize/2, screen.colour.You);
        DrawFormattedText(screen.window, num2str(POM(3)), screen.size.xCenter+grid.tileSize/3, screen.size.yCenter+grid.tileSize/2, screen.colour.Me);
    end
elseif OUich == 0
    if Oben == 1 && Links == 1
        DrawFormattedText(screen.window, num2str(POM(2)), screen.size.xCenter-grid.tileSize*2/3, screen.size.yCenter-grid.tileSize/2, screen.colour.You);
        DrawFormattedText(screen.window, num2str(POM(2)), screen.size.xCenter-grid.tileSize/3, screen.size.yCenter-grid.tileSize/2, screen.colour.Me);
    elseif Oben == 1 && Rechts == 1
        DrawFormattedText(screen.window, num2str(POM(4)), screen.size.xCenter+grid.tileSize/3, screen.size.yCenter-grid.tileSize/2, screen.colour.You);
        DrawFormattedText(screen.window, num2str(POM(1)), screen.size.xCenter+grid.tileSize*2/3, screen.size.yCenter-grid.tileSize/2, screen.colour.Me);
    elseif Unten == 1 && Links == 1
        DrawFormattedText(screen.window, num2str(POM(1)), screen.size.xCenter-grid.tileSize*2/3, screen.size.yCenter+grid.tileSize/2, screen.colour.You);
        DrawFormattedText(screen.window, num2str(POM(4)), screen.size.xCenter-grid.tileSize/3, screen.size.yCenter+grid.tileSize/2, screen.colour.Me);
    elseif Unten == 1 && Rechts == 1
        DrawFormattedText(screen.window, num2str(POM(3)), screen.size.xCenter+grid.tileSize*2/3, screen.size.yCenter+grid.tileSize/2, screen.colour.Me);
        DrawFormattedText(screen.window, num2str(POM(3)), screen.size.xCenter+grid.tileSize/3, screen.size.yCenter+grid.tileSize/2, screen.colour.You);
    end
end

% If button press invalid or none
if data.values(trials_loop, col.pressType) == 2
    DrawFormattedText(screen.window, text.false, 'center', screen.size.dotCenter(1,2)-0.2*screen.size.Ypixels, screen.colour.red);
elseif data.values(trials_loop, col.pressType) == 3
    DrawFormattedText(screen.window, text.slow, 'center', screen.size.dotCenter(1,2)-0.2*screen.size.Ypixels, screen.colour.red);
end

Screen('Flip', screen.window);
pause(1);
end