function plot_correlogram_auto_conf(y, title_text, maxlag, intr)
    if nargin < 4
        intr = 'latex';
    end
    if nargin < 3
        maxlag = 20;
    end
    if nargin < 2
        title_text = "Correlogram";
    else
        title_text = string(title_text);
    end
    [yc, lags] = xcov(y, maxlag, 'coeff');
    assert(lags(maxlag+1) == 0)
    assert(yc(maxlag+1) == 1)
    N = length(y);
    [lconf, uconf] = confidence_intervals_auto(N, yc, maxlag, 0.95);
    yc = yc(maxlag+1:end);  % only show positive lags
    lags = lags(maxlag+1:end);
    if maxlag >= 100
        style = '.-';
    else
        style = 'o-';
    end
    stem(lags, yc, style, 'filled')
    hold on
    plot(lags, [uconf;lconf], 'r')
    ylim(axes_limits_with_margin(yc, 0.05, [0 0]))
    set(gca, 'TickLabelInterpreter', intr)
    xlabel("Lag", 'Interpreter', intr)
    ylabel("$r_{yu}$", 'Interpreter', intr)
    grid on
    if strlength(title_text) > 0
        title(title_text, 'Interpreter', intr)
    end
    legend({'$r_{yy}$', '$UCB(95\%)$', '$LCB(95\%)$'}, ...
        'Interpreter', intr, 'Location', 'best')
end