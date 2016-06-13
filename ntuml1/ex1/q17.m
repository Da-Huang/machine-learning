load('data15.txt')

m = size(data, 1);

all_update_times = 0;

T = 2000;

for t = 1:T
  rdata = data(randperm(m), :);
  [w update_times] = pla(rdata, eta=0.5);
  all_update_times += update_times;
end

update_times = all_update_times / 2000
