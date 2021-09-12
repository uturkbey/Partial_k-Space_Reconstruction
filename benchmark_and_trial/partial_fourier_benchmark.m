%This script runs implemented partial fourier algorithms over a range of
%partial space ratio values and records both SSIM and PSNR values of
%reconstructed images wrt the original full k-Space image.

load("brain.mat")

partialSpace = [0.51:0.01:0.99];
[m, n] = size(partialSpace);

zeroPadding_psnr = zeros(m, n);
conjSynthesis_wo_PC_psnr = zeros(m, n);
conjSynthesis_w_PC_psnr = zeros(m, n);
homodyne_step_psnr = zeros(m, n);
homodyne_ramp_psnr = zeros(m, n);
pocs2_psnr = zeros(m, n);
pocs5_psnr = zeros(m, n);

zeroPadding_ssim = zeros(m, n);
conjSynthesis_wo_PC_ssim = zeros(m, n);
conjSynthesis_w_PC_ssim = zeros(m, n);
homodyne_step_ssim = zeros(m, n);
homodyne_ramp_ssim = zeros(m, n);
pocs2_ssim = zeros(m, n);
pocs5_ssim = zeros(m, n);


for i = [1:n]
    [zeroPadding_psnr(i), zeroPadding_ssim(i)] = trivial_reconstruction_by_zero_padding(im, partialSpace(i), "V");
    [conjSynthesis_wo_PC_psnr(i), conjSynthesis_wo_PC_ssim(i)] = Conjugate_Synthesis_wo_Phase_Correction(im, partialSpace(i));
    [conjSynthesis_w_PC_psnr(i), conjSynthesis_w_PC_ssim(i)] = Conjugate_Synthesis_with_Phase_Correction(im, partialSpace(i));
    [homodyne_step_psnr(i), homodyne_step_ssim(i)] = Homodyne_Reconstruction(im, partialSpace(i), "Step");
    [homodyne_ramp_psnr(i), homodyne_ramp_ssim(i)] = Homodyne_Reconstruction(im, partialSpace(i), "Ramp");
    [pocs2_psnr(i), pocs2_ssim(i)] = POCS(im, partialSpace(i), 2);
    [pocs5_psnr(i), pocs5_ssim(i)] = POCS(im, partialSpace(i), 5);
end
