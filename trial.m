load("brain.mat")

% im_k_space = fft2c(im);
% [m, n] = size(im_k_space); 
% im_partial_k_space = zeros(m, n);
% im_partial_k_space(1:m, 1:n*0.5) = im_k_space(1:m, 1:n*0.5);  
% figure(7), imshow(im_partial_k_space), hold;
% im_recons = ifft2c(im_partial_k_space);
% figure(8), imshow(abs(im_recons)), hold;

Conjugate_Synthesis_wo_Phase_Correction(im,0.51)