function err = q13(T=1000)
  total_err = 0;
  for i = 1:T
    [X y] = generate_data();
    X = [ones(size(X,1),1) X];
    w = pinv(X'*X) * X' * y;
    total_err += sum(sign(X * w) != y) / size(X,1);
  end
  err = total_err / T;
endfunction

function [X y] = generate_data(noise=0.1, N=1000)
  X = unifrnd(-1, 1, N, 2);
  y = sign(X(:, 1).^2 + X(:, 2).^2 - 0.6);
  y = y .* (1 - 2 .* (unifrnd(0, 1, N, 1) <= noise));
endfunction
