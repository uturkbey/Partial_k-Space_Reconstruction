function Conjugate_Synthesis_with_Phase_Correction(im, ratio)
    %Print initial data
    subplot(3,3,1), imshow(abs(im)), title("Initial: Image Space") ;
    subplot(3,3,4), imshow(fft2c(im)), title("Initial: k-Space");

    im_k = fft2c(im); %convert from image space to k-Space 
    [m, n] = size(im); %learn the dimensions of image
    im_k(m*ratio:end,:) = 0; %discard the 40% of the samples at the bottom wrt vertical direction

    %Print data after discarding
    subplot(3,3,2), imshow(abs(ifft2c(im_k))), title("After discard: Image Space");
    subplot(3,3,5), imshow(im_k), title("After discard: k-Space");
    subplot(3,3,8), imshow(abs(abs(ifft2c(im_k))-abs(im))), title("After discard: Difference");
    im_k(m*ratio:end,:) = conj(flip(flip(im_k(1:m*(1-ratio)+1,:),1),2)); 

    %Print final data(after conjugate synthesis)
    subplot(3,3,6), imshow(im_k), title("Final: k-Space");
    subplot(3,3,3), imshow(abs(ifft2c(im_k))), title("Final: Image Space");
    subplot(3,3,9), imshow(abs(abs(ifft2c(im_k))-abs(im))), title("After discard: Difference");
end