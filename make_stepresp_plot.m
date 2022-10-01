function make_stepresp_plot(sys, t, y_label, x_label, y_lim, off_pct, ...
    u0, title_text, kind, intr)
% make_stepresp_plot(sys, t, y_label, x_label, y_lim, off_pct, u0, ...
%     title_text, kind, intr)
% Makes a single step response plot for a SISO system.
%
    arguments
        sys {issystem}
        t double
        y_label string = "$y(t)$"
        x_label string = "$t$"
        y_lim double = []
        off_pct double = []
        u0 double = 1
        title_text string = "";
        kind string = "plot"
        intr string = "latex"
    end

    % TODO: Not sure why these can't be added above
    if isempty(y_lim)
        y_lim = nan(1, 2);
    end
    if isempty(off_pct)
        off_pct = 10;
    end

    % Custom step input options
    nT = length(t) - 1;
    i_off = floor(nT * off_pct / 100);
    t_step = t(i_off + 1);
    U = zeros(size(t));
    U(t >= t_step) = u0;

    % Simulate step response
    [Y, t] = lsim(sys, U, t);

    make_tsplot(Y, t, {y_label}, x_label, y_lim, title_text, kind, intr)

end
