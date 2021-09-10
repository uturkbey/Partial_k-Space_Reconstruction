function [psnr_value, ssim_value] = Homodyne_Reconstruction(im, ratio, weightingType)   
%This function implements the Homodyne reconstruction algorithm from the 
%domain of Partial Fourier Reconstruction methods.
%Note: Some optional figures are provided as well. In order to obtain those
%figures, uncomment the necessary lines of code between the dashed lines. 
%Arguments:
%   -im is the 2D matrix of the full k-Space image to be first down-sampled 
%   to partial k-Space and then reconstructed.
%   -ratio is the partial k-Space ratio to be used during down-sampling. 
%   -weigtingType is the type of filter to be used during reconstruction
%   "Step" for step and "Ramp" for ramp. 
%Return:
%   -psnr_value is the Peak Signal to Noise Ratio (PSNR) value of the
%   reconstructed magintude image wrt the original magnitude image 
%   -ssim_value is the Structural Similarity (SSIM) value of the
%   reconstructed magintude image wrt the original magnitude image 

%--------------------------------------------------------------------------
    %Print initial data
    if weightingType == "Step"
       figure("Name","Reconstruction with Homodyne (Step)");
    else %weightingType == "Ramp" %linear ramp
       figure("Name","Reconstruction with Homodyne (Ramp)");
    end
    subplot(2,5,1), imshow(abs(im)), title("m(x,y)") ;
    subplot(2,5,6), imshow(fft2c(im)), title("M(x,y)");
%-------------------------------------------------------------------------- 

    M_pk = fft2c(im); %convert from image space to k-Space 
    [m, n] = size(im); %learn the dimensions of image
    M_pk(m*ratio:end,:) = 0; %discard the ratio% of the samples at the bottom wrt vertical direction
    m_pk = ifft2c(M_pk); %obtain m_pk in image space
    M_s = zeros(m,n); %initialize the M_s 
    M_s(m*(1-ratio):m*ratio,:) = M_pk(m*(1-ratio):m*ratio,:); %obtain the symmetric data in k-Space
    m_s = ifft2c(M_s); %obtain m_s in image space
    p = exp(-1i*angle(m_s)); %obtain phase correction from symmetric data
    %Construct weighting function
    W = zeros(m,n);
    W(1:m*(1-ratio),:) = 2; %antisymmetric part
    if weightingType == "Step"
        W(m*(1-ratio):m*ratio,:) = 1; %symmetric part
    else %weightingType == "Ramp" %linear ramp
        W(m*(1-ratio):m*ratio,:) = ones(idivide((m*(2*ratio-1)), int32(1)) + 1,n).*(2*[(m*(2*ratio-1)):-1:0]'/(m*(2*ratio-1))); %symmetric part
    end
    w_M_pk = M_pk.*W; %obtain weighted k-space data
    w_m_pk = ifft2c(w_M_pk); %obtain weighted image space data
    pc_m_pk = w_m_pk.*p; %obtain phase corrected weighted image space data
    image = real(pc_m_pk);
    psnr_value = psnr(abs(image), abs(im));
    ssim_value = ssim(abs(image), abs(im));

%--------------------------------------------------------------------------
    %plot data
    subplot(2,5,7), imshow(M_pk), title("M_p_k(k_x,k_y)");
    subplot(2,5,2), imshow(abs(m_pk)), title("m_p_k(x,y)");
    subplot(2,5,8), imshow(M_s), title("M_s(k_x,k_y)");
    subplot(2,5,3), imshow(abs(m_s)), title("m_s(x,y)");
    subplot(2,5,4), imshow(W,[]), title("W(k_y)");
    subplot(2,5,9), imshow(w_M_pk), title("M_w = M_p_k(k_x,k_y)W(k_y)");
    subplot(2,5,5), imshow(abs(w_m_pk)), title("m_w = m_p_k(x,y)*w(y)");  
    subplot(2,5,10), imshow(abs(image)), title("(Phase Corrected) m_w_-_p_c(x,y)");
    if weightingType == "Step"
       figure("Name","Reconstruction with Homodyne (Step) Differences");
    else %weightingType == "Ramp" %linear ramp
       figure("Name","Reconstruction with Homodyne (Ramp) Differences");
    end
    subplot(1,2,1), imshow(abs(abs(im)-abs(w_m_pk))*5), title("||m(x,y)|-|m_w(x,y)||x5");
    subplot(1,2,2), imshow(abs(abs(im)-abs(image))*5), title("||m(x,y)|-|m_w_-_p_c(x,y)||x5");
    
    figure("Name","W"), mesh(W);
%--------------------------------------------------------------------------

end