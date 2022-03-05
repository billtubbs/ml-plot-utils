% Test make_waterfall_plot.m

clear all; close all

% Directory to save test plots
plot_dir = 'plots';
if ~isfolder(plot_dir)
    mkdir(plot_dir)
end

%% Test 1

nT = 50;
t = linspace(0, 10, nT+1);
Z = (idinput([nT+1 10]) + 1) / 2;
z_lim = [-1 1];
ax_labels = {'t', 'Sequence', 'y'};

figure(1)
p = make_waterfall_plot(t, Z, z_lim, ax_labels);
save_fig_to_pdf(fullfile(plot_dir, 'waterfallplot1.pdf'))


%% Test 2

nT = 50;
t = linspace(0, 10, nT+1);
[X,Y] = meshgrid(-3:0.25:3, -3:.12:3);
Z2 = peaks(X,Y);
z_lim = [-10 10];
ax_labels = {'t', 'Sequence', 'y'};

figure(2)
view_angles = [30 75];
p = make_waterfall_plot(t, Z2, z_lim, ax_labels, ...
    view_angles);
save_fig_to_pdf(fullfile(plot_dir, 'waterfallplot2.pdf'))

close all