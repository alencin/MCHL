# MCHL: Multi-view Clustering on Topological Manifold

A MATLAB implementation of a novel multi-view clustering algorithm that leverages topological manifold learning for improved clustering performance across multiple data views.

## Overview

This project implements a multi-view clustering approach that combines topological structure information with manifold learning to perform clustering on datasets with multiple feature representations (views). The algorithm adaptively learns view weights and optimizes similarity matrices through iterative optimization.

## Key Features

- **Topological Manifold Learning**: Incorporates topological structure information for better clustering
- **Multi-View Data Fusion**: Handles datasets with multiple feature representations
- **Adaptive View Weighting**: Dynamically adjusts the importance of different views
- **Graph-based Optimization**: Iteratively optimizes similarity matrices and feature representations

## Usage

### Quick Start

```matlab
% Run the demo
demo_MCHL
```

### Basic Usage

```matlab
% Load your multi-view data
% fea: cell array (num_views × 1), each cell contains (num_samples × features)
% gt: ground truth labels (num_samples × 1)

% Run the algorithm with default parameters
[y, a, S, time, obj] = MCHL(fea, gt);

% y: predicted cluster labels
% a: availability indicator (1 if successful clustering)
% S: learned similarity matrix
% time: execution time
% obj: objective function values
```

### Parameter Tuning

```matlab
% Run with custom parameters
alpha = 1.0;     % regularization parameter for Z
beta = 1.0;      % regularization parameter for S
gamma = 0.0;     % distance penalty parameter
knn = 20;        % number of k-nearest neighbors
normData = 1;    % data normalization flag

[y, a, S, time, obj] = MCHL(fea, gt, alpha, beta, gamma, knn, normData);
```

## File Structure

```
├── demo_MCHL.m          # Main demo script
├── MCHL.m               # Core algorithm implementation
├── NMImax.m             # Evaluation metric (Normalized Mutual Information)
├── constructW_PKN.m     # Probabilistic k-NN similarity construction
├── L2_distance_1.m      # Euclidean distance computation
├── eig1.m               # Eigenvalue decomposition utility
└── README.md            # This file
```

## Data Format

The algorithm expects multi-view data in the following format:

```matlab
% fea: cell array of size (num_views × 1)
% Each cell contains a matrix of size (num_samples × num_features_view_i)
fea{1} = view1_features;  % First view (num_samples × features1)
fea{2} = view2_features;  % Second view (num_samples × features2)
% ... additional views

% gt: ground truth cluster labels
gt = [1; 1; 2; 2; 3; 3; ...];  % (num_samples × 1)
```

## Parameters

- **alpha**: Regularization parameter for connection matrices Z_v (default: 1.0)
- **beta**: Regularization parameter for similarity matrix S (default: 1.0)
- **gamma**: Distance penalty parameter (default: 0.0)
- **knn**: Number of k-nearest neighbors for graph construction (default: 20)
- **normData**: Data normalization flag (1: normalize, 0: no normalization)

## Requirements

- MATLAB R2016a or later
- Statistics and Machine Learning Toolbox (recommended)

## Example

```matlab
% Load demo data
load('data_demo.mat', 'fea', 'gt');

% Run MCHL algorithm
[labels, success, similarity, runtime, objectives] = MCHL(fea, gt);

% Evaluate results
if success == 1
    nmi_score = NMImax(labels, gt);
    fprintf('NMI Score: %.4f\n', nmi_score);
    fprintf('Runtime: %.2f seconds\n', runtime);
else
    fprintf('Algorithm failed to converge\n');
end
```

## Contact

For questions or issues, please contact the authors or create an issue in this repository.