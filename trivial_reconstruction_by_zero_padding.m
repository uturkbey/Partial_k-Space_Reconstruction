load('brain.mat')

figure("Name", "Original Image(Magnitude) in time domain"); 
imshow(abs(im));

try_recons_by_zero_padding(im, [0.4, 0.7], "V")
try_recons_by_zero_padding(im, [0.4, 0.7], "H")

function try_recons_by_zero_padding(im, range, flag)
%This function calls the recons_by_zero_padding functions over the image
%and the range provided. Then prints the results. Which zero padding
%function will be used is determined by the flag variable. Percentages of zero
%padding is decided by linear partition of range over six intervals.
%   -im is the matrix of the image to be reconstructed
%   -range is a vector subinterval of [0, 1] range
%   -flag is a string value to indicate which function to be called. "V"
%   for vertical and "H" for horizontal 
    if flag == "V"
        figure("Name", "Reconstructed Image(Magnitude) in time domain (vertical)")
    else 
        figure("Name", "Reconstructed Image(Magnitude) in time domain (horizontal)")
    end
        for i = 1:6
            percentage = range(1) + i*(range(2) - range(1))/6; 
            subplot(2,3,i), imshow(abs(recons_by_zero_padding(fft2c(im), percentage, flag))), title(string(percentage));
        end
end

function im_recons = recons_by_zero_padding(im_k_space, percentage, flag)
%This function is for reconstructing images given as k-Space data with zero 
%padding in either horizontal or vertical direction at the given percantage
%   -im_k_space is the supplied raw data containing image
%   -percentage is the desired amount of zero padding (zeros are set
%   starting from right in horizontal direction)
%   -flag is a string value to indicate which algorithm should be executed.
%   "V" for vertical and "H" for horizontal 
    [m, n] = size(im_k_space); 
    im_partial_k_space = zeros(m, n);
    if flag == "V"    
        im_partial_k_space(1:m*percentage, 1:n) = im_k_space(1:m*percentage, 1:n);
    else 
        im_partial_k_space(1:m, 1:n*percentage) = im_k_space(1:m, 1:n*percentage); 
    end
        im_recons = ifft2c(im_partial_k_space);
end


