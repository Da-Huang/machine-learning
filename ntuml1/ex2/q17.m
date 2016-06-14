function [err_in err_out] = q17(N=20, noise=0.2, T=5000)
  total_err_in = 0;
  total_err_out = 0;
  for i = 1:T
    x = sort(unifrnd(-1, 1, N, 1));
    y = sign(x) .* (1 - 2 .* (unifrnd(0, 1, N, 1) <= noise));

    best = train_decision_stump(x, y);
    err_in = best.err;
    besti = unidrnd(length(best));
    s = best.s(besti);
    theta = best.theta(besti);

    err_out = get_err_out(x, y, s, theta);

    total_err_in += err_in;
    total_err_out += err_out;
  end
  err_in = total_err_in / T;
  err_out = total_err_out / T;
endfunction

function err = get_err_out(x, y, s, theta)
  err = 0.5 + 0.3 * s * (abs(theta) - 1);
endfunction
