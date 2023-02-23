% Test make_statplot.m, make_statdplot.m and make_stattplot.m

clear all; close all

% Directory to save test plots
plot_dir = 'plots';
if ~isfolder(plot_dir)
    mkdir(plot_dir)
end

rng(0);

% Function to model
f = @sin;

% Generate data sample
n = 8;
sigma_M = 0.1;  % measurement noise
x_d = rand(n, 1)*3;
y_d = sin(x_d) + sigma_M*randn(n, 1);

% Fit Gaussian process model
sigmaL0 = 1;  % Length scale for predictors
sigmaF0 = 0.3;  % Signal standard deviation
sigmaN0 = 0.2;  % Initial noise standard deviation
gpr_model = fitrgp(x_d, y_d, 'FitMethod', 'none', ...
    'KernelParameters', [sigmaL0; sigmaF0], 'Sigma', sigmaN0);

%gpr_model = fitrgp(x_d, y_d, 'Basis', 'linear', ...
%      'FitMethod', 'exact', 'PredictMethod', 'exact');

% Make new predictions with model
x = linspace(0, 3, 101)';
[Y_pred, ~, Y_pred_int] = predict(gpr_model, x);

% True values
y_true = f(x);



%% Test make_statdplot

figure(1); clf
make_statdplot(Y_pred, Y_pred_int(:, 1), Y_pred_int(:, 2), x, y_d, x_d, ...
   '$x$', "$y$", "prediction", 'confidence interval')
save_fig_to_pdf(fullfile(plot_dir, 'statdplot1.pdf'))


%% Test make_stattplot

figure(2); clf
make_stattplot(Y_pred, Y_pred_int(:, 1), Y_pred_int(:, 2), y_true, x, ...
   "$x$", '$y$', 'prediction', "confidence interval")
save_fig_to_pdf(fullfile(plot_dir, 'stattplot1.pdf'))


%% Test make_stattdplot

figure(3); clf
make_stattdplot(Y_pred, Y_pred_int(:, 1), Y_pred_int(:, 2), y_true, x, ...
   y_d, x_d, "$x$", '$y$', 'prediction', "confidence interval")
save_fig_to_pdf(fullfile(plot_dir, 'stattdplot1.pdf'))
