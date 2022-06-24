function plot_correlogram_x_with_conf(y, u, title_text, maxlag, intr)
    if nargin < 5
        intr = 'latex';
    end
    if nargin < 4
        maxlag = 20;
    end
    if nargin < 3
        title_text = "Cross-Correlogram";
    else
        title_text = string(title_text);
    end
    [yc, lags] = xcov(y, u, maxlag, 'coeff');
    N = length(y);
    assert(length(u) == N)
    [lconf, uconf] = confidence_intervals_x(N, 0.95);
    if maxlag >= 50
        style = '.-';
    else
        style = 'o-';
    end
    stem(lags, yc, style, 'filled')
    hold on
    plot(lags, [uconf;lconf]*ones(size(lags)), 'r')
    ylim(axes_limits_with_margin(yc, 0.05, [0 0]))
    set(gca, 'TickLabelInterpreter', intr)
    xlabel("Lag", 'Interpreter', intr)
    ylabel("$r_{yu}$", 'Interpreter', intr)
    grid on
    if strlength(title_text) > 0
        title(title_text, 'Interpreter', intr)
    end
    legend({'$r_{yu}$', '$UCB(95\%)$', '$LCB(95\%)$'}, ...
        'Interpreter', intr, 'Location', 'best')
end