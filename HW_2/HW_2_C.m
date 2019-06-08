clc;
clear all;
close all;

load('data_hw2.mat');
gnew = g./abs(g);
lam = 1; %wavelength
ss = 0.25; %sample spacing of x & y
apr = 30*lam; %aperture of 30 x lambda

[X,Y] = meshgrid(-apr:ss:apr);

r = sqrt((X).^2 + (Y+60).^2);
H = (exp(1j.*2.*pi.*r./lam)); %phase only
[row, col] = find(isinf(H));
H(row, col) = 0;
Hconj = conj(H);
res = conv2(Hconj,gnew,'same');
figure();
imagesc(abs(res));
axis xy;

k = get(gca, 'XTick'); % k ranges from [0, 242]
K = round((-30 + ((60/241).*k)),2); % New K from [-30, +30]  rounded to decimal places
xticklabels(K);
yticklabels(K);

title(['C     \lambda = ',num2str(lam), ' | Sample Spacing = ',num2str(ss), ' | Aperture = ',num2str(apr)]);
ylabel('\bf \lambda(y)');
xlabel('\bf \lambda(x)');