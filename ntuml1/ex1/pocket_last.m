function [w e] = pocket_last(data, update_times=50)

m = size(data, 1);
n = size(data, 2);
w = zeros(n, 1);
X = data(:, 1:n-1);
X = [ones(m, 1) X];
y = data(:, n);

fits = sum((X * w > 0) == (y > 0));

while (true)
  yh = X * w;
  y_choices = find((yh > 0) != (y > 0));
  if (length(y_choices) == 0)
    break;
  end
  i = y_choices(randi(length(y_choices)));

  w += y(i) * X(i, :)';
  fits = sum((X * w > 0) == (y > 0));
  update_times -= 1;
  if (update_times <= 0)
    break;
  end
end

e = (m - fits) / m;
