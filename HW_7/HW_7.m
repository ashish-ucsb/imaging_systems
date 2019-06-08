close all;
clear all;
clc;

video = VideoWriter('lab7.avi'); %create the video object
video.FrameRate=15;
open(video); %open the file for writing

load('gpr_data.mat');

ss = 0.0213; % spatial spacing
c = 3*10^8; % speed of light
er = 6; % relative permittivity

X = -ss*100:ss:ss*100;
Y = 0:0.005:1;

[X,Y] = meshgrid(X,Y);

r = sqrt((X).^2 + (Y).^2);

final = zeros(201,402);

for m = 1:200
    fin = 0;
    for n = 1:128
        w = 2*pi*f(1,n)*sqrt(er);
        H = exp(1j*w.*2.*r./c);
        [row, col] = find(isinf(H));
        H(row, col) = 0;
        Hconj = conj(H);
        data = conj(F(n,m));
        res = conv2(Hconj,data,'same');
        fin = fin + res;
    end
    final(:,m:m+200) = final(:,m:m+200) + fin;
    writeVideo(video,flipud(abs(final)/max(abs(final(:))))); %write the image to fil
end
close(video);
figure();
imagesc(abs(final));
axis xy;