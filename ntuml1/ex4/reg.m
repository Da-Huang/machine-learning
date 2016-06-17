function w = reg(X, y, lambda)
  X = [ones(size(X,1),1) X];
  w = pinv(X' * X + lambda * eye(size(X,2))) * X' * y;
endfunction
