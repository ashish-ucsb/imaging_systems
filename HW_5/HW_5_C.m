clc;
clear all;
close all;

T = 1;
B = 100;
A = 1;

t = (-T/2:0.001:T/2);
p = A*exp(1j.*pi.*B.*(t.^2)./T);

del_t = 1;
new_t = t - del_t;

p = fftshift(abs(fft2(A*exp(1j.*pi.*B.*(new_t.^2)./T)))) ;
p1 = exp(1j.*2.*pi.*del_t)*p;
p2 = conj(p);

K = p1.*p2;

figure();
plot(t, K);

Xa = (-2/T:0.4:2/T);
xticklabels(Xa);

ya = get(gca, 'YTick');
Ya = ya./10000 ;
yticklabels(Ya);

title(['C     T = ',num2str(T), ' |\Deltat = ',num2str(del_t), ' | Bandwidth = ',num2str(B), ' | Amplitude = ',num2str(A)]);
ylabel('\bf Amplitude');
xlabel('\bf Frequency');

