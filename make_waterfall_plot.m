function p = make_waterfall_plot(t, Z, z_lim, ax_labels, view_angles)
% p = make_waterfall_plot(t, Z, z_minmax, ax_labels, view_angles)
% Make a Waterfall plot in current axis showing the
% time series in Z (y and z axes) over time t (x-axis).
%
% Arguments:
%   t : Time vector (1 column).
%   Z : Time series data in columns.
%   z_lim : Limits for z axis [min max].
%   ax_labels : cell array of labels for x, y, z axes.
%   view_angles : (optional) array [az el] containing azimuth and
%       elevation angles of plot view (degrees). If not
%       [0 84] is used.
%

    if nargin < 5
        view_angles = [0 84];
    end
    n_series = size(Z, 2);
    [X, Y] = meshgrid(t', 1:n_series);
    p = waterfall(X, Y, Z', Y);
    ylim([1 n_series])
    yticks(1:n_series)
    xlabel(ax_labels{1}, 'Interpreter', 'Latex')
    ylabel(ax_labels{2}, 'Interpreter', 'Latex')
    zlabel(ax_labels{3}, 'Interpreter', 'Latex')
    zlim(z_lim);
    set(gca, 'TickLabelInterpreter', 'latex')
    set(p, 'FaceColor', 'flat');
    set(p, 'EdgeColor', 'k');
    set(p, 'FaceVertexCData', sqrt(parula(n_series)));
    set(p, 'FaceAlpha', 0.75)

    % Default viewing angles are view(-37.5, 30)
    % From front at high angle from above: view(0, 85)
    view(view_angles)

end