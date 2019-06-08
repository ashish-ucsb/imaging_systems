clc;
clear all;
close all;

load('data_hw2.mat');
lam = 1; %wavelength
ss = 0.25; %sample spacing of x & y
apr = 30*lam; %aperture of 30 x lambda
gnew = g./abs(g); % normalizing magnitude

[X,Y] = meshgrid(-apr:ss:apr);

r = sqrt((X).^2 + (Y+60).^2);

H =((1j.*lam.*r).^(-0.5)).*(exp(1j.*2.*pi.*r./lam));
[row, col] = find(isinf(H));
H(row, col) = 0;
Hconj = conj(H);

Hc = (exp(1j.*2.*pi.*r./lam)); %phase only
[rowc, colc] = find(isinf(Hc));
Hc(rowc, colc) = 0;
Hconjc = conj(Hc);

resa = conv2(Hconj,g,'same'); %original
resb = conv2(Hconj,gnew,'same'); %normalized magnitude
resc = conv2(Hconjc,gnew,'same'); %phase only

Za = fftshift(fft2(resa));
imagesc(abs(Za));
axis xy;

Zb = fftshift(fft2(resb));
imagesc(abs(Zb));
axis xy;

Zc = fftshift(fft2(resc));
imagesc(abs(Zc));
axis xy;

k = get(gca, 'XTick'); % K from [0, N]
K = k - 256; % New K from [-N/2, N/2]
f = round(K/(512*ss), 2); % frequency from fft rounded to 2 decimal places
xticklabels(f);
yticklabels(f);

title(['D     \lambda = ',num2str(lam), ' | Sample Spacing = ',num2str(ss), ' | Aperture = ',num2str(apr)]);
ylabel('\bf f(y)');
xlabel('\bf f(x)');