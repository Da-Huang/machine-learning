function w = q14()
  [X y] = generate_data();
  X = [ones(size(X,1),1) X(:,1) X(:,2) X(:,1).*X(:,2) X(:,1).^2 X(:,2).^2];
  w = pinv(X'*X) * X' * y;
endfunction

function [X y] = generate_data(noise=0.1, N=1000)
  X = unifrnd(-1, 1, N, 2);
  y = sign(X(:, 1).^2 + X(:, 2).^2 - 0.6);
  y = y .* (1 - 2 .* (unifrnd(0, 1, N, 1) <= noise));
endfunction
