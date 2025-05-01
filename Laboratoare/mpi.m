function [lambda, y, iter] = mpi(A, y, miu, maxiter, tol)
    y = y / norm(y);
    lambda = 0;
    A_inv = inv(A - miu * eye(size(A)));

    for iter = 1:maxiter
        z = A_inv * y;
        y_new = z / norm(z);
        lambda_new = y_new' * A * y_new;

        if norm(A * y_new - lambda_new * y_new) < tol
            lambda = lambda_new;
            y = y_new;
            return;
        endif

        lambda = lambda_new;
        y = y_new;
    endfor
endfunction
