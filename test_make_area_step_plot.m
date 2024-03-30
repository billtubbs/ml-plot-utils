% Test function make_area_step_plot.m

clear all; close all

% Directory to save test plots
plot_dir = 'plots';
if ~isfolder(plot_dir)
    mkdir(plot_dir)
end

%% Tests

% Random steps
x = (1:10)';
Y = rand(10, 3);  % Note: last row is not plotted

figure(1)
make_area_step_plot(x, Y(:, 1))
save_fig_to_pdf(fullfile(plot_dir, 'area_step_plot1.pdf'))

figure(2)
make_area_step_plot(x, Y)
save_fig_to_pdf(fullfile(plot_dir, 'area_step_plot2.pdf'))

% Test with last row in Y missing (should be the same)
figure(3)
make_area_step_plot(x, Y(1:end-1, :))
save_fig_to_pdf(fullfile(plot_dir, 'area_step_plot3.pdf'))

close all
