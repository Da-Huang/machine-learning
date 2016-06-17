function err = get_err(X, w, y)
  X = [ones(size(X,1),1) X];
  err = sum(sign(X * w) != y) / size(X, 1);
endfunction
