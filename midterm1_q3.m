%% Question 3
clear;
clc;
close all;

%% 1) Read binary wrench image
I = imread('wrench.png');

% Convert grayscale
I = rgb2gray(I);

% Black pixels = 1
BW = I < 128;

figure;
imshow(~BW);
title('Original Wrench Image');

%% 2) Find black pixel coordinates
[row,col] = find(BW);
x = col;
y = -row;     % make y-axis upward

figure;
plot(x,y,'.');
axis equal;
grid on;
title('Black Pixel Coordinates');

%% 3) Move center to origin
x_mean = mean(x);
y_mean = mean(y);

x = x - x_mean;
y = y - y_mean;

figure;
plot(x,y,'.');
axis equal;
grid on;
title('Zero Mean Coordinates');

%% 4) KLT Correlation Matrix
R = [
    mean(x.^2)      mean(x.*y);
    mean(x.*y)      mean(y.^2)
];

disp('Correlation Matrix:')
disp(R)

%% 5) Eigenvalue and Eigenvector
[V,D] = eig(R);

% Sort eigenvalues
[eigenvalues,index] = sort(diag(D),'descend');
V = V(:,index);

% Main direction vector
direction = V(:,1);

disp('Eigenvalues:')
disp(eigenvalues)

disp('Main Eigenvector:')
disp(direction)

%% 6) Find rotation angle
angle = atan2(direction(2),direction(1));
angle_degree = rad2deg(angle);
fprintf('Wrench angle = %.2f degree\n',angle_degree);

%% Show main axis
figure;
plot(x,y,'.');
hold on;
quiver(0,0,...
       direction(1)*100,...
       direction(2)*100,...
       'r','LineWidth',2);
axis equal;
grid on;
title('Major Eigenvector (Wrench Direction)');

%% 7) Rotate coordinates
Rrot = [
cos(angle) sin(angle);
-sin(angle) cos(angle)
];

P = Rrot*[x';y'];

figure;
plot(P(1,:),P(2,:),'.');
axis equal;
grid on;
title('Rotated Horizontal Wrench');
