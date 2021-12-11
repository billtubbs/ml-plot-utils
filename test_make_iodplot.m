% Test function make_iodplot.m

clear all; close all


%% discrete-time SISO system
Ts = 0.5;
nT = 10;
t = Ts*(0:nT)';
U = zeros(nT+1,1);
U(t >= 1, :) = 1;
G = tf(1, [1 1], Ts);
[Y, t] = lsim(G,U,t);
Y_m = Y + 0.1*randn(size(Y));  % add measurement noise
u_labels = {'u(t)'};
y_labels = {'y(t)', 'y_m(t)'};

figure(1)
make_iodplot(Y, Y_m, t, U, u_labels, y_labels, nan(2), nan(2), 'stairs')


%% Continuous-time 2x2 system
t = linspace(0, 10, 101)';
nT = size(t, 1) - 1;
U = zeros(nT+1,2);
U(t >= 1, 1) = 1;
U(t >= 3, 2) = -1;
G = [tf(1, [1 1]) 0;
     0            tf(1, [2 1])];
[Y, t] = lsim(G,U,t);
Y_m = Y + 0.1*randn(size(Y));  % add measurement noise
u_labels = {'u_1(t)', 'u_2(t)'};
y_labels = {'y_1(t)', 'y_2(t)', 'y_{m,1}(t)', 'y_{m,2}(t)'};

figure(2)
make_iodplot(Y, Y_m, t, U, u_labels, y_labels)