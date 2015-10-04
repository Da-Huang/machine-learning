function [err_in, err_out] = q19()
  load train19.txt
  load test19.txt
  
  trainx = train19(:, 1:end-1);
  trainy = train19(:, end);
  train_ans = n_decision_stump(trainx, trainy);
  err_in = train_ans(4, 1);

  testx = test19(:, 1:end-1);
  testy = test19(:, end);
  testxi = testx(:, train_ans(3, 1));
  err_out = get_err(testxi, testy, train_ans(1, 1), train_ans(2, 1));
endfunction

function ans = n_decision_stump(x, y)
  % x is input
  % y is output
  % ans is [s theta i err_in]'

  best_cases = zeros(4, 0);

  for i = 1:size(x, 2)
    [xi, idx] = sort(x(:, i));
    yi = y(idx);

    sub_ans = decision_stump(xi, yi);
    sub_ans_err = sub_ans(end, 1);
    sub_ans(end, 1) = i;
    sub_ans(end + 1, 1) = sub_ans_err;

    if (size(best_cases, 2) == 0 || best_cases(4, 1) > sub_ans(4, 1))
      best_cases = sub_ans;
    elseif (best_cases(4, 1) == sub_ans(4, 1))
      best_cases(:, end + 1) = sub_ans;
    end
  end

  ridx = unidrnd(size(best_cases, 2));
  ans = best_cases(:, ridx);
endfunction

function ans = decision_stump(x, y)
  % x is input
  % y is output
  % ans is [s theta err_in]'

  N = length(x);

  % s, theta, err_in, err_out
  best_cases = zeros(3, 0);

  dcs = x';
  for i = 1:length(dcs)
    val = dcs(i);
    for s = [-1 1]
      range = [val val];
      if (s == -1)
        if (i > 1)
          range(1) = dcs(i - 1);
        end
      else
        if (i < length(dcs))
          range(2) = dcs(i + 1);
        end
      end

      theta = mean(range);
      err = get_err(x, y, s, theta);
      if (size(best_cases, 2) == 0 || best_cases(3, 1) > err)
        best_cases = [s, theta, err]';
      elseif (best_cases(3, 1) == err)
        best_cases(:, end + 1) = [s, theta, err]';
      end
    end
  end

  ridx = unidrnd(size(best_cases, 2));
  ans = best_cases(:, ridx);
endfunction

function err = get_err(x, y, s, theta)
  err = sum(s * (x - theta > 0) != y) / size(x, 1);
endfunction
