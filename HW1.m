%----------------------------------------------------------------------------------------------
% SUID: 425325424                      Name: Jinkal Arvind Javia
% CIS 787 - ADM                        HW #1: Question 3
%----------------------------------------------------------------------------------------------
function curse_of_dimensionality = HW1(n,d)
n_val = [];
d_val = [];
Euclidean_val = [];
L1Norm_val = [];
for i = 1:20:d                
    for j = 100:50:n          
        d_val = [d_val;i];
        n_val = [n_val;j];
        P = rand(j,i);                                 % Generates n d-dimensional random points
        D_Euclidean = pdist(P);                        % Calculates Euclidean distance
        [Euclidean_min, minIdx] = min(D_Euclidean(:)); % Computes minimum distance
        [Euclidean_max, maxIdx] = max(D_Euclidean(:)); % Computes maximum distance
        Euclidean_function = log10(rdivide(minus(Euclidean_max,Euclidean_min),Euclidean_min)); % Computes y(d,n)
        Euclidean_val = [Euclidean_val;Euclidean_function]; 
        
        D_L1Norm = pdist(P, 'cityblock');              % Calculates L1 norm distance
        [L1Norm_min, minIdx] = min(D_L1Norm(:));       % Computes minimum distance
        [L1Norm_max, maxIdx] = max(D_L1Norm(:));       % Computes maximum distance
        L1Norm_function = log10(rdivide(minus(L1Norm_max,L1Norm_min),L1Norm_min)); % Computes y(d,n)
        L1Norm_val = [L1Norm_val;L1Norm_function];   
    end
end
n_v = linspace(100,1000,length(n_val));                % Generates linearly spaced values   
d_v = linspace(1,100,length(d_val));                   
[N,D] = meshgrid(n_v,d_v);                             % Replicates grid vectors to produce full grid
E = griddata(n_val,d_val,Euclidean_val,N,D);           % Interpolate scattered data
L = griddata(n_val,d_val,L1Norm_val,N,D);
figure,                                                % Plots 3D surface (Euclidean distance) 
h = gca;
surf(N,D,E);
title('3-D surface of y(d,n), Euclidean');
xlabel('n');
ylabel('d');
zlabel('y(d,n)');
colorbar;

figure,                                                % Plots 3D surface (L1 norm distance)
h = gca;
surf(N,D,L);
title('3-D surface of y(d,n), L1 norm');
xlabel('n');
ylabel('d');
zlabel('y(d,n)');
colorbar;