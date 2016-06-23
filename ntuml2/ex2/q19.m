function [err_in err_out] = q19(gammas=[32 2 0.125], lambdas=[0.001 1 1000])
  data = load('data19.dat');
  train = data(1:400, :);
  trainx = train(:, 1:end-1);
  trainy = train(:, end);
  test = data(401:end, :);
  testx = test(:, 1:end-1);
  testy = test(:, end);

  for i = 1:size(gammas,2)
    for j = 1:size(lambdas,2)
      beta = train_lssvm(trainx, trainy, gammas(i), lambdas(j));
      err_in(i,j) = get_err(trainx, gammas(i), beta, trainx, trainy);
      err_out(i,j) = get_err(trainx, gammas(i), beta, testx, testy);
    end
  end
endfunction

function beta = train_lssvm(X, y, gamma, lambda)
  for i = 1:size(X,1)
    for j = 1:size(X,1)
      K(i,j) = kernel(X(i,:), X(j,:), gamma);
    end
  end
  beta = pinv(lambda * eye(size(K,1)) + K) * y;
endfunction

function err = get_err(trainx, gamma, beta, X, y)
  err = 0;
  for i = 1:size(X,1)
    err += predict_lssvm(trainx, gamma, beta, X(i,:)) != y(i);
  end
  err /= size(X,1);
endfunction

function y = predict_lssvm(trainx, gamma, beta, x)
  y = 0;
  for i = 1:size(trainx,1)
    y += beta(i) * kernel(trainx(i,:), x, gamma);
  end
  y = sign(y);
endfunction

function ans = kernel(x1, x2, gamma)
  d = x1 - x2;
  ans = exp(-gamma * d * d');
endfunction
