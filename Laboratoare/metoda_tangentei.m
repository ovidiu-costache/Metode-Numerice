function [c, k] = metoda_tangentei(x0, f, df, tol, max_iter)
    for k = 1:max_iter
        fx = f(x0);
        dfx = df(x0);
        if dfx == 0
            error('Derivata este zero. Metoda tangentei nu poate continua.');
        endif
        c = x0 - fx / dfx;
        if abs(c - x0) < tol || abs(f(c)) < tol
            return;
        endif
        x0 = c;
    endfor
endfunction

