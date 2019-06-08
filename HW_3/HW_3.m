clc;
clear all;
close all;
 
load('data_hw3.mat');
ss = 0.25*lambda_0; %sample spacing of x & y
apr = 30*lambda_0; %aperture of 30 x lambda
 
[X,Y] = meshgrid(-apr:ss:apr);
 
r = sqrt((X).^2 + (Y+(60*lambda_0)).^2);
 
fin = 0;
% A. to get nth image, just change range n:n
% C. range is 1:40
% D. range is 1:10, 1;20, 1:30, 1:40
for n = 1:40
    lambda_n = (40*lambda_0)/(n+20);
    H =((1j.*lambda_n.*r).^(-0.5)).*(exp(1j.*2.*pi.*r./lambda_n));
    [row, col] = find(isinf(H));
    H(row, col) = 0;
    Hconj = conj(H);
    res = conv2(Hconj,g(n,:),'same');
    fin = fin + res;
end
 
figure();
imagesc(abs(fin));
axis xy;
 
k = get(gca, 'XTick'); % k ranges from [0, 242]
K = round((-30 + ((60/241).*k)),2); % New K from [-30, +30]  rounded to deci-mal places
xticklabels(K);
yticklabels(K);
 
title(['D     \lambda = ',num2str(lambda_0), ' | Sample Spacing = ',num2str(ss), ' | Aperture = ',num2str(apr)]);
ylabel('\bf \lambda(y)');
xlabel('\bf \lambda(x)');