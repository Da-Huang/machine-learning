function [log_lambda err_in err_val err_out] = q16()
  log_lambda = 2:-1:-10;
  lambda = 10 .^ log_lambda;

  data = load('train13.dat');
  train = data(1:120, :);
  val = data(121:end, :);
  test = load('test13.dat');

  trainx = train(:, 1:end-1);
  trainy = train(:, end);
  valx = val(:, 1:end-1);
  valy = val(:, end);
  testx = test(:, 1:end-1);
  testy = test(:, end);

  ans.lambda = [];
  ans.err_in = [];
  ans.err_val = [];
  ans.err_out = [];

  for l = lambda
    ans.lambda(end+1) = l;
    w = reg(trainx, trainy, l);
    ans.err_in(end+1) = get_err(trainx, w, trainy);
    ans.err_val(end+1) = get_err(valx, w, valy);
    ans.err_out(end+1) = get_err(testx, w, testy);
  end

  [err_val i] = min(ans.err_val);
  err_in = ans.err_in(i);
  err_out = ans.err_out(i);
  log_lambda = log10(ans.lambda(i));
endfunction
