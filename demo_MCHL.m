%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                         %
% This is a demo for the MCHL (Multi-view Clustering on Topological      %
% Manifold) algorithm, which implements a novel multi-view clustering     %
% approach that combines topological structure information with manifold  %
% learning for improved clustering performance.                           %
%                                                                         %
% The code has been tested in MATLAB R2016a and later versions.          %
%                                                                         %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function demo_MCHL()

clear;
close all;
clc;

dataName = 'Caltech101_20';

% Load the demo data
load(['data_',dataName,'.mat'],'fea','gt');
% Basic dataset information
num_view = length(fea);        % Number of views
num_samp = numel(gt);          % Number of samples
num_clus = numel(unique(gt));  % Number of clusters

fprintf('Dataset Information:\n');
fprintf('Number of samples: %d\n', num_samp);
fprintf('Number of views: %d\n', num_view);
fprintf('Number of clusters: %d\n', num_clus);
fprintf('\n');

% Algorithm parameters (optimized defaults)
alpha = 1.0;      % regularization parameter for Z
beta = 1.0;       % regularization parameter for S
gamma = 0.0;      % distance penalty parameter
knn = 20;         % number of k-nearest neighbors
normData = 1;     % data normalization flag

fprintf('Algorithm Parameters:\n');
fprintf('alpha = %.1f\n', alpha);
fprintf('beta = %.1f\n', beta);
fprintf('gamma = %.1f\n', gamma);
fprintf('k-NN = %d\n', knn);
fprintf('normData = %d\n', normData);
fprintf('\n');

% Run MCHL algorithm
fprintf('Running MCHL algorithm...\n');
[y, a, S, time, obj] = MCHL(fea, gt, alpha, beta, gamma, knn, normData);

% Display results
fprintf('\n=== Results ===\n');
if a == 1
    % Algorithm converged successfully
    nmiScore = NMImax(y, gt);
    fprintf('Algorithm completed successfully.\n');
    fprintf('NMI = %.4f\n', nmiScore);
    fprintf('Runtime = %.2f seconds\n', time);
    fprintf('Number of iterations: %d\n', length(obj));
else
    fprintf('Algorithm failed to converge.\n');
    fprintf('Please try adjusting the parameters.\n');
end

end