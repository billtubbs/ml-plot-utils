function plot_correlogram_x_with_conf(y, u, title_text, maxlag)
    [yc,lags] = xcov(y,u,maxlag,'coeff');
    N = length(y);
    assert(length(u) == N)
    [lconf, uconf] = confidence_intervals_x(N, 0.95);
    if maxlag >= 50
        style = '.-';
    else
        style = 'o-';
    end
    stem(lags,yc,style,'filled')
    hold on
    plot(lags,[uconf;lconf]*ones(size(lags)),'r')
    xlabel('Lag')
    ylabel('$r_{yu}$','Interpreter','Latex')
    grid on
    title("Correlogram - " + title_text)
    legend({'$r_{yu}$','$UCB(95\%)$','$LCB(95\%)$'},...
        'Interpreter','Latex','Location','best')
end