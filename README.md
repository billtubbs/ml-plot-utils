# ml-plot-utils
MATLAB scripts to facilitate common plotting tasks for data from dynamical systems simulations.  All the plots use Latex fonts.

## Contents

Main plot functions

- [make_tsplot.m](make_tsplot.m) - Single time series plot of one or more signals
- [make_ioplot.m](make_ioplot.m) - Two time series plots of input and output signals
- [make_iorplot.m](make_iorplot.m) - Two time series plots of input, output and reference signals
- [make_iodplot.m](make_iodplot.m) - Two time series plots of input signal, true output signal, and measured output data
- [make_iodmplot.m](make_iodmplot.m) - Two time series plots of input signal, true output signal, measured output data, and model output
- [make_tsstatplot.m](make_tsstatplot.m) - Two time-series plots of the statistics of groups of signals to show variation
- [plot_correlogram_auto_conf.m](plot_correlogram_auto_conf.m) - Correlogram of auto-correlation coefficients incl. confidence limits
- [plot_correlogram_x_with_conf.m](plot_correlogram_x_with_conf.m) - Correlogram of cross-correlation coefficients incl. confidence limits
- [plot_ratios_of_corr_coefficients.m](plot_ratios_of_corr_coefficients.m) - Bar plot of ratios of consecutive correlation coefficients.
- [show_waterfall_plot.m](show_waterfall_plot.m) - Waterfall plot of multiple time series

Utility functions

- [axes_limits_with_margin.m](axes_limits_with_margin.m) - Calculates new axes limits based on the extreme values in the data with the option to add margins and a minimum range
- [confidence_intervals_auto.m](confidence_intervals_auto.m) - Calculate lower and upper confidence limits for auto-correlation coefficients
- [confidence_intervals_x.m](confidence_intervals_x.m) - Calculate lower and upper confidence limits for cross-correlation coefficients
- [matrix_element_labels.m](matrix_element_labels.m) - Creates a cell array of labels with subscripts to represent the elements of a matrix
- [ratios_of_corr_coefficients.m](ratios_of_corr_coefficients.m) - Calculates the ratios of correlation coefficients
- [save_fig_to_pdf.m](save_fig_to_pdf.m) - Saves a pdf document of the current figure with the paper size adjusted to correct size
- [string2latex.m](string2latex.m) - Converts a string or a cell array of strings to latex input format
- [vector_element_labels.m](vector_element_labels.m) - Creates a cell array of labels with subscripts

Test scripts

- [test_axes_limits_with_margin.m](test_axes_limits_with_margin.m)
- [test_make_iodplot.m](test_make_iodplot.m)
- [test_make_ioplot.m](test_make_ioplot.m)
- [test_make_iorplot.m](test_make_iorplot.m)
- [test_make_tsstatplot.m](test_make_tsstatplot.m)
- [test_matrix_element_labels.m](test_matrix_element_labels.m)
- [test_string2latex.m](test_string2latex.m)
- [test_vector_element_labels.m](test_vector_element_labels.m)
