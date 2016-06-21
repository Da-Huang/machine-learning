function q3()
  addpath('../../libsvm/matlab');
  data = load('data2.dat');
  X = data(:,2:end);
  y = data(:,1);
  model = svmtrain(y, X, '-s 0 -t 1 -d 2 -g 1 -r 1 -c 10000000 -h 0 -q');
  alpha = zeros(size(data,1),1);
  alpha(model.sv_indices) = model.sv_coef';
  alpha = alpha .* y;
  alpha
  for i = 1:size(model.SVs,1)
    SVs(end+1,:) = x2z(model.SVs(i,:));
  end
  for i = 1:size(SVs,2)
    w(:,end+1) = SVs(:,i)' * model.sv_coef;
  end
  disp('1 x1 x2 x1x2 x1^2 x2^2');
  w .* [1 sqrt(2) sqrt(2) sqrt(2) 1 1] * 9
  model.rho * 9
endfunction

function z = x2z(x)
  z(1) = 1;
  z(2) = sqrt(2) * x(1);
  z(3) = sqrt(2) * x(2);
  z(4) = sqrt(2) * x(1) * x(2);
  z(5) = x(1) * x(1);
  z(6) = x(2) * x(2);
endfunction
