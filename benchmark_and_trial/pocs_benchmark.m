
%This script runs implemented POCS algorithms over a range of
%number of iterations and records both SSIM and PSNR values of
%reconstructed images wrt the original full k-Space image.

load("brain.mat")

iteration = [1:1:10];
[m, n] = size(iteration);

psnr_values_0_51 = zeros(m,n);
ssim_values_0_51 = zeros(m,n);

psnr_values_0_6 = zeros(m,n);
ssim_values_0_6 = zeros(m,n);

psnr_values_0_7 = zeros(m,n);
ssim_values_0_7 = zeros(m,n);

psnr_values_0_8 = zeros(m,n);
ssim_values_0_8 = zeros(m,n);

psnr_values_0_9 = zeros(m,n);
ssim_values_0_9 = zeros(m,n);

for i = [1:n]
   [psnr_values_0_51(i), ssim_values_0_51(i)] = POCS(im, 0.51, iteration(i));
   [psnr_values_0_6(i), ssim_values_0_6(i)] = POCS(im, 0.6, iteration(i));
   [psnr_values_0_7(i), ssim_values_0_7(i)] = POCS(im, 0.7, iteration(i));
   [psnr_values_0_8(i), ssim_values_0_8(i)] = POCS(im, 0.8, iteration(i));
   [psnr_values_0_9(i), ssim_values_0_9(i)] = POCS(im, 0.9, iteration(i));
end