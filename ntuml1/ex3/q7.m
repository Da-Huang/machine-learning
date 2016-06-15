function [u v e] = q7(u=0, v=0, ita=0.01, iter=5)
  for i = 1:iter
    u1 = u - ita * edu(u, v);
    v1 = v - ita * edv(u, v);
    u = u1;
    v = v1;
  end
  e = err(u, v);
endfunction

function ans = err(u, v)
  ans = exp(u) + exp(2*v) + exp(u*v) + u*u - 2*u*v + 2*v*v - 3*u - 2*v;
endfunction

function ans = edu(u, v)
  ans = exp(u) + v * exp(u * v) + 2 * u - 2 * v - 3;
endfunction

function ans = edv(u, v)
  ans = 2 * exp(2 * v) + u * exp(u * v) - 2 * u + 4 * v - 2;
endfunction
