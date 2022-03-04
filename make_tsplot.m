function make_tsplot(Y, t, y_labels, x_label, y_lim, title_text, kind)
% make_tsplot(Y, t, y_labels, x_label, y_lim, title_text, kind)
% Time series plots of one or more signals.

    if nargin < 7
        kind = 'plot';
    end
    if nargin < 6
        title_text = none;
    end
    if nargin < 5
        y_lim = nan(2);
    end
    if nargin < 4
        x_label = '$t$';
    end
    switch kind
        case 'plot'
            plotf = @plot;
        case 'stairs'
            plotf = @stairs;
    end
    if ~iscell(y_labels)
        y_labels = {y_labels};
    end
    plotf(t, Y, 'Linewidth', 2);
    ylim(axes_limits_with_margin(Y, 0.1, y_lim, y_lim))
    set(gca, 'TickLabelInterpreter', 'latex')
    if x_label
        xlabel(x_label, 'Interpreter', 'Latex')
    end
    if numel(y_labels) > 3
        y_axis_labels = [y_labels(1), {'...'}, y_labels(end)];
        ylabel(strjoin(y_axis_labels, ', '), 'Interpreter', 'latex')
    else
        ylabel(strjoin(y_labels, ', '), 'Interpreter', 'latex')
    end
    if numel(y_labels) > 1
        legend(y_labels, 'Interpreter', 'latex', 'Location', 'best')
    end
    if title_text
        title(title_text, 'Interpreter', 'latex')
    end
    grid on
