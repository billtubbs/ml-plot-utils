% Test make_tsstatplot.m

close all


%% Example 1 - std. devs. and mean

rng(0); figure(1);
t = 0.5*(0:20)';
Y = randn(21, 10);
make_tsstatplot(Y, t, 'Output', 'Time (mins)', nan(2), 'std', 'mean')

% With y-axis limits
figure(2);
make_tsstatplot(Y, t, '$y(t)$', '$t$ (mins)', [-1 1], 'std', 'mean')


%% Example 2 - Confidence intervals and median

rng(0); figure(3);
t = 0.5*(0:20)';
Y = randn(21, 10);
make_tsstatplot(Y, t, '$y(t)$', '$t$ (mins)', nan(2), '90', 'median')


%% Example 3 - With more than one group of trajectories

rng(0); figure(4);
t = 0.5*(0:20)';
Y = {randn(21, 10), randn(21, 10)+2*sin(t)};
y_labels = {'$y_1(t)$', '$y_2(t)$'};
make_tsstatplot(Y, t, y_labels, '$t$ (mins)', nan(2), 'std', 'mean')
