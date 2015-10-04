function q4(N=5, dvc=50, delta=0.05)
  ovc_ans = ovc(N, dvc, delta)
  rp_ans = rp(N, dvc, delta)
  pvb_ans = pvb(N, dvc, delta)
  d_ans = d(N, dvc, delta)
  vvc = vvc(N, dvc, delta)
endfunction

function eps = ovc(N, dvc, delta)
  eps = sqrt(8 / N * (log(4 / delta) + dvc * log(2 * N)));
endfunction

function eps = rp(N, dvc, delta)
  eps = sqrt(2 / N * (log(2 * N) + dvc * log(N))) + sqrt(2 / N * log(1 / delta)) + 1 / N;
endfunction

function eps = pvb(N, dvc, delta, T=500)
  eps = 1;
  for i = 1:T
    eps = __pvb(N, dvc, delta, eps);
  end
endfunction

function eps = __pvb(N, dvc, delta, eps)
  eps = sqrt(1 / N * (2 * eps + log(6 / delta) + dvc * log(2 * N)));
endfunction

function eps = d(N, dvc, delta, T=500)
  eps = 1;
  for i = 1:T
    eps = __d(N, dvc, delta, eps);
  end
endfunction

function eps = __d(N, dvc, delta, eps)
  eps = sqrt(1 / (2 * N) * (4 * eps * (1 + eps) + log(4 / delta) + dvc * 2 * log(N)));
endfunction

function eps = vvc(N, dvc, delta, eps)
  eps = sqrt(16 / N * (log(2 / sqrt(delta)) + dvc * log(N)));
endfunction
