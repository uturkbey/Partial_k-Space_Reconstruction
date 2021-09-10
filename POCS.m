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
    figure("Name","Original");
    subplot(1,2,1), imshow(abs(im));
    subplot(1,2,2), imshow(M_pk);
%--------------------------------------------------------------------------

    [m, n] = size(im); %learn the dimensions of image
    M_pk(m*ratio:end,:) = 0; %discard the ratio% of the samples at the bottom wrt vertical direction
    m_pk = ifft2c(M_pk); %obtain m_pk in image space

%--------------------------------------------------------------------------
    figure("Name","PF");
    subplot(1,2,1), imshow(abs(m_pk));
    subplot(1,2,2), imshow(M_pk);
%--------------------------------------------------------------------------

    M_s = zeros(m,n); %initialize the M_s 
    M_s(m*(1-ratio):m*ratio,:) = M_pk(m*(1-ratio):m*ratio,:); %obtain the symmetric data in k-Space
    m_s = ifft2c(M_s); %obtain m_s in image space
    p = exp(1i*angle(m_s)); %obtain phase correction from symmetric data 
                            %CAUTION: This phase correction function is with +i opposed toh Hmodyne or Conjugate Synthesis 
    
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
    end

%--------------------------------------------------------------------------
    figure("Name","After POCS");
    subplot(1,2,1), imshow(abs(m_pocs));
    subplot(1,2,2), imshow(fft2c(m_pocs));
%--------------------------------------------------------------------------

    psnr_value = psnr(abs(m_pocs), abs(im));
    ssim_value = ssim(abs(m_pocs), abs(im));
end 



