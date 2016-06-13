function err = get_err(x, y, s, theta)
  err = sum(s * (x - theta > 0) != y) / size(x, 1);
endfunction
