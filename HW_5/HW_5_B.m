clc;
clear all;
close all;

T = 1;
B = 100;
A = 1;

t = (-T/2:0.001:T/2-0.001);
p = A*exp(1j.*pi.*B.*(t.^2)./T);

autocorr = abs(xcorr(p));
plot(abs(autocorr));

Xa = (-2/T:0.4:2/T);
xticklabels(Xa);
yticklabels(Xa);


title(['B     T = ',num2str(T), ' | Bandwidth = ',num2str(B), ' | Amplitude = ',num2str(A)]);
ylabel('\bf Frequency');
xlabel('\bf Frequency');