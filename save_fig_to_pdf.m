function save_fig_to_pdf(filename, h)
% save_fig_to_pdf(filename, h)
% Saves a pdf document of the current figure with the paper
% size adjusted to the size of the figure.
    if nargin < 2
        h = gcf;
    end
    set(h, 'Units', 'Inches');
    pos = get(h, 'Position');
    set(h, 'PaperPositionMode', 'Auto', 'PaperUnits', 'Inches', ...
        'PaperSize', [pos(3), pos(4)])
    print(h, filename, '-dpdf', '-r0')
end