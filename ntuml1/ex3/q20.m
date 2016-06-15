function err = q20()
  train = load('train18.dat');
  test = load('test18.dat');

  trainx = train(:, 1:end-1);
  trainy = train(:, end);
  w = train_logistic_sgd(trainx, trainy, eta=0.01);
  trainx = [ones(size(trainx,1),1) trainx];

  testx = test(:, 1:end-1);
  testy = test(:, end);
  testx = [ones(size(testx,1),1) testx];
  err = sum(sign(testx * w) != testy) / size(testx, 1);
endfunction
