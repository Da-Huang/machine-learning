function [w e] = pla_modify(data, update_times=50)

m = size(data, 1);
n = size(data, 2);
w = zeros(n, 1);
X = data(:, 1:n-1);
X = [ones(m, 1) X];
y = data(:, n);

best_w = w;
best_fits = sum((X * w > 0) == (y > 0));

history_w = [w];

while (true)
  yh = X * w;
  y_choices = find((yh > 0) != (y > 0));
  if (length(y_choices) == 0)
    break;
  end
  i = randi(length(y_choices));

  w += y(i) * X(i, :)';
  fits = sum((X * w > 0) == (y > 0));
  history_w = [history_w w];
  if (fits > best_fits)
    best_w = w;
    best_fits = fits;
  end
  update_times -= 1;
  if (update_times <= 0)
    break;
  end
end

w = best_w;
e = (m - best_fits) / m;
