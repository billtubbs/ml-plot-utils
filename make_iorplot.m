function make_iorplot(Y, t, U, R, u_labels, y_labels, r_labels, ...
    x_label, y1_lim, y2_lim, titles_text, kind)
% make_iorplot(Y, t, U, R, u_labels, y_labels, r_labels, ...
%     x_label, y1_lim, y2_lim, titles_text, kind)
% Time series plot of input, output and reference
% signals

    if nargin < 12
        kind = 'plot';
    end
    if nargin < 11
        titles_text = {'(a) Outputs', '(b) Inputs'};
    end
    if nargin < 10
        y2_lim = nan(2);
    end
    if nargin < 9
        y1_lim = nan(2);
    end
    if nargin < 8
        x_label = '$t$';
    end
    switch kind
        case 'plot'
            plotf = @plot;
        case 'stairs'
            plotf = @stairs;
    end

    ax1 = subplot(2,1,1);

    % Custom outputs plot with reference signals
    ny = size(Y, 2);
    nr = size(R, 2);
    colors = get(ax1, 'ColorOrder');
    if ny > 1 || nr > 1
        colors(ny+1:ny+nr, :) = colors(1:ny, :);
    end
    set(ax1, 'ColorOrder', colors);

    plotf(t, Y, 'Linewidth', 2); hold on
    set(ax1, 'ColorOrder', colors);
    stairs(t, R, '--', 'Linewidth', 2)

    ylim(axes_limits_with_margin([Y R], 0.1, y1_lim, y1_lim))
    set(gca, 'TickLabelInterpreter', 'latex')

    labels = [y_labels r_labels];
    if numel(y_labels) > 2
        y_axis_labels = [y_labels(1), r_labels(1), {'... etc.'}];
        ylabel(strjoin(y_axis_labels, ', '), 'Interpreter', 'latex')
    else
        ylabel(strjoin(y_labels, ', '), 'Interpreter', 'latex')
    end
    if numel(labels) > 1
        legend(labels, 'Interpreter', 'latex', 'Location', 'best')
    end
    if titles_text{1}
        title(titles_text{1}, 'Interpreter', 'latex')
    end
    grid on

    ax2 = subplot(2,1,2);
    make_tsplot(U, t, u_labels, x_label, y2_lim, titles_text{2}, 'stairs')

    linkaxes([ax1, ax2], 'x')