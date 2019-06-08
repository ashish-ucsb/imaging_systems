clc;
clear all;
close all;

L = 1;
lam = 1;
zo = 1;
ss = 0.01;

del_x = 10;

apr = (-L/2:ss:L/2);
[X,Z] = meshgrid(apr); 

r = sqrt(X^2 + (Z-zo)^2);
newr = sqrt((X-del_x)^2 + (Z-zo)^2);

g = sqrt(1./(1j.*lam.*newr)).*exp((1j.*2.*pi.*newr)/lam);
g(~isfinite(g))=0;
g = fftshift(abs(fft2(g)));

p1 = exp(1j.*2.*pi.*del_x)*g;
p2 = conj(g);

K = p1.*p2;

figure();
plot(apr,K);

title(['F     L = ',num2str(L), ' | z0 = ',num2str(zo), ' | sample spacing = ',num2str(ss)]);
ylabel('\bf Amplitude');
xlabel('\bf Distance');
