function [log_lambda err_cv err_in err_out] = q19(fold=5)
  log_lambda = 2:-1:-10;
  lambda = 10 .^ log_lambda;

  data = load('train13.dat');
  test = load('test13.dat');

  N = size(data, 1);
  Ni = N / fold;

  testx = test(:, 1:end-1);
  testy = test(:, end);

  ans.lambda = [];
  ans.err_cv = [];

  for l = lambda
    ans.lambda(end+1) = l;
    err = 0;
    for k = 1:Ni:N
      train = [data(1:k-1, :); data(k+Ni:end, :)];
      val = data(k:k+Ni-1, :);
      trainx = train(:, 1:end-1);
      trainy = train(:, end);
      valx = val(:, 1:end-1);
      valy = val(:, end);

      w = reg(trainx, trainy, l);
      err += get_err(valx, w, valy);
    end
    ans.err_cv(end+1) = err / fold;
  end

  [err_cv i] = min(ans.err_cv);
  lambda = ans.lambda(i);
  log_lambda = log10(lambda);
  trainx = data(:, 1:end-1);
  trainy = data(:, end);
  w = reg(trainx, trainy, lambda);
  err_in = get_err(trainx, w, trainy);
  err_out = get_err(testx, w, testy);
endfunction
