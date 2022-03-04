function make_tsplot(Y, t, y_labels, y_lim, title_text, kind)
% make_tsplot(Y, t, y_labels, y_lim, title, kind)
% Time series plot of one or more signals.

    if nargin < 6
        kind = 'plot';
    end
    if nargin < 5
        title_text = none;
    end
    if nargin < 4
        y_lim = nan(2);
    end
    switch kind
        case 'plot'
            plotf = @plot;
        case 'stairs'
            plotf = @stairs;
    end
    plotf(t, Y, 'Linewidth', 2);
    ylim(axes_limits_with_margin(Y, 0.1, y_lim, y_lim))
    set(gca, 'TickLabelInterpreter', 'latex')
    xlabel('$t$', 'Interpreter', 'Latex')
    ylabel(string2latex(strjoin(y_labels, ', ')), 'Interpreter', 'latex')
    if numel(y_labels) > 1
        legend(string2latex(y_labels), 'Interpreter', 'latex', ...
            'Location', 'best')
    end
    if title_text
        title(title_text, 'Interpreter', 'latex')
    end
    grid on
