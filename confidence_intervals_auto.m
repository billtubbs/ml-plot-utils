function [lconf, uconf] = confidence_intervals_auto(N, yc, maxlag, alpha)
    % See Eq.n C.34 in the notes
    assert(yc(maxlag+1) == 1)  % value for lag 0
    ryy = yc(maxlag+1:end-1);  % take positive lags only
    assert(all(size(ryy) == [maxlag 1]))
    temp = ones(size(ryy));
    temp(2:end) = sqrt(1+2*cumsum(ryy(1:end-1).^2));
    [lconf, uconf] = confidence_intervals_x(N, alpha);
    lconf = [0 lconf*temp'];
    uconf = [0 uconf*temp'];
end