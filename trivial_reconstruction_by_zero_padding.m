function psnr_value = trivial_reconstruction_by_zero_padding(im, ratio, flag)
%This function calls the recons_by_zero_padding functions over the image
%and the range provided. Then prints the results. Which zero padding
%function will be used is determined by the flag variable. Percentages of zero
%padding is decided by linear partition of range over six intervals.
%   -im is the matrix of the image to be reconstructed
%   -ratio is the amount of data to be hold after dropping k-Space
%   -flag is a string value to indicate which function to be called. "V"
%   for vertical and "H" for horizontal 
    if flag == "V"
        figure("Name", "Reconstructed Image(Magnitude) in time domain (vertical)")
    else 
        figure("Name", "Reconstructed Image(Magnitude) in time domain (horizontal)")
    end 
    M_pk = fft2c(im);
    im_recons = recons_by_zero_padding(M_pk, ratio, flag);
    subplot(2,2,1), imshow(abs(im)), title("m_p_k(x,y)");
    subplot(2,2,2), imshow(abs(im_recons)), title("m(x,y)");
    subplot(2,2,3), imshow(M_pk), title("M_p_k(k_x,k_y)");
    subplot(2,2,4), imshow(fft2c(im_recons)), title("M(k_x,k_y)");
    psnr_value = psnr(im_recons, im);
end

function im_recons = recons_by_zero_padding(im_k_space, ratio, flag)
%This function is for reconstructing images given as k-Space data with zero 
%padding in either horizontal or vertical direction at the given percantage
%   -im_k_space is the supplied raw data containing image
%   -ratio is the amount of data to be hold after dropping k-Space
%   -flag is a string value to indicate which algorithm should be executed.
%   "V" for vertical and "H" for horizontal 
    [m, n] = size(im_k_space); 
    im_partial_k_space = zeros(m, n);
    if flag == "V"    
        im_partial_k_space(1:m*ratio, 1:n) = im_k_space(1:m*ratio, 1:n);
    else 
        im_partial_k_space(1:m, 1:n*ratio) = im_k_space(1:m, 1:n*ratio); 
    end
    im_recons = ifft2c(im_partial_k_space);
end


