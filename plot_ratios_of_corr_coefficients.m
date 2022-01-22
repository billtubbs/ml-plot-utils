function plot_ratios_of_corr_coefficients(y,title_text,n)
    r = ratios_of_corr_coefficients(y,n);
    bar((1:n)',r); grid on
    xlabel('Lag')
    ylabel('$r_{yy}(l+1)/r_{yy}(l)$','Interpreter','Latex')
    title("Ratio of coefficients - " + title_text)
end