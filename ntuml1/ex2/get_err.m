function err = get_err(x, y, s, theta)
  err = sum(s * sign(x - theta) != y) / size(x, 1);
endfunction
