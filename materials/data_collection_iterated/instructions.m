function instructions(text, msg, screen)
% Display the greetings
DrawFormattedText(screen.window, msg, 'center', screen.size.dotCenter(1,2)-0.4*screen.size.Ypixels, screen.colour.white);
DrawFormattedText(screen.window, text.pressAnyButton, 'center', screen.size.dotCenter(1,2)+0.3*screen.size.Ypixels, screen.colour.white);
Screen('Flip', screen.window);
KbStrokeWait;

end