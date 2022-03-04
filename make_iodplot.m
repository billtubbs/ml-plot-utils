function make_iodplot(Y, Y_m, t, U, u_labels, y_labels, ...
    x_label, y1_lim, y2_lim, titles_text, kind)
% make_iodplot(Y, Y_m, t, U, u_labels, y_labels, ...
%     x_label, y1_lim, y2_lim, titles_text, kind)
% Time series plot of input signal, true output signal and measured
% output data.
%
    if nargin < 11
        kind = 'plot';
    end
    if nargin < 10
        titles_text = {'(a) Outputs', '(b) Inputs'};
    end
    if nargin < 9
        y2_lim = nan(2);
    end
    if nargin < 8
        y1_lim = nan(2);
    end
    if nargin < 7
        x_label = '$t$';
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
    if numel(y_labels) > 2
        y_axis_labels = [y_labels(1), y_labels(2), {'... etc.'}];
        ylabel(strjoin(y_axis_labels, ', '), 'Interpreter', 'latex')
    else
        ylabel(strjoin(y_labels, ', '), 'Interpreter', 'latex')
    end
    if numel(y_labels) > 1
        legend(y_labels, 'Interpreter', 'latex', 'Location', 'best')
    end
    if titles_text{1}
        title(titles_text{1}, 'Interpreter', 'latex')
    end
    grid on

    ax2 = subplot(3,1,3);
    make_tsplot(U, t, u_labels, x_label, y2_lim, titles_text{2}, 'stairs')

    linkaxes([ax1, ax2], 'x')