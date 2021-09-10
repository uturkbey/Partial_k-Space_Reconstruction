function [psnr_value, ssim_value] = Conjugate_Synthesis_with_Phase_Correction(im, ratio)
%This function implements the conjugate synthesis with phase correction 
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
    figure("Name","Reconstruction with Conjugate Synthesis w/ Phase Correction");
    subplot(2,5,1), imshow(abs(im)), title("m(x,y)") ;
    subplot(2,5,6), imshow(fft2c(im)), title("M(k_x,k_y)");
%--------------------------------------------------------------------------

    M_pk = fft2c(im); %convert from image space to k-Space 
    [m, n] = size(im); %learn the dimensions of image
    M_pk(m*ratio:end,:) = 0; %discard the ratio% of the samples at the bottom wrt vertical direction
    M_s = zeros(m,n); %initialize the M_s 
    M_s(m*(1-ratio):m*ratio,:) = M_pk(m*(1-ratio):m*ratio,:); %obtain the symmetric data in k-Space
    m_s = ifft2c(M_s); %obtain m_s in image space
    m_pk = ifft2c(M_pk); %obtain m_pk in image space
    p = exp(-1i*angle(m_s)); %obtain phase correction from symmetric data
    pc_m_pk = p.*m_pk; %obtain phase corrected partial image
    pc_M_pk = fft2c(pc_m_pk); %obtain phase corrected partial k-Space data
    M_k = pc_M_pk; 
    M_k(m*ratio:end,:) = conj(flip(flip(M_k(1:m*(1-ratio)+1,:),1),2)); %Conjugate sytnhesis
    image = ifft2c(M_k); %obtain desired image
  
    psnr_value = psnr(abs(image), abs(im));
    ssim_value = ssim(abs(image), abs(im));
    
%--------------------------------------------------------------------------
    %plot data
    subplot(2,5,7), imshow(M_pk), title("M_p_k(k_x,k_y)");
    subplot(2,5,2), imshow(abs(m_pk)), title("m_p_k(x,y)");
    subplot(2,5,8), imshow(M_s), title("M_s(k_x,k_y)");
    subplot(2,5,3), imshow(abs(m_s)), title("m_s(x,y)");
    subplot(2,5,4), imshow(abs(pc_m_pk)), title("p*(x,y)m_p_k(x,y)");
    subplot(2,5,9), imshow(pc_M_pk), title("(Phase Corrected) M_p_c(k_x,k_y)");
    subplot(2,5,10), imshow(M_k), title("(After Conj. Synt.) M_p_c_-_c_s(k_x,k_y)");
    subplot(2,5,5), imshow(image), title("(After Conj. Synt.) m_p_c_-_c_s(x,y)"); 
    figure("Name", "||m(x,y)|-|m_p_c_-_c_s(x,y)||x5"), imshow(abs(abs(im)-abs(image))*5);
%--------------------------------------------------------------------------
end