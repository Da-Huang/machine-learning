function [err_in, err_out] = q16(T=5000)
  total_err_in = 0;
  total_err_out = 0;
  for i = 1:T
    [err_in, err_out] = test_decision_stump();
    total_err_in += err_in;
    total_err_out += err_out;
  end
  err_in = total_err_in / T;
  err_out = total_err_out / T;
endfunction

function [err_in, err_out] = test_decision_stump(N=20, noise=0.2)
  x = sort(unifrnd(-1, 1, N, 1));
  y = xor(x > 0, unifrnd(0, 1, N, 1) <= noise);
  ans = decision_stump(x, y);
  err_in = ans(3, 1);
  err_out = ans(4, 1);
endfunction

function ans = decision_stump(x, y)
  % x is input
  % y is output
  % ans is (s, theta, err_in, err_out)

  N = length(x);

  % s, theta, err_in, err_out
  best_cases = zeros(3, 0);

  dcs = [-1 x' 1];
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
      err = get_err_in(x, y, s, theta);
      if (size(best_cases, 2) == 0 || best_cases(3, 1) > err)
        best_cases = [s, theta, err]';
      elseif (best_cases(3, 1) == err)
        best_cases(:, end + 1) = [s, theta, err]';
      end
    end
  end

  ridx = unidrnd(size(best_cases, 2));
  ans = best_cases(:, ridx);
  ans(end + 1, 1) = get_err_out(x, y, ans(1, 1), ans(2, 1));
endfunction

function err = get_err_in(x, y, s, theta)
  err = sum(s * (x - theta > 0) != y) / size(x, 1);
endfunction

function err = get_err_out(x, y, s, theta)
  err = 0.5 + 0.3 * s * (abs(theta) - 1);
endfunction
