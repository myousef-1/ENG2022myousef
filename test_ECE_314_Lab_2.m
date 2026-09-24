
n = -10:10; %setting first value of n for graphs and convolutions             
x = [0 0 0 0 0 1 1 1 1 1 1 1 0 0 0 0 0 0 0 0 0];
y = [0 0 0 0 0 0 0 1 1 1 1 -1 -1 -1 -1 0 0 0 0 0 0];
z = [0 0 0 0 0 0 0 0 0 0 0 1 1 1 1 2 2 2 2 0 0]; %setting all the values for the original graphs
w = [0 0 0 0 0 0 -1 0 1 2 3 2 1 0 -1 0 0 0 0 0 0];
f = [0 0 0 0 0 0-2.5 -2 -1.5 -1 -0.5 0 0.5 1 1.5 2 2.5 0 0 0 0 0];
g = [0 0 1 1 1 1 1 1 1 0 0 0 0 0 1 1 1 1 1 1 1];
a = conv(x,z);
b = conv(x,y);
c = conv(x,f); %convolutions for result of each part
d = conv(x,g);
e = conv(y,z);
f1 = conv(y,g);
g1 = conv(y,w);
h = conv(y,f);
i = conv(z,g);
j = conv(w,g);
k = conv(f,g);
n = -20:20; %new value of n for graphing convolutions
stem(n, a, 'filled')
grid on  %graph of each convolution (all of them have the same format)
xlabel('n')
ylabel('m[n]')
title('Discrete Convolution of x and z')
figure;
stem(n, b, 'filled')
grid on
xlabel('n')
ylabel('m[n]')
title('Discrete Convolution of x and y')
figure;
stem(n, c, 'filled')
grid on
xlabel('n')
ylabel('m[n]')
title('Discrete Convolution of x and f')
figure;
stem(n, d, 'filled')
grid on
xlabel('n')
ylabel('m[n]')
title('Discrete Convolution of x and g')
figure;
stem(n, e, 'filled')
grid on
xlabel('n')
ylabel('m[n]')
title('Discrete Convolution of y and z')
figure;
stem(n, f1, 'filled')
grid on
xlabel('n')
ylabel('m[n]')
title('Discrete Convolution of y and g')
figure;
stem(n, g1, 'filled')
grid on
xlabel('n')
ylabel('m[n]')
title('Discrete Convolution of y and w')
figure;
stem(n, h, 'filled')
grid on
xlabel('n')
ylabel('m[n]')
title('Discrete Convolution of y and f')
figure;
stem(n, i, 'filled')
grid on
xlabel('n')
ylabel('m[n]')
title('Discrete Convolution of z and g')
figure;
stem(n, j, 'filled')
grid on
xlabel('n')
ylabel('m[n]')
title('Discrete Convolution of w and g')
figure;
stem(n, k, 'filled')
grid on
xlabel('n')
ylabel('m[n]')
title('Discrete Convolution of f and g')
figure;
b = [0.0675, 0.1349, 0.675];   
a = [1, -1.143, 0.4128];      
figure;
y = filter(b, a, x);
plot(x,y)