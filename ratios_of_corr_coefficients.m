function r = ratios_of_corr_coefficients(y,n)
    [yc,lags] = xcov(y,n+1,'coeff');
    l = find((lags >=0) & (lags <= n));
    r = yc(l+1) ./ yc(l);
    r = r(1:end-1);
end