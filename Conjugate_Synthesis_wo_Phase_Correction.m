function [psnr_value, ssim_value] = Conjugate_Synthesis_wo_Phase_Correction(im, ratio)
%This function implements image reconstruction by conjugate synthesis
%without phase correction algorithm 
%   -im is the matrix of the image to be reconstructed
%   -ratio is the amount of data to be hold after dropping k-Space
    
    %Print initial data
%     subplot(3,3,1), imshow(abs(im)), title("Initial: Image Space") ;
%     subplot(3,3,4), imshow(fft2c(im)), title("Initial: k-Space");

    im_k = fft2c(im); %convert from image space to k-Space 
    [m, n] = size(im); %learn the dimensions of image
    im_k(m*ratio:end,:) = 0; %discard the ratio% of the samples at the bottom wrt vertical direction

    %Print data after discarding
%     subplot(3,3,2), imshow(abs(ifft2c(im_k))), title("After discard: Image Space");
%     subplot(3,3,5), imshow(im_k), title("After discard: k-Space");
%     subplot(3,3,8), imshow(abs(abs(ifft2c(im_k))-abs(im))), title("After discard: Difference");
    
    im_k(m*ratio:end,:) = conj(flip(flip(im_k(1:m*(1-ratio)+1,:),1),2)); %Conjugate sytnhesis
    image = ifft2c(im_k);
    psnr_value = psnr(abs(image), abs(im));
    ssim_value = ssim(abs(image), abs(im));
    
    %Print final data(after conjugate synthesis)
%     subplot(3,3,6), imshow(im_k), title("Final: k-Space");
%     subplot(3,3,3), imshow(abs(image)), title("Final: Image Space");
%     subplot(3,3,9), imshow(abs(abs(image)-abs(im))), title("After discard: Difference");
end