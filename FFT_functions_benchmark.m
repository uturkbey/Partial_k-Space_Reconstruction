%This basic script compares four different implementations of Discrete Time
%2D Fourier Transform functions.

%Functions used includes built in fft/ifft, fftshift/ifftshift, fft2/ifft2
%and custom fft2c/ifft2c.

%Result: Although k-Space representations of the same image looks different
%for different functions, all of the reconstructed images using the according
%inverse functions results in the same image.

load("brain.mat") %Obtained from http://web.stanford.edu/class/ee369c/data/

%Calculating fourier transforms of the image using different functions
im_k = fft2(im);
im_k_c = fft2c(im);
im_k_fft = fft(im);
im_k_fftshift = fftshift(im);

%Plotting k-Space representations of image with different functions
figure("Name", "k-Spaces")
subplot(2,2,1), imshow(im_k), title("im k")
subplot(2,2,2), imshow(im_k_c), title("im k c")
subplot(2,2,3), imshow(im_k_fft), title("im k fft")
subplot(2,2,4), imshow(im_k_fftshift), title("im k fftshift")

%Calculing inverse fourier transform of k-space images using different functions
im_t = ifft2(im_k);
im_t_c = ifft2c(im_k_c);
im_t_fft = ifft(im_k_fft);
im_t_fftshift = ifftshift(im_k_fftshift);

%Plotting reconstructed versions of image with different functions
figure("Name", "Reconstruction from k-spaces")
subplot(2,2,1), imshow(abs(im_t)), title("im t")
subplot(2,2,2), imshow(abs(im_t_c)), title("im t c")
subplot(2,2,3), imshow(abs(im_t_fft)), title("im t fft")
subplot(2,2,4), imshow(abs(im_t_fftshift)), title("im t fftshift")

%Normalizing reconstructed images
im_t = (im_t - min(min(im_t))) / max(max(im_t));
im_t_c = (im_t_c - min(min(im_t_c))) / max(max(im_t_c));
im_t_fft = (im_t_fft - min(min(im_t_fft))) / max(max(im_t_fft));
im_t_fftshift = (im_t_fftshift - min(min(im_t_fftshift))) / max(max(im_t_fftshift));

%Finding the difference of two reconstructed image
diff_1 = im_t_c - im_t;
diff_2 = im_t - im_t_fft;
diff_3 = im_t - im_t_fftshift;

%Plotting difference of reconstructed images
figure("Name", "Differences")
subplot(1,3,1), imshow(abs(diff_1)*100), title("im t - im t c")
subplot(1,3,2), imshow(abs(diff_2)*100), title("im t - im t fft")
subplot(1,3,3), imshow(abs(diff_3)*100), title("im t - im t fftshift")

function im = fft2c(d)
%This function implements centralized Discrete Time 2D Fourier Transform
    [nx, ny, nz, nt] = size(d);
    for ii = 1:nz
        for jj = 1:nt
            im(:,:,ii,jj) = fftshift(fft2(ifftshift(d(:,:,ii,jj))));
        end
    end
end

function im = ifft2c(d)
%This function implements centralized Discrete Time 2D Inverse Fourier Transform
    [nx, ny, nz, nt] = size(d);
    for ii = 1:nz
        for jj = 1:nt
            im(:,:,ii,jj) = fftshift(ifft2(ifftshift(d(:,:,ii,jj))));
        end
    end
end
