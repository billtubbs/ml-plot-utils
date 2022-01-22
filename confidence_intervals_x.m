function [lconf, uconf] = confidence_intervals_x(N, alpha)
    % See Eq.n C.33 in the notes
    vcrit = sqrt(2)*erfinv(alpha);
    uconf = vcrit/sqrt(N);
    lconf = -uconf;
end