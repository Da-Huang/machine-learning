function [err_in err_out] = q19()
  train = load('train19.txt');
  test = load('test19.txt');

  trainx = train(:, 1:end-1);
  trainy = train(:, end) > 0;
  best = n_decision_stump(trainx, trainy);
  err_in = best.err;
  besti = unidrnd(length(best));
  s = best.s(besti);
  theta = best.theta(besti);
  i = best.i(besti);

  testxi = test(:, i);
  testy = test(:, end) > 0;
  err_out = get_err(testxi, testy, s, theta);
endfunction

function best = n_decision_stump(x, y)
  % x is input
  % y is output

  best.err = -1;
  best.s = [];
  best.theta = [];
  best.i = [];

  for i = 1:size(x, 2)
    xi = x(:, i);

    sub_best = train_decision_stump(xi, y);

    if (best.err == -1 || best.err >= sub_best.err)
      if (best.err == -1 || best.err > sub_best.err)
        best.err = sub_best.err;
        best.s = [];
        best.theta = [];
      end
      for j = 1:length(sub_best.s)
        best.s(end+1) = sub_best.s(j);
        best.theta(end+1) = sub_best.theta(j);
        best.i(end+1) = i;
      end
    end
  end
endfunction
