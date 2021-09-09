load("brain.mat")

partialSpace = [0.55:0.01:0.95];
[m, n] = size(partialSpace)

zeroPadding_psnr = zeros(m, n);
conjSynthesis_wo_PC_psnr = zeros(m, n);
conjSynthesis_w_PC_psnr = zeros(m, n);
homodyne_step_psnr = zeros(m, n);
homodyne_ramp_psnr = zeros(m, n);
pocs10_psnr = zeros(m, n);
pocs100_psnr = zeros(m, n);

zeroPadding_ssim = zeros(m, n);
conjSynthesis_wo_PC_ssim = zeros(m, n);
conjSynthesis_w_PC_ssim = zeros(m, n);
homodyne_step_ssim = zeros(m, n);
homodyne_ramp_ssim = zeros(m, n);
pocs10_ssim = zeros(m, n);
pocs100_ssim = zeros(m, n);


for i = [1:n]
    [zeroPadding_psnr(i), zeroPadding_ssim(i)] = trivial_reconstruction_by_zero_padding(im, partialSpace(i), "V");
    [conjSynthesis_wo_PC_psnr(i), conjSynthesis_wo_PC_ssim(i)] = Conjugate_Synthesis_wo_Phase_Correction(im, partialSpace(i));
    [conjSynthesis_w_PC_psnr(i), conjSynthesis_w_PC_ssim(i)] = Conjugate_Synthesis_with_Phase_Correction(im, partialSpace(i));
    [homodyne_step_psnr(i), homodyne_step_ssim(i)] = Homodyne_Reconstruction(im, partialSpace(i), "Step");
    [homodyne_ramp_psnr(i), homodyne_ramp_ssim(i)] = Homodyne_Reconstruction(im, partialSpace(i), "Ramp");
    [pocs10_psnr(i), pocs10_ssim(i)] = POCS(im, partialSpace(i), 10);
    [pocs100_psnr(i), pocs100_ssim(i)] = POCS(im, partialSpace(i), 100);
end
