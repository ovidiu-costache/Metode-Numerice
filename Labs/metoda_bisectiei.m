function [c, k] = metoda_bisectiei(a, b, f, tol, max_iter)
    k = -1;
    if f(a) == 0
        c = a;
        return;
    elseif f(b) == 0
        c = b;
        return;
    end
    for k = [1 : max_iter]
        c = (a + b) / 2;
        if abs(c - a) < tol
            return
        endif
        val_a = f(a);
        val_c = f(c);
        if abs(val_c) < tol
            return
        elseif val_a * val_c < 0
            b = c;
        else
            a = c;
        end
    endfor
endfunction
