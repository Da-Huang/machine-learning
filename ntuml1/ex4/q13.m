function [err_in err_out] = q13(lambda=10)
  train = load('train13.dat');
  trainx = train(:, 1:end-1);
  trainy = train(:, end);
  w = reg(trainx, trainy, lambda);
  err_in = get_err(trainx, w, trainy);

  test = load('test13.dat');
  testx = test(:, 1:end-1);
  testy = test(:, end);
  err_out = get_err(testx, w, testy);
endfunction
