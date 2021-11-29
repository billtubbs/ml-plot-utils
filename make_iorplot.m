function make_iorplot(Y, t, U, R, u_labels, y_labels, r_labels, ...
    y1_lim, y2_lim, kind)
% make_iorplot(Y, t, U, R, u_labels, y_labels, r_labels, ...
%     y1_lim, y2_lim, kind)
% Time series plot of input, output and reference
% signals

    if nargin < 10
        kind = 'plot';
    end
    if nargin < 9
        y2_lim = nan(2);
    end
    if nargin < 8
        y1_lim = nan(2);
    end
    switch kind
        case 'plot'
            plotf = @plot;
        case 'stairs'
            plotf = @stairs;
    end

    ax1 = subplot(2,1,1);
    ny = size(Y, 2);
    nr = size(R, 2);
    colors = get(ax1, 'ColorOrder');
    colors(ny+1:ny+nr, :) = colors(1:ny, :);
    set(ax1, 'ColorOrder', colors);
    plotf(t, Y, 'Linewidth', 2); hold on
    set(ax1, 'ColorOrder', colors);
    stairs(t, R, '--')
    ylim(axes_limits_with_margin([Y R], 0.1, y1_lim, y1_lim))
    set(gca, 'TickLabelInterpreter', 'latex')
    xlabel('$t$', 'Interpreter', 'Latex')
    ylabel(string2latex(strjoin([r_labels y_labels], ', ')), ...
        'Interpreter', 'latex')
    labels = [y_labels r_labels];
    if numel(labels) > 1
        legend(string2latex(labels), 'Interpreter', 'latex', ...
            'Location', 'best')
    end
    title('(a) Outputs', 'Interpreter', 'latex')
    grid on

    ax2 = subplot(2,1,2);
    stairs(t, U, 'Linewidth', 2)
    ylim(axes_limits_with_margin(U, 0.1, y2_lim, y2_lim))
    set(gca, 'TickLabelInterpreter', 'latex')
    xlabel('$t$', 'Interpreter', 'latex')
    if numel(u_labels) > 3
        u_labels_yaxis = [u_labels(1), {'...'}, u_labels(end)];
    else
        u_labels_yaxis = u_labels;
    end
    ylabel(string2latex(strjoin(u_labels_yaxis, ', ')), 'Interpreter', 'latex')
    if numel(u_labels) > 1
        legend(string2latex(u_labels), 'Interpreter', 'latex', ...
            'Location', 'best')
    end
    title('(b) Inputs', 'Interpreter', 'latex')
    grid on

    linkaxes([ax1, ax2], 'x')