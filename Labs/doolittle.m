function [L, U] = doolittle(A)
    n = size(A, 1);
    L = eye(n);
    U = zeros(n, n);

    for p = 1:n
        for i = 1:p
            U(i, p) = A(i, p) - L(i, 1:i) * U(1:i, p);
        endfor

        for i = p+1:n
            L(i, p) = (A(i, p) - L(i, 1:i) * U(1:i, p)) / U(p, p);
        endfor
    endfor
end
