% Test make_stepresp_plot.m and make_stepresp_plots.m

clear all; close all

rng(8);

% Directory to save test plots
plot_dir = 'plots';
if ~isfolder(plot_dir)
    mkdir(plot_dir)
end

% random 2x2 system
% Define system
Ts = 0.5;
nu = 3;
ny = 2;
sys = drss(1, ny, nu);
sys.Ts = Ts;

% Add labels to inputs and outputs
sys.InputName = compose("In %d", 1:nu);
sys.OutputName = compose("Out %d", 1:ny);

% Simulation time
nT = 20;
t = Ts*(0:nT)';


%% Test SISO step response plots

figure(1); clf
make_stepresp_plot(sys(1, 1), t)
save_fig_to_pdf(fullfile(plot_dir, 'stepresp_plot1'))

figure(2); clf
x_label = "Time ($t$)";
y_label = "Output $y(k)$";
make_stepresp_plot(sys(1, 2), t, y_label, x_label)

figure(3); clf
off_pct = 0;
make_stepresp_plot(sys(2, 1), t, "", "", [], off_pct)

figure(4); clf
y_lim = [-10 10];
u0 = 10;
title_text = "Step response";
kind = 'stairs';
intr = 'latex';
off_pct = 20;
make_stepresp_plot(sys(2, 2), t, y_label, x_label, y_lim, off_pct, u0, ...
      title_text, kind, intr)


%% Test MIMO step response plots


figure(5); clf
make_stepresp_plots(sys, t)
save_fig_to_pdf(fullfile(plot_dir, 'stepresp_plots'))

figure(6); clf
u_labels = {'A', 'B', 'C'};
y_labels = {'D', 'E'};
x_label = "Time ($t$)";
y_lims = [-10 10];
off_pct = 5;
U0 = 10;
make_stepresp_plots(sys, t, u_labels, y_labels, x_label, y_lims, ...
      off_pct, U0)

figure(7); clf
u_labels = {'A', 'B', 'C'};
y_labels = {'D', 'E'};
x_label = "Time";
y_lims = [-0.1 0.3; -1 1];
U0 = [-1 0.25 2]';
kind = 'stairs';
intr = 'none';
make_stepresp_plots(sys, t, u_labels, y_labels, x_label, y_lims, ...
      [], U0, kind, intr)


%% MIMO system example from ReadMe.md file

% Define 2x2 system
s = tf('s');
G11 = -0.7 / (1 + 8.5*s);
G12 = -G11;
G21 = 1.5 / (1 + 16*s);
G22 = G21;
Gc = [G11 G12; G21 G22];
Gc.InputName = ["CW flow", "HW flow"];
Gc.OutputName = ["Temperature", "Level"];

% Make into discrete system
Ts = 1;
Gd = c2d(Gc,Ts,'zoh');

% Plot step responses
figure(8)
nT = 100;
t = Ts*(0:nT)';
make_stepresp_plots(Gd, t)


