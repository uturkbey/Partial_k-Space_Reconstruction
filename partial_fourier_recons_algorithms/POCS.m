function [psnr_value, ssim_value] = POCS(im, ratio, steps)
%This function implements the Projection Over Convex Sets(POCS) reconstruction
%algorithm from the domain of Partial Fourier Reconstruction methods.
%Note: Some optional figures are provided as well. In order to obtain those
%figures, uncomment the necessary lines of code between the dashed lines. 
%Arguments:
%   -im is the 2D matrix of the full k-Space image to be first down-sampled 
%   to partial k-Space and then reconstructed.
%   -ratio is the partial k-Space ratio to be used during down-sampling. 
%   -steps is the number of iterations of projection.
%Return:
%   -psnr_value is the Peak Signal to Noise Ratio (PSNR) value of the
%   reconstructed magintude image wrt the original magnitude image 
%   -ssim_value is the Structural Similarity (SSIM) value of the
%   reconstructed magintude image wrt the original magnitude image 

    M_pk = fft2c(im); %convert from image space to k-Space 
       
%--------------------------------------------------------------------------    
%     figure("Name","Reconstruction with POCS");
%     subplot(2,4,1), imshow(abs(im)), title("m(x,y)");
%     subplot(2,4,5), imshow(M_pk), title("M(k_x,k_y)");
%--------------------------------------------------------------------------

    [m, n] = size(im); %learn the dimensions of image
    M_pk(m*ratio:end,:) = 0; %discard the ratio% of the samples at the bottom wrt vertical direction
    m_pk = ifft2c(M_pk); %obtain m_pk in image space

%--------------------------------------------------------------------------
%     subplot(2,4,2), imshow(abs(m_pk)), title("m_p_k(x,y)");
%     subplot(2,4,6), imshow(M_pk), title("M_p_k(k_x,k_y)");
%--------------------------------------------------------------------------

    M_s = zeros(m,n); %initialize the M_s 
    M_s(m*(1-ratio):m*ratio,:) = M_pk(m*(1-ratio):m*ratio,:); %obtain the symmetric data in k-Space
    m_s = ifft2c(M_s); %obtain m_s in image space
    p = exp(1i*angle(m_s)); %obtain phase correction from symmetric data 
                            %CAUTION: This phase correction function is with +i opposed toh Hmodyne or Conjugate Synthesis 

%--------------------------------------------------------------------------
%     subplot(2,4,3), imshow(abs(m_s)), title("m_s(x,y)");
%     subplot(2,4,7), imshow(M_s), title("M_s(k_x,k_y)");
%--------------------------------------------------------------------------   
                            
    m_pocs = zeros(m, n); %m_pocs is the image to be constructed. Initialized as a zero vector and built up in each iteration.
    iter = 0;
    diff = inf;
    
    while iter < steps && diff > 1E-6 %Loop where POCS algorithm is executed
        M_i = fft2c(m_pocs);
        M_i(1:m*ratio,:) = M_pk(1:m*ratio,:);
        m_i = ifft2c(M_i);
        m_i = abs(m_i).*p;
        diff = norm(m_i(:)- m_pocs(:)) / norm(m_pocs(:));
        iter = iter + 1;
        m_pocs = m_i;
%         %to plot each iteration result
%         %warning: be careful with the results while using with lines 65-66
%         figure(iter+3);
%         subplot(1,2,1), imshow(abs(m_i));
%         subplot(1,2,2), imshow(M_i);
    end

%--------------------------------------------------------------------------
%     subplot(2,4,4), imshow(abs(m_pocs)), title("m_p_o_c_s(x,y)");
%     subplot(2,4,8), imshow(fft2c(m_pocs)), title("M_p_o_c_s(k_x,k_y)");
%     figure("Name", "Error"), imshow(abs(abs(im)-abs(m_pocs))*5), title("||m(x,y)|-|m_p_o_c_s(x,y)||x5");
%--------------------------------------------------------------------------

    psnr_value = psnr(abs(m_pocs), abs(im));
    ssim_value = ssim(abs(m_pocs), abs(im));
end 



