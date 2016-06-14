function best = train_decision_stump(x, y, left=-1, right=1)
  % x is input
  % y is output

  [x xi] = sort(x);
  y = y(xi);

  best.err = -1;

  for i = 0:length(x)
    if (i == 0)
      range = [left x(1)];
    elseif (i == length(x))
      range = [x(end) right];
    else
      range = [x(i) x(i+1)];
    end
    theta = mean(range);

    for s = [-1 1]
      err = get_err(x, y, s, theta);
      if (best.err < 0 || best.err >= err)
        if (best.err < 0 || best.err > err)
          best.err = err;
          best.s = [];
          best.theta = [];
        end
        best.s(end+1) = s;
        best.theta(end+1) = theta;
      end
    end
  end
endfunction
