function Conjugate_Synthesis_with_Phase_Correction(im, ratio)
    %Print initial data
    subplot(3,3,1), imshow(abs(im)), title("Initial: Image Space") ;
    subplot(3,3,4), imshow(fft2c(im)), title("Initial: k-Space");
end