function [FeatureMatrix] = prepare_for_regression(InitialMatrix)
  [m, n] = size(InitialMatrix);

  % calculez nr de coloane extra
  extra = 0;
  for j = 1:n
    elem = InitialMatrix{1, j};
    if strcmp(elem, "semi-furnished") != 0 || strcmp(elem, "unfurnished") != 0 || strcmp(elem, "furnished") != 0
      extra = extra + 1;
    endif
  endfor

  FeatureMatrix = zeros(m, n + extra);

  for i = 1:m
    col = 1;
    for j = 1:n
      elem = InitialMatrix{i, j};

      if strcmp(elem, "semi-furnished") != 0 || strcmp(elem, "unfurnished") != 0 || strcmp(elem, "furnished") != 0
        if strcmp(elem, "semi-furnished") != 0
          FeatureMatrix(i, col) = 1;
          FeatureMatrix(i, col + 1) = 0;
        elseif strcmp(elem, "unfurnished") != 0
          FeatureMatrix(i, col) = 0;
          FeatureMatrix(i, col + 1) = 1;
        else
          FeatureMatrix(i, col) = 0;
          FeatureMatrix(i, col + 1) = 0;
        endif
        col = col + 2; % trecem 2 coloane inainte pt ca a fost facuta codificarea pe 2 coloane
      else
        if strcmp(elem, "yes") != 0
          FeatureMatrix(i, col) = 1;
        elseif strcmp(elem, "no") != 0
          FeatureMatrix(i, col) = 0;
        else
          % daca elementul nu este un string
          FeatureMatrix(i, col) = str2double(elem);
        endif
        col = col + 1;
      endif
    endfor
  endfor
end
