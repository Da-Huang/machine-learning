function q12(T=300)
  train = load('train12.dat');
  trainx = train(:, 1:end-1);
  trainy = train(:, end);
  test = load('test12.dat');
  testx = test(:, 1:end-1);
  testy = test(:, end);
  u = ones(size(trainx,1), 1) / size(trainx,1);
  min_err = -1;
  for t = 1:T
    if t == 2
      disp('U2=');
      disp(sum(u));
    end
    [s i theta err] = train_stump(trainx, trainy, u);
    g.s(end+1) = s;
    g.i(end+1) = i;
    g.theta(end+1) = theta;
    g.err(end+1) = err;
    if min_err < 0 || min_err > err
      min_err = err;
    end
    correct = 2 * (trainx(:,i) - theta >= 0) - 1 == trainy;
    delta = sqrt((1 - err) / err);
    u(correct) /= delta;
    u(!correct) *= delta;
    g.alpha(end+1) = log(delta);
  end
  disp('UT=');
  disp(sum(u));
  disp('Ein(g1)=');
  disp(g.err(1));
  disp('min_err=');
  disp(min_err);
  disp('Eout(g1)=');
  disp(get_err(testx, testy, g.s(1), g.i(1), g.theta(1), ones(size(testx,1),1)))
  disp('Ein(G)=')
  disp(get_ada_err(trainx, trainy, g));
  disp('Eout(G)=')
  disp(get_ada_err(testx, testy, g));
endfunction

function [s i theta err] = train_stump(X, y, u)
  best_err = -1;
  N = size(X, 1);
  for i = 1:size(X,2)
    subx = X(:, i);
    [subx xi] = sort(subx);
    suby = y(xi);
    for k = 0:N
      if k == 0
        theta = -inf;
      elseif k == N
        theta = inf;
      else
        theta = mean([subx(k) subx(k+1)]);
      end
      for s = [-1 1]
        err = get_err(X, y, s, i, theta, u);
        if best_err < 0 || best_err > err
          best_err = err;
          best_s = s;
          best_i = i;
          best_theta = theta;
        end
      end
    end
  end
  err = best_err;
  s = best_s;
  i = best_i;
  theta = best_theta;
endfunction

function [err u] = get_err(X, y, s, i, theta, u)
  err = sum((2 * s * (X(:,i) - theta >= 0) - 1 != y) .* u) / sum(u);
endfunction

function err = get_ada_err(X, y, g)
  h = zeros(size(X,1), 1);
  for i = 1:size(g.s, 2)
    h += g.alpha(i) * (g.s(i) * (X(:,g.i(i)) - g.theta(i) >= 0) - 1);
  end
  err = sum(2 * (h >= 0) - 1 == y) / size(X,1);
endfunction
