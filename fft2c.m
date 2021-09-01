function im = fft2c(d)
%This function implements centralized Discrete Time 2D Fourier Transform
    [nx, ny, nz, nt] = size(d);
    for ii = 1:nz
        for jj = 1:nt
            im(:,:,ii,jj) = fftshift(fft2(ifftshift(d(:,:,ii,jj))));
        end
    end
end

