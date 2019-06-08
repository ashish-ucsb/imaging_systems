clc;
clear all;
close all;

load('gpr_data.mat');

ss = 0.0213; % spatial spacing
c = 3*10^8; % speed of light
er = 6; % relative permittivity
comp_images = 128; % no. of composite images

video = VideoWriter('HW_4.avi'); %create the video object
video.FrameRate=15;
open(video); %open the file for writing

X = -ss*100:ss:ss*100;
Y = 0:0.005:1;

[X,Y] = meshgrid(X,Y);

r = sqrt((X).^2 + (Y).^2);

fin = 0;
for n = 1:comp_images
    lambda_n = c./(f(1,n)*sqrt(er));
    H = exp(1j.*2.*pi.*2*r./lambda_n);
    [row, col] = find(isinf(H));
    H(row, col) = 0;
    Hconj = conj(H);
    data = conj(F(n,:));
    res = conv2(Hconj,data,'same');
    fin = fin + res;
    writeVideo(video, flipud(abs(fin)/max(abs(fin(:)))));
end

close(video);
figure();
imagesc(abs(fin));
axis xy;

xa = get(gca, 'XTick'); % x axis ranges from [0, 200]
Xa = round((0.02115.*xa - 2.13),2); % New range from [-2.13, +2.13]  rounded to decimal places
xticklabels(Xa);
set(gca,'ytick',[2])

title(['Reconstructed Image from ',num2str(comp_images) ' Composite Images ']);
ylabel('\bf Depth(m)');
xlabel('\bf Distance along Aperture (m)');