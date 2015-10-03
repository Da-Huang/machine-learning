function [err_in, err_out] = q16(T=5000)
  total_err_in = 0;
  total_err_out = 0;
  for i = 1:T
    err = decision_stump_err();
    err_in = err(3, 1);
    err_out = err(4, 1);
    total_err_in += err_in;
    total_err_out += err_out;
  end
  err_in = total_err_in / T;
  err_out = total_err_out / T;
endfunction

function err = decision_stump_err(N=20, noise=0.2)
  x = sort(unifrnd(-1, 1, N, 1));
  y = xor(x > 0, unifrnd(0, 1, N, 1) <= noise);

  pos_err = [];
  neg_err = [];

  err_cases = zeros(3, 0);

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
      if (size(err_cases, 2) == 0 || err_cases(3, 1) > err)
        err_cases = [s, theta, err]';
      elseif (err_cases(3, 1) == err)
        err_cases(:, end + 1) = [s, theta, err]';
      end
    end
  end

  ridx = unidrnd(size(err_cases, 2));
  err_case = err_cases(:, ridx);
  err = err_case;
  err(end + 1, :) = get_err_out(x, y, err(1, 1), err(2, 1));
  err(3, 1) /= N;
  err(4, 1) /= N;
endfunction

function err = get_err_in(x, y, s, theta)
  err = sum(s * (x - theta > 0) != y);
endfunction

function err = get_err_out(x, y, s, theta)
  err = 0.5 + 0.3 * s * (abs(theta) - 1);
endfunction
