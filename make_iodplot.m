function make_iodplot(Y, Y_m, t, U, u_labels, y_labels, ...
    y1_lim, y2_lim, kind)
% make_iodplot(Y, Y_m, t, U, u_labels, y_labels, y1_lim, y2_lim, kind)
% Time series plot of input signal, true output signal and measured
% output data.
% 
    if nargin < 9
        kind = 'plot';
    end
    if nargin < 8
        y2_lim = nan(2);
    end
    if nargin < 7
        y1_lim = nan(2);
    end
    switch kind
        case 'plot'
            plotf = @plot;
        case 'stairs'
            plotf = @stairs;
    end

    ax1 = subplot(3,1,1:2);
    ny = size(Y_m, 2);
    colors = get(ax1, 'ColorOrder');
    if ny > 1
        colors(ny+1:ny*2, :) = colors(1:ny, :);
    end
    if size(Y_m, 1) < 100
        d_style = 'o';
    else
        d_style = '.';
    end
    set(ax1, 'ColorOrder', colors);
    plotf(t, Y, 'Linewidth', 2); hold on
    set(ax1, 'ColorOrder', colors);
    plot(t, Y_m, d_style)
    ylim(axes_limits_with_margin([Y Y_m], 0.1, y1_lim, y1_lim))
    set(gca, 'TickLabelInterpreter', 'latex')
    ylabel(string2latex(strjoin(y_labels, ', ')), 'Interpreter', ...
        'latex')
    if numel(y_labels) > 1
        legend(string2latex(y_labels), 'Interpreter', 'latex', ...
            'Location', 'best')
    end
    %title('(a) Outputs', 'Interpreter', 'latex')
    grid on

    ax2 = subplot(3,1,3);
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
    %title('(b) Inputs', 'Interpreter', 'latex')
    grid on

    linkaxes([ax1, ax2], 'x')