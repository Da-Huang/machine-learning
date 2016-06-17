function [log_lambda err_in err_out] = q15()
  log_lambda = 2:-1:-10;
  lambda = 10 .^ log_lambda;

  train = load('train13.dat');
  trainx = train(:, 1:end-1);
  trainy = train(:, end);
  test = load('test13.dat');
  testx = test(:, 1:end-1);
  testy = test(:, end);

  ans.lambda = [];
  ans.err_in = [];
  ans.err_out = [];

  for l = lambda
    ans.lambda(end+1) = l;
    w = reg(trainx, trainy, l);
    ans.err_in(end+1) = get_err(trainx, w, trainy);
    ans.err_out(end+1) = get_err(testx, w, testy);
  end

  [err_out i] = min(ans.err_out);
  err_in = ans.err_in(i);
  log_lambda = log10(ans.lambda(i));
endfunction
