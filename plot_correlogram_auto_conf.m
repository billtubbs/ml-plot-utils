function plot_correlogram_auto_conf(y, title_text, maxlag)
    if nargin < 3
        maxlag = 20;
    end
    if nargin < 2
        title_text = 'Correlogram';
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
    ylim(axes_limits_with_margin(yc, 0.05))
    xlabel('Lag')
    ylabel('$r_{yy}$','Interpreter','Latex')
    grid on
    if char(title_text)
        title(title_text)
    end
    legend({'$r_{yy}$','$UCB(95\%)$','$LCB(95\%)$'},...
        'Interpreter','Latex','Location','best')
end