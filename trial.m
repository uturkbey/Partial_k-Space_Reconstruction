 x = (1:96); y = (1:96)';
I_mag = phantom(96);
I_phs = 2*pi*(3*exp(-sqrt((x-36).^2+(y-36).^2)/16)+2*exp(-((x-56).^2)/36^2));
img = I_mag.*exp(1j*I_phs);

figure;
imshow(img);