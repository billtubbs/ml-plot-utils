function [lconf, uconf] = confidence_intervals_x(N, alpha)
% [lconf, uconf] = confidence_intervals_x(N, alpha)
% Calculate lower and upper confidence limits for cross-
% correlation coefficients.

    % See Eq.n C.33 in the course notes
    vcrit = sqrt(2)*erfinv(alpha);
    uconf = vcrit/sqrt(N);
    lconf = -uconf;

end