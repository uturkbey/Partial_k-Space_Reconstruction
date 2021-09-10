function [psnr_value, ssim_value] = trivial_reconstruction_by_zero_padding(im, ratio, flag)
%This function implements the trivial zero padding reconstruction
%algorithm from the domain of Partial Fourier Reconstruction methods.
%Note: Some optional figures are provided as well. In order to obtain those
%figures, uncomment the necessary lines of code between the dashed lines. 
%Arguments:
%   -im is the 2D matrix of the full k-Space image to be first down-sampled 
%   to partial k-Space and then reconstructed.
%   -ratio is the partial k-Space ratio to be used during down-sampling. 
%   -flag is a string value to indicate which function to be called. 
%   "V" for vertical and "H" for horizontal zero padding.
%Return:
%   -psnr_value is the Peak Signal to Noise Ratio (PSNR) value of the
%   reconstructed magintude image wrt the original magnitude image 
%   -ssim_value is the Structural Similarity (SSIM) value of the
%   reconstructed magintude image wrt the original magnitude image 
    
    M = fft2c(im);       
    [m, n] = size(M); 
    M_pk = M;
    if flag == "V"    
        M_pk(m*ratio:end,:) = 0;
    else 
        M_pk(:,n*ratio:end) = 0; 
    end
    m_pk = ifft2c(M_pk);
    
%--------------------------------------------------------------------------    
    if flag == "V"
         figure("Name", "Reconstruction with Zero Padding (Vertical)")
    else 
         figure("Name", "Reconstruction with Zero Padding (Horizontal)")
    end
    subplot(3,2,1), imshow(abs(im)), title("m(x,y)");
    subplot(3,2,2), imshow(abs(m_pk)), title("m_p_k(x,y)");
    subplot(3,2,3), imshow(M), title("M(k_x,k_y)");
    subplot(3,2,4), imshow(fft2c(m_pk)), title("M_p_k(k_x,k_y)");
    subplot(3,2,5), imshow(abs(abs(im)-abs(m_pk))), title("||m(x,y)|-|m_p_k(x,y)||");
    subplot(3,2,6), imshow(abs(abs(im)-abs(m_pk))*5), title("||m(x,y)|-|m_p_k(x,y)||x5");
%--------------------------------------------------------------------------

    psnr_value = psnr(abs(m_pk), abs(im));
    ssim_value = ssim(abs(m_pk), abs(im));
end

