function a = make_area_step_plot(x, Y, varargin)
% make_area_step_plot(x, Y, varargin)
% makes a stacked area plot with discrete step-changes similar
% to a stairs plot.
%
% Arguments
%   x : column vector (nx, 1)
%     x-values of steps, including the end of the last step.
%   Y : column vector or matrix (nx, ny) or (nx-1, ny)
%     y-values of steps. If Y has the same number of rows as
%     x, the last row is ignored because the second-last step
%     ends at x(end).
%   varargin : cell
%     Other arguments to pass to built-in area plot function.
%
% Example:
% >> x = (1:10)';
% >> Y = rand(10, 3);  % Note: last row is not plotted
% >> make_area_step_plot(x, Y)
%
    assert(size(x, 2) == 1)
    nx = size(x, 1);
    Y = Y(1:nx-1, :);  % final y-values are not used
    ny = size(Y, 2);
    X = [x x]';
    X2 = X(2:end-1)';
    Y2 = reshape(permute(cat(3, Y, Y), [3 1 2]), [], ny);
    a = area(X2, Y2, varargin{:});
end