function q19(gammas=[1 10 100 1000 10000])
  addpath('../../libsvm/matlab');
  train = load('train16.dat');
  trainx = train(:,2:end);
  trainy = 2 * (train(:,1) == 0) - 1;
  test = load('test16.dat');
  testx = test(:,2:end);
  testy = 2 * (test(:,1) == 0) - 1;

  err = [];
  for gamma = gammas
    model = svmtrain(trainy, trainx, cstrcat('-s 0 -t 2 -c 0.1 -h 0 -q -g ', mat2str(gamma)));
    [l acc p] = svmpredict(testy, testx, model, '-q');
    err(end+1) = 1 - acc(1) / 100;
  end
  err
  [err erri] = min(err);
  gammas(erri)
endfunction
