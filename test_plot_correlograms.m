% Test functions plot_correlogram_x_with_conf.m and
% plot_correlogram_auto_conf.m

clear all; close all

% Directory to save test plots
plot_dir = 'plots';
if ~isfolder(plot_dir)
    mkdir(plot_dir)
end

rng(0)

% Generate white noise
Ts = 1;
nT = 200;
e = randn(nT+1, 1);

% Calculate auto-correlation coefficients
maxlag = 20;
[ec, lags] = xcov(e, maxlag, 'coeff');
i0 = find(lags == 0);

[lconf, uconf] = confidence_intervals_auto(nT, ec, maxlag, 0.99);

% Check all coefficients inside confidence interval
assert(all(ec(i0+1:end)' < uconf(2:end)))
assert(all(ec(i0+1:end)' > lconf(2:end)))

figure(1); clf
plot_correlogram_auto_conf(e, 'Correlogram - white noise')

% Simulate AR process
t = Ts*(0:nT)';
b = 1;
a = [1 -0.9];
y = filter(b, a, e);

% Add noise
sigma = 0.5;
ym = y + sigma .* randn(nT+1, 1);

figure(2); clf
make_iodplot(y, ym, t, e, {'e'}, {'y', 'ym'})

figure(3); clf
plot_correlogram_auto_conf(ym)
save_fig_to_pdf(fullfile(plot_dir, 'correlogram_auto1.pdf'))

% Simulate MA process
Ts = 1;
nT = 200;
t = (0:nT)';
b = [1 0.5];
a = 1;
y = filter(b, a, e);

% Add noise
sigma = 0.5;
ym = y + sigma .* randn(nT+1, 1);

figure(4); clf
make_iodplot(y, ym, t, e, {'e'}, {'y', 'ym'})

figure(5); clf
maxlag = 10;
plot_correlogram_auto_conf(ym, '', maxlag)
save_fig_to_pdf(fullfile(plot_dir, 'correlogram_auto2.pdf'))
