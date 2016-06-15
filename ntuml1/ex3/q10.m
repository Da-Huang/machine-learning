function [u v e] = q10(u=0, v=0, ita=0.01, iter=5)
  for i = 1:iter
    update = pinv(hessian(u,v)) * d1(u,v)';
    u -= update(1);
    v -= update(2);
  end
  e = err(u, v);
endfunction

function ans = err(u, v)
  ans = exp(u) + exp(2*v) + exp(u*v) + u*u - 2*u*v + 2*v*v - 3*u - 2*v;
endfunction

function [du dv] = d1(u, v)
  du = exp(u) + v * exp(u * v) + 2 * u - 2 * v - 3;
  dv = 2 * exp(2 * v) + u * exp(u * v) - 2 * u + 4 * v - 2;
endfunction

function H = hessian(u, v)
  H(1,1) = exp(u) + v*v*exp(u*v) + 2;
  H(2,2) = 4*exp(2*v) + u*u*exp(u*v) + 4;
  H(1,2) = exp(u*v) + u*v*exp(u*v) - 2;
  H(2,1) = H(1,2);
endfunction
