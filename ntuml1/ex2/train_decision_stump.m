function [s theta err] = train_decision_stump(x, y)
  % x is input
  % y is output

  N = length(x);

  best_s = 0;
  best_theta = 0;
  best_err = 0;

  for i = 0:length(x)
    if (i == 0)
      range = [-1 x(1)];
    elseif (i == length(x))
      range = [x(end) 1];
    else
      range = [x(i) x(i+1)];
    end
    theta = mean(range);

    for s = [-1 1]
      err = get_err(x, y, s, theta);
      if (best_s == 0 || best_err > err)
        best_theta = theta;
        best_s = s;
        best_err = err;
      end
    end
  end
  s = best_s;
  theta = best_theta;
  err = best_err;
endfunction
