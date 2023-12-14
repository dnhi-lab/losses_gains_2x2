function [screen] = defScreen()
Screen('Preference', 'SkipSyncTests', 1);
PsychDefaultSetup(2);
screen.screens = Screen('Screens');
screen.number = 2; %min(screen.screens);

screen.colour.white     = WhiteIndex(screen.number);
screen.colour.black     = BlackIndex(screen.number);
screen.colour.red       = [1 0 0];
screen.colour.green1    = [0 1 0];
screen.colour.green2    = [0 0.5 0];
screen.colour.blue1     = [0 0 1];
screen.colour.blue2     = [0 0.75 0.75];
screen.colour.gelb1     = [0.75 0.75 0];
screen.colour.gelb2     = [1 1 0];
screen.colour.pink      = [0.75 0 0.75];

screen.colour.Me = screen.colour.blue2;
screen.colour.You = screen.colour.white;

% Open an on screen window and color it black
[screen.window, screen.wRect] = PsychImaging('OpenWindow', screen.number, screen.colour.black);

% Get the size of the on screen window in pixels
[screen.size.Xpixels, screen.size.Ypixels] = Screen('WindowSize', screen.window);
% Get the centre coordinate of the window in pixels
[screen.size.xCenter, screen.size.yCenter] = RectCenter(screen.wRect);
% Enable alpha blending for anti-aliasing
Screen('BlendFunction', screen.window, GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
% Query the frame duration
screen.other.ifi = Screen('GetFlipInterval', screen.window);
% Use the meshgrid command to create our base dot coordinates
screen.other.x = 0;
screen.other.y = 0;
% Calculate the number of dots
numDots = 1; % numel(x);
% Make the matrix of positions for the dots into two vectors
screen.size.xPosVector = reshape(screen.other.x, 1, numDots);
screen.size.yPosVector = reshape(screen.other.y, 1, numDots);
% We can define a center for the dot coordinates to be relaitive to. Here
% we set the centre to be the centre of the screen
screen.size.dotCenter = [screen.size.Xpixels / 2 screen.size.Ypixels / 2];
end