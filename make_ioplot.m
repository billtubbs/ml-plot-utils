function make_ioplot(Y, t, U, u_labels, y_labels, x_label, y1_lim, ...
    y2_lim, titles_text, kind)
% make_ioplot(Y, t, U, u_labels, y_labels, x_label, y1_lim, ...
%     y2_lim, titles_text, kind)
% Time series plots of input and output signals

    if nargin < 10
        kind = 'plot';
    end
    if nargin < 9
        titles_text = {'(a) Outputs', '(b) Inputs'};
    end
    if nargin < 8
        y2_lim = nan(2);
    end
    if nargin < 7
        y1_lim = nan(2);
    end
    if nargin < 6
        x_label = '$t$';
    end

    ax1 = subplot(2,1,1);
    make_tsplot(Y, t, y_labels, [], y1_lim, titles_text{1}, kind)

    ax2 = subplot(2,1,2);
    make_tsplot(U, t, u_labels, x_label, y2_lim, titles_text{2}, 'stairs')

    linkaxes([ax1, ax2], 'x')
