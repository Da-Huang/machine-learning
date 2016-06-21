function q20(gammas=[1 10 100 1000 10000])
  addpath('../../libsvm/matlab');
  data = load('train16.dat');

  times = zeros(1, size(gammas,2));
  for i = 1:100
    [gamma gammai] = select_gamma(data, gammas);
    times(gammai) += 1;
  end
  [t ti] = max(times);
  gammas(ti)
endfunction

function [gamma gammai] = select_gamma(data, gammas);
  ri = randperm(size(data,1));
  val = data(ri(1:1000),:);
  valx = val(:,2:end);
  valy = 2 * (val(:,1) == 0) - 1;
  train = data(ri(1001:end),:);
  trainx = train(:,2:end);
  trainy = 2 * (train(:,1) == 0) - 1;

  err = [];
  for gamma = gammas
    model = svmtrain(trainy, trainx, cstrcat('-s 0 -t 2 -c 0.1 -h 0 -q -g ', mat2str(gamma)));
    [l acc p] = svmpredict(valy, valx, model, '-q');
    err(end+1) = 1 - acc(1) / 100;
  end
  [err gammai] = min(err);
  gamma = gammas(gammai);
endfunction
