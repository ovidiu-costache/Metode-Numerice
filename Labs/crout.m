function [L, U] = crout(A)
    n = size(A, 1);
    L = zeros(n, n);
    U = eye(n);

    for p = 1:n
        for i = 1:p-1
            U(i, p) = (A(i, p) - L(i, 1:i) * U(1:i, p)) / L(i, i);
        endfor

        for i = p:n
            L(i, p) = A(i, p) - L(i, 1:i) * U(1:i, p);
        endfor
    endfor
end
