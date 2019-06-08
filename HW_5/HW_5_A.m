clc;
clear all;
close all;

T = 5;
B = 1000;
A = 1;

t = (-T/2:0.001:T/2);
p = A*exp(1j.*pi.*B.*(t.^2)./T);

figure();
plot(t, fftshift(abs(fft(p))));

Xa = (-2/T:0.4:2/T);
xticklabels(Xa);

ya = get(gca, 'YTick');
Ya = ya./100 ;
yticklabels(Ya);

title(['A     T = ',num2str(T), ' | Bandwidth = ',num2str(B), ' | Amplitude = ',num2str(A)]);
ylabel('\bf Amplitude');
xlabel('\bf Frequency');