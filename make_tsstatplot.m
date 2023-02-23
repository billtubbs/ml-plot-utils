function make_tsstatplot(Y, t, y_labels, x_label, y_lim, area, line)
% make_tsstatplot(Y, t, y_labels, x_label, y_lim, area, line)
% Time-series plots of the statistics of groups of signals.
%
% Arguments
%   Y : array of group data or cell array of group data
%     arrays.
%   t : column vector of time values.
%   y_labels : label or cell array of labels for each data
%     group.
%   x_label : x-axis label (optional, default is '$t$')
%   y_lim : y-axis limits (optional, default is nan(2))
%   area : char indicating the statistics represented by
%     the fill area. Options include:
%      - 'minmax' for minimum and maximum values (this is
%        the default),
%      - 'std' for -/+ one standard deviation from mean,
%      - string representation of a percentile, e.g. '90'
%        for the 5 to 95 percent range.
%   line : char indicating the statistic represented by
%     the solid line. Options include:
%      - 'mean' for the mean value (this is the default),
%      - 'median' for the median value.
%
    if nargin < 7
        line = "mean";
    else
        line = string(line);
    end
    if nargin < 6
        area = "minmax";
    else
        area = string(area);
    end
    if nargin < 5
        y_lim = nan(2);
    end
    if nargin < 4
        x_label = "$t$";
    else
        x_label = string(x_label);
    end
    if isnumeric(Y)  % case of only one data group
        Y = {Y};
    end
    if nargin < 3
        if numel(Y) == 1
            y_labels = "$y(t)$";
        else
            y_labels = compose("$y_{%d}(t)$", 1:numel(Y));
        end
    else
        y_labels = string(y_labels);
    end
    % Arrays to store plot data
    Y_line = nan(size(Y{1}, 1), numel(Y));
    Y_upper = nan(size(Y{1}, 1), numel(Y));
    Y_lower = nan(size(Y{1}, 1), numel(Y));
    for iy = 1:numel(Y)
        switch area
            case 'minmax'
                Y_upper(:, iy) = max(Y{iy}, [], 2);
                Y_lower(:, iy) = min(Y{iy}, [], 2);
                area_label = 'min, max';
            case 'std'
                Y_avg = mean(Y{iy}, 2);
                Y_std = std(Y{iy}, [], 2);
                Y_upper(:, iy) = Y_avg + Y_std;
                Y_lower(:, iy) = Y_avg - Y_std;
                area_label = '+/- 1 std. dev.';
            otherwise
                pct = str2double(area);
                if isequaln(pct, [])
                    error("ValueError: invalid line type")
                end
                assert((pct > 0) & (pct < 100))
                pcts = [(100-pct)*0.5 100-(100-pct)*0.5];
                Y_lower_upper = prctile(Y{iy}', pcts)';
                Y_upper(:, iy) = Y_lower_upper(:, 2);
                Y_lower(:, iy) = Y_lower_upper(:, 1);
                area_label = char(sprintf('$%d\\%s$ CI', pct, '%'));
        end
        switch line
            case 'mean'
                Y_line(:, iy) = mean(Y{iy}, 2);
            case 'median'
                Y_line(:, iy) = median(Y{iy}, 2);
            otherwise
                error("ValueError: invalid line type")
        end
    end

    % Generate plot
    make_statplot(Y_line, Y_lower, Y_upper, t, x_label, y_labels, ...
        line, area_label, y_lim)

end