function ans = sigmoid(x)
  ans = 1 ./ (1 .+ exp(-x));
endfunction
