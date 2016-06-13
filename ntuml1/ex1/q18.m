load('data18train.txt');
load('data18test.txt');

T = 2000;

total_e = 0;

for i = 1:T
  [w e] = pocket(data);
  e = verify(w, test);
  total_e += e;
end

e = total_e / T
