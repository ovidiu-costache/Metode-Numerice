function [Q, R] = Givens_3diag(A)
    [m, n] = size(A);
    Q = eye(m);
    R = A;

    for i = 1:m-1
        if R(i+1, i) ~= 0
            % parametrii rotatiei Givens
            r = sqrt(R(i, i)^2 + R(i+1, i)^2);
            c = R(i, i) / r;
            s = -R(i+1, i) / r;

            % matricea de rotatie
            G = eye(m);
            G([i, i+1], [i, i+1]) = [c, -s; s, c];

            R = G' * R;
            Q = Q * G';
        end
    end
endfunction

