clc;
clear all;
close all;

lam = 1; %wavelength
ss = 0.25; %sample spacing
apr = lam.*[15 30 60]; %aperture
N = 512; % 512x512 fft

for n = 1:length(apr)
    [X,Y] = meshgrid(-apr(1,n):ss:apr(1,n));

    r = sqrt((X).^2 + (Y).^2);
    H =((1j.*lam.*r).^(-0.5)).*(exp(1j.*2.*pi.*r./lam));
    [row, col]= find(isinf(H));
    H(row, col) = 0;

    Z = fftshift(fft2((H),N,N));
    imagesc(abs(Z));
    
    k = get(gca, 'XTick'); % K from [0, N]
    K = k -(N/2); % New K from [-N/2, N/2]
    f = round(K/(N*ss), 2); % frequency from fft rounded to 2 decimal places
    xticklabels(f);
    yticklabels(f);
    
    title(['Question 6     \lambda = ',num2str(lam), ' | Sample Spacing = ',num2str(ss), ' | Aperture = ',num2str(apr(1,n))]);
    ylabel('\bf f(y)');
    xlabel('\bf f(x)');
    
    pause(1); %delay between loops

end