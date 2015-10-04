function avg_e = pla_modify_test(data, test, times=2000, updates=50)

data_m = size(data, 1);

test_m = size(test, 1);
test_n = size(test, 2);
X = [ones(test_m, 1) test(:, 1:test_n-1)];
y = test(:, test_n);

total_e = 0;

for i = 1:times
  data = data(randperm(data_m), :);
  [w e] = pla_modify(data, updates);

  total_e += sum((X * w > 0) != (y > 0));
end

avg_e = total_e / test_m / times;
