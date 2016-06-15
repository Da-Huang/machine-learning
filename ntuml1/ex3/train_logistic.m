function w = train_logistic(X, y, eta, T=2000)
  N = size(X, 1);
  X = [ones(N,1) X];
  w = zeros(size(X,2), 1);
  for i=1:T
    delta = 1 ./ N .* bsxfun(@times, -y, X)' * sigmoid(-y .* (X * w));
    w = w - eta .* delta;
  end
endfunction
