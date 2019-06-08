clc;
clear all;
close all;

lam = 1; %wavelength
ss = 0.25; %sample spacing of x & y
apr = 30*lam; %aperture of 30 x lambda
N = 512; % 512x512 fft

[X,Y] = meshgrid(-apr:ss:apr);

r = sqrt((X).^2 + (Y).^2);
H =((1j.*lam.*r).^(-0.5)).*(exp(1j.*2.*pi.*r./lam));
[row, col] = find(isinf(H));
H(row, col) = 0;

Z = fftshift(fft2((H),N,N));
imagesc(abs(Z));

k = get(gca, 'XTick'); % K from [0, N]
K = k -(N/2); % New K from [-N/2, N/2]
f = round(K/(N*ss), 2); % frequency from fft rounded to 2 decimal places
xticklabels(f);
yticklabels(f);

title(['Question 1     \lambda = ',num2str(lam), ' | Sample Spacing = ',num2str(ss), ' | Aperture = ',num2str(apr)]);
ylabel('\bf f(y)');
xlabel('\bf f(x)');
