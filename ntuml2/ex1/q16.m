function q16()
  addpath('../../libsvm/matlab');
  train = load('train16.dat');
  X = train(:,2:end);
  y = 2 * (train(:,1) == 0) - 1;
  model = svmtrain(y, X, '-s 0 -t 0 -c 0.01 -h 0 -q');
  w = model.SVs' * model.sv_coef;
  norm(w)
endfunction
