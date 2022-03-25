function plot_correlogram_x_with_conf(y, u, title_text, maxlag)
    if nargin < 4
        maxlag = 20;
    end
    if nargin < 3
        title_text = 'Cross-Correlogram';
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
    ylim(axes_limits_with_margin(yc, 0.05))
    xlabel('Lag')
    ylabel('$r_{yu}$','Interpreter','Latex')
    grid on
    if char(title_text)
        title(title_text)
    end
    legend({'$r_{yu}$','$UCB(95\%)$','$LCB(95\%)$'},...
        'Interpreter','Latex','Location','best')
end