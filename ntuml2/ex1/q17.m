function q17(digits=[0 2 4 6 8])
  addpath('../../libsvm/matlab');
  train = load('train16.dat');
  X = train(:,2:end);
  err = [];
  alpha_sum = [];
  for digit = digits
    y = 2 * (train(:,1) == digit) - 1;
    model = svmtrain(y, X, '-s 0 -t 1 -d 2 -g 1 -r 1 -c 0.01 -h 0 -q');
    [l acc p] = svmpredict(y, X, model, '-q');
    err(end+1) = 1 - acc(1) / 100;
    alpha_sum(end+1) = model.sv_coef' * y(model.sv_indices);
  end
  err
  [err erri] = min(err);
  digits(erri)
  alpha_sum
  [alpha_sum alpha_sumi] = max(alpha_sum);
endfunction
