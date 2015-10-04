function avg_update_times = pla_times(data, test_times=2000, eta=1)

m = size(data, 1);

total_update_times = 0;

for i = 1:test_times
  data = data(randperm(m), :);
  [w update_times] = pla(data, eta);
  total_update_times += update_times;
end

avg_update_times = total_update_times / test_times;
