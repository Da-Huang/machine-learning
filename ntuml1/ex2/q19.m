function [err_in err_out] = q19()
  train = load('train19.txt');
  test = load('test19.txt');

  trainx = train(:, 1:end-1);
  trainy = train(:, end);
  [s theta i err_in] = n_decision_stump(trainx, trainy);

  testxi = test(:, i);
  testy = test(:, end);
  err_out = get_err(testxi, testy, s, theta);
endfunction

function [s theta i err] = n_decision_stump(x, y)
  % x is input
  % y is output

  best_cases = zeros(4, 0);
  best_s = 0;
  best_theta = 0;
  best_i = 0;
  best_err = 0;

  for i = 1:size(x, 2)
    [xi, idx] = sort(x(:, i));
    yi = y(idx);

    [s theta err] = train_decision_stump(xi, yi);
    if (best_s == 0 || best_err > err)
      best_s = s;
      best_theta = theta;
      best_i = i;
      best_err = err;
    end
  end

  s = best_s;
  theta = best_theta;
  i = best_i;
  err = best_err;
endfunction
