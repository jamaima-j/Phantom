function modified_phantom = custom_phantom(N, ellipses) 
  % Function to generate a custom Shepp-Logan Phantom     
  % N: Size of the Phantom Matrix (NxN)   
  % ellipses: Array of structures for each ellipse with fields:    
  % X, Y (center coordinates), Angle (rotation), Width, Height, SignalIntensity 

    % Initialize the phantom matrix with zeros (background) 
 modified_phantom = zeros(N, N); 

   % Create a meshgrid for X and Y coordinates (scaled from -1 to 1)  
   [X, Y] = meshgrid(linspace(-1, 1, N), linspace(-1, 1, N)); 
for i = 1:length(ellipses) 

  % Extract parameters for the current ellipse    
  cx = ellipses(i).X;  % X position of center     
  cy = ellipses(i).Y; % Y position of center     
  angle = ellipses(i).Angle;  % Rotation angle in degrees 
   width = ellipses(i).Width;  % Width (semi-major axis length)     
   height = ellipses(i).Height;  % Height (semi-minor axis length)  
   intensity = ellipses(i).SignalIntensity;  % Signal intensity of the ellipse          
   % Compute the rotation matrix for the ellipse
cos_angle = cosd(angle); 
sin_angle = sind(angle);
% Rotate and scale the coordinates for the ellipse equation
X_rot = cos_angle * (X - cx) + sin_angle * (Y - cy); Y_rot = -sin_angle * (X - cx) + cos_angle * (Y - cy); 
% Apply the ellipse equation (inside ellipse -> 1, outside -> 0)
ellipse_mask = ((X_rot/width).^2 + (Y_rot/height).^2 <= 1); 
% Add the signal intensity for this ellipse to the phantom 
modified_phantom(ellipse_mask) = intensity; 
end 
end

% Q2.1: Create a phantom with no overlapping structures 
% Define ellipses with modified properties to avoid overlap 
ellipses(1).X = 0; 
ellipses(1).Y = 0.5; 
ellipses(1).Angle = 0; 
ellipses(1).Width = 0.4;
ellipses(1).Height = 0.6;
ellipses(1).SignalIntensity = 1;   
ellipses(2).X = -0.3; 
ellipses(2).Y = -0.5; 
ellipses(2).Angle = 0; 
ellipses(2).Width = 0.25; 
ellipses(2).Height = 0.15; 
ellipses(2).SignalIntensity = -0.8;  
ellipses(3).X = 0.3; 
ellipses(3).Y = -0.5;
ellipses(3).Angle = 30;
ellipses(3).Width = 0.3;
ellipses(3).Height = 0.15;
ellipses(3).SignalIntensity = 0.5; 
N = 1024; 
phantom_image = custom_phantom(N, ellipses);
figure, imshow(phantom_image, []); 
title('Phantom with No Overlapping Structures'); 


% Q2.2: Start with the output of Q2.1 (modified phantom) and add two circular structures outside the brain  

% Define ellipses from Q2.1 (no overlapping structures)
ellipses(1).X = 0;
ellipses(1).Y = 0.5; 
ellipses(1).Angle = 0;
ellipses(1).Width = 0.4; 
ellipses(1).Height = 0.6; 
ellipses(1).SignalIntensity = 1; 
ellipses(2).X = -0.3; 
ellipses(2).Y = -0.5; 
ellipses(2).Angle = 0; 
ellipses(2).Width = 0.25; 
ellipses(2).Height = 0.15; 
ellipses(2).SignalIntensity = -0.8;  
ellipses(3).X = 0.3; 
ellipses(3).Y = -0.5; 
ellipses(3).Angle = 30; 
ellipses(3).Width = 0.3;
ellipses(3).Height = 0.15; 
ellipses(3).SignalIntensity = 0.5;

% Add two circular structures outside the brain 
ellipses(4).X = -0.8; 
ellipses(4).Y = -0.8; 
ellipses(4).Angle = 0; % Circular structures have no angle 
ellipses(4).Width = 0.2; % Width and height are the same for circles 
ellipses(4).Height = 0.2; 
ellipses(4).SignalIntensity = 0.7; 
ellipses(5).X = 0.8; 
ellipses(5).Y = -0.8; 
ellipses(5).Angle = 0; 
ellipses(5).Width = 0.2; 
ellipses(5).Height = 0.2; 
ellipses(5).SignalIntensity = 0.7;   % Define matrix size N
N = 1024; 
% Generate and display the phantom with two added circles
phantom_image_with_circles = custom_phantom(N, ellipses); % Change variable name to phantom_image_with_circles 
figure, imshow(phantom_image_with_circles, []); 
title('Phantom with Two Circles Outside the Brain'); 


% Q2.3: Create a phantom composed of three concentric circles 
% Define three concentric circles with different radii 
circles(1).X = 0;          % Centered at the origin 
circles(1).Y = 0; 
circles(1).Angle = 0;      % No rotation needed for circles 
circles(1).Width = 0.5;    % Large circle 
circles(1).Height = 0.5; 
circles(1).SignalIntensity = 0.8; % Intensity  
circles(2).X = 0;
circles(2).Y = 0; 
circles(2).Angle = 0;      % No rotation 
circles(2).Width = 0.3;    % Medium circle
circles(2).Height = 0.3; 
circles(2).SignalIntensity = 0.5; % Intensity  
circles(3).X = 0;
circles(3).Y = 0; 
circles(3).Angle = 0;      % No rotation
circles(3).Width = 0.1;    % Small circle 
circles(3).Height = 0.1; 
circles(3).SignalIntensity = 0.3; % Intensity  
% Generate and display the phantom with concentric circles 
phantom_concentric = custom_phantom(N, circles); 
figure, imshow(phantom_concentric, []); 
title('Phantom with Concentric Circles'); 
