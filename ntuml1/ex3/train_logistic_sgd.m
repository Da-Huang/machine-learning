function w = train_logistic_sgd(X, y, eta, T=2000)
  N = size(X, 1);
  X = [ones(N,1) X];
  w = zeros(size(X,2), 1);
  j = 1;
  iter = 0;
  while (iter < T)
    delta = -y(j) * X(j)' * sigmoid(-y(j) * (X(j) * w));
    w = w - eta .* delta;
    iter += 1;
    j += 1;
    if (j > N)
      j = 1;
    end
  end
endfunction
