function e = verify(w, test)

m = size(test, 1);
n = size(test, 2);
X = test(:, 1:n-1);
X = [ones(m, 1) X];
y = test(:, n);

e = sum((X * w > 0) != (y > 0)) / m;
