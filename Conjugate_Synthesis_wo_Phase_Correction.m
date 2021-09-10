function [psnr_value, ssim_value] = Conjugate_Synthesis_wo_Phase_Correction(im, ratio)
%This function implements the conjugate synthesis without phase correction 
%algorithm from the domain of Partial Fourier Reconstruction methods.
%Note: Some optional figures are provided as well. In order to obtain those
%figures, uncomment the necessary lines of code between the dashed lines. 
%Arguments:
%   -im is the 2D matrix of the full k-Space image to be first down-sampled 
%   to partial k-Space and then reconstructed.
%   -ratio is the partial k-Space ratio to be used during down-sampling. 
%Return:
%   -psnr_value is the Peak Signal to Noise Ratio (PSNR) value of the
%   reconstructed magintude image wrt the original magnitude image 
%   -ssim_value is the Structural Similarity (SSIM) value of the
%   reconstructed magintude image wrt the original magnitude image 

%--------------------------------------------------------------------------
    %Print initial data
    figure("Name", "Reconstruction with Conjugate Synthesis w/o Phase Correction")
    subplot(3,3,1), imshow(abs(im)), title("m(x,y)");
    subplot(3,3,4), imshow(fft2c(im)), title("M(k_x,k_y)");
%--------------------------------------------------------------------------

    M_k = fft2c(im); %convert from image space to k-Space 
    [m, n] = size(im); %learn the dimensions of image
    M_k(m*ratio:end,:) = 0; %discard the ratio of the samples at the bottom wrt vertical direction
 
%--------------------------------------------------------------------------
    %Print data after discarding
    subplot(3,3,2), imshow(abs(ifft2c(M_k))), title("m_p_k(x,y)");
    subplot(3,3,5), imshow(M_k), title("M_p_k(k_x,k_y)");
    subplot(3,3,8), imshow(abs(abs(ifft2c(M_k))-abs(im))*5), title("||m(x,y)|-|m_p_k(x,y)|x5");
%--------------------------------------------------------------------------

    M_k(m*ratio:end,:) = conj(flip(flip(M_k(1:m*(1-ratio)+1,:),1),2)); %Conjugate sytnhesis
    image = ifft2c(M_k);
    psnr_value = psnr(abs(image), abs(im));
    ssim_value = ssim(abs(image), abs(im));
    
%--------------------------------------------------------------------------
    %Print final data(after conjugate synthesis)
    subplot(3,3,6), imshow(M_k), title("(After Conj. Synt.) M_c_s(k_x,k_y)");
    subplot(3,3,3), imshow(abs(image)), title("(After Conj. Synt.) m_c_s(x,y)");
    subplot(3,3,9), imshow(abs(abs(image)-abs(im))*5), title("(After Conj. Synt.) ||m(x,y)|-|m_c_s(x,y)||x5");
%--------------------------------------------------------------------------
end