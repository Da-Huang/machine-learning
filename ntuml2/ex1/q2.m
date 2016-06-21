function q2()
  data = load('data2.dat');
  X = data(:,2:end);
  y = data(:,1);
  for i = 1:size(X,1)
    Z(i, :) = fie(X(i, :));
  end
  i = find(y > 0);
  scatter(Z(i,:)(:,1), Z(i,:)(:,2), 'b', 'o');
  hold on;
  grid on;
  i = find(y < 0);
  scatter(Z(i,:)(:,1), Z(i,:)(:,2), 'r', 'x');
endfunction

function ans = fie(x)
  ans = [x(2)^2-2*x(1)+3 x(1)^2-2*x(2)-3];
endfunction
