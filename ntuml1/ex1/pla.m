function [w, update_times] = pla(data, eta=1)

m = size(data, 1);
n = size(data, 2);
w = zeros(n, 1);
X = data(:, 1:n-1);
X = [ones(m, 1) X];
y = data(:, n);

i = 1;
unchange_times = 0;
update_times = 0;
while (true)
  yi = X(i, :) * w;
  if ((yi > 0) != (y(i) > 0))
    w += eta * y(i) * X(i, :)';
    update_times += 1;
    unchange_times = 0;
  else
    unchange_times += 1;
    if (unchange_times == m)
      break;
    end
  end
  i += 1;
  if (i == m + 1)
    i = 1;
  end
end
