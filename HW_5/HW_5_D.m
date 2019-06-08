clc;
clear all;
close all;

L = 1;
lam = 1;
zo = 1;
ss = 0.01;

apr = (-L/2:ss:L/2);
[X,Z] = meshgrid(apr); 

r = sqrt(X^2 + (Z-zo)^2);

g = sqrt(1./(1j.*lam.*r)).*exp((1j.*2.*pi.*r)/lam);
g(~isfinite(g))=0;

final = abs(fftshift(fft2(g)));

plot(apr, final);

title(['D     L = ',num2str(L), ' | z0 = ',num2str(zo), ' | sample spacing = ',num2str(ss)]);
ylabel('\bf Amplitude');
xlabel('\bf Distance');