function plot_correlogram_auto_conf(y, title_text, maxlag)
    [yc,lags] = xcov(y,maxlag,'coeff');
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
    stem(lags,yc,style,'filled')
    hold on
    plot(lags,[uconf;lconf],'r')
    xlabel('Lag')
    ylabel('$r_{yy}$','Interpreter','Latex')
    grid on
    title("Correlogram - " + title_text)
    legend({'$r_{yy}$','$UCB(95\%)$','$LCB(95\%)$'},...
        'Interpreter','Latex','Location','best')
end