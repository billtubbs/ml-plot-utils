function make_stepresp_plots(sys, t, u_labels, y_labels, x_label, y_lims, off_pct, U0, kind, intr)
% make_stepresp_plots(sys, t, u_labels, y_labels, x_label, y_lims, ...
%     off_pct, U0, kind, intr)
% Makes a matrix of step response plots for a MIMO 
% system.
%
    arguments
        sys {issystem}
        t double
        u_labels string = []
        y_labels string = []
        x_label string = "$t$"
        y_lims double = []
        off_pct double = 10
        U0 (:, 1) double = 1
        kind string = "plot"
        intr string = "latex"
    end

    if isempty(u_labels)
        if strcmp(intr, "latex")
            u_labels = string(escape_latex_chars(sys.InputName));
        else
            u_labels = string(sys.InputName);
        end
        missing_u_labels = ~strcmp(u_labels, '');
    end
    if isempty(y_labels)
        if strcmp(intr, "latex")
            y_labels = string(escape_latex_chars(sys.OutputName));
        else
            u_labels = string(sys.OutputName);
        end
    end

    % Number of inputs and outputs
    nu = numel(u_labels);
    ny = numel(y_labels);

    if isempty(y_lims)
        y_lims = nan(ny, 2);
    end
    if size(y_lims, 1) == 1
        y_lims = repmat(y_lims, ny, 1);
    end
    if isscalar(U0)
        U0 = repmat(U0, nu, 1);
    end

    k = 1;
    for i = 1:ny
        for j = 1:nu
            subplot(ny, nu, k)
            if i == ny
                xl = string(x_label);
            else
                xl = "";
            end
            if i == 1
                title_text = u_labels(j);
            else
                title_text = "";
            end
            if j == 1
                yl = y_labels(i);
            else
                yl = "";
            end
            u0 = U0(j);
            make_stepresp_plot(sys(i, j), t, yl, xl, y_lims(i, :), ...
                off_pct, u0, title_text, kind, intr);
            % Turned this off because it doesn't save space
            % and doesn't look great.
%             if i < ny && ~any(isnan(y_lims(2, :)))
%                 % Don't show x-axis tick labels
%                 set(gca, 'xticklabel', [])
%             end
%             if j > 1
%                 % Don't show y-axis tick labels
%                 set(gca, 'yticklabel', [])
%             end
            k = k + 1;
        end
    end

end
