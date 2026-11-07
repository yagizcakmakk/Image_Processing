%% Question 5 - Part C
clear; clc; close all;

%% Parameters
N = 8;
a = 0.8;      % AR(1) coefficient
sigma2 = 1;   % Noise variance (scale factor)

%% --------------------------------------------------------
%% Part C-1 : Construct autocorrelation matrix R
%% R(i,j)=a^(|i-j|)
%% --------------------------------------------------------

R = zeros(N);

for i = 1:N
    for j = 1:N
        R(i,j) = sigma2 * a^(abs(i-j));
    end
end

disp('Autocorrelation Matrix R = ');
disp(R);

%% --------------------------------------------------------
%% Part C-2 : Eigenvectors (KLT Basis)
%% --------------------------------------------------------

[U,D] = eig(R);

% Sort eigenvalues in descending order
[eigVal,idx] = sort(diag(D),'descend');

D = diag(eigVal);
U = U(:,idx);

disp('Eigenvalues = ');
disp(eigVal);

%% --------------------------------------------------------
%% Part C-3 : Basis Images
%% basis = ui * uj^T
%% --------------------------------------------------------

basisImages = cell(N,N);

for i = 1:N
    for j = 1:N

        basisImages{i,j} = U(:,i) * U(:,j)';

    end
end

%% --------------------------------------------------------
%% Part C-4 : Display all 64 basis images
%% --------------------------------------------------------

figure;

for k = 1:N*N

    subplot(N,N,k)

    img = basisImages{k};

    % normalize between 0-1
    img = img - min(img(:));
    img = img ./ max(img(:));

    imshow(img);

end

sgtitle('64 KLT Basis Images');