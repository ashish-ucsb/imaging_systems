%%-1
clc;
clear;
close all;

ss = 0.0213; % spatial spacing
c = 3*10^8; % speed of light
er = 6; % relative permittivity

X = -ss*100:ss:ss*100;
Y = 1/128:1/128:1;

[X,Y] = meshgrid(X,Y);

load('gpr_data.mat');

lambda = c./(f*sqrt(er));

r = sqrt((X).^2 + (Y).^2);

fin = 0;

for n = 1:128
    h =exp(1j*2*pi*r./(lambda(n)));
    h(~isfinite(h))=0;
    hconj = conj(h);
    % data acquisition position 10
    res = conv2(hconj,conj(F(n,10)),'same');
    fin = fin + res;
end

figure();
imagesc(abs(fin));
axis xy;
axis equal;

xa = get(gca, 'XTick');
xticklabels(xa*ss);

title('A. Using Back Propogation');
ylabel('\bf Frequency');
xlabel('\bf Distance');

%% 2

clc;
clear;
close all;

ss = 0.0213; % spatial spacing
c = 3*10^8; % speed of light
er = 6; % relative permittivity

X = -ss*100:ss:ss*100;
Y = 1/128:1/128:1;

[X,Y] = meshgrid(X,Y);

load('gpr_data.mat');

r = sqrt((X).^2 + (Y).^2);
 
wo = 2*pi*f(1)./sqrt(er);
w1 = 2*pi*f(2)./sqrt(er);
delta_w = w1-wo;

fin = 0;
 
for n = 1:128
    Q = exp(1j*n*delta_w*2*r./c);   
    Q(~isfinite(Q))=0;
    Qconj = conj(Q);
    Data = fft(F(n,10));
    res = conv2(Q,Data);
    C = Data*Qconj;
    fin = fin + C;   
end 

figure()
imagesc(abs(fin));
axis xy;
axis equal;


xa = get(gca, 'XTick');
xticklabels(xa*ss);

title('B. Using Fourier Transform Method');
ylabel('\bf Frequency');
xlabel('\bf Distance');


%% 3

clc;
clear;
close all;

ss = 0.0213; % spatial spacing
c = 3*10^8; % speed of light
er = 6; % relative permittivity

X = -ss*200:ss:ss*200;
Y = 1/128:1/128:2;

[X,Y] = meshgrid(X,Y);

load('gpr_data.mat');

lambda = c./(f*sqrt(er));

r = sqrt((X).^2 + (Y).^2);
 
wo = 2*pi*f(1)./sqrt(6);
w1 = 2*pi*f(2)./sqrt(6);
delta_w = w1-wo;

fin = 0;
 
for n = 1:128
    Q = exp(1j*n*delta_w*2*r./c);   
    Q(~isfinite(Q))=0;
    Qconj = conj(Q);
    Data = fft(F(n,10));
    res = conv2(Q,Data);
    C = Data*Qconj;
    fin = fin + C;   
end 

figure()
imagesc(abs(fin));
axis xy;
axis equal;

ya = get(gca, 'YTick');
yticklabels(ya/2);
xa = get(gca, 'XTick');
xticklabels(xa*ss/2);

title('C. Rescaled');
ylabel('\bf Frequency');
xlabel('\bf Distance');