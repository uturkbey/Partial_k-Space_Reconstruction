%This script plots the outputs of scripts:
%               1)partial_fourier_benchmark.m 
%               2)pocs_benchmark.m

%1)partial_fourier_benchmark.m
%   PSNR values for different partial fourier reconstruction algorithms for
%   different partial space values.
figure("Name", "Peak Signal to Noise Ratio(PSNR) value of reconstructed images wrt original");
plot(partialSpace, zeroPadding_psnr, "x--");
hold on;
plot(partialSpace, conjSynthesis_wo_PC_psnr, "+--");
hold on;
plot(partialSpace, conjSynthesis_w_PC_psnr, "*--");
hold on;
plot(partialSpace, homodyne_step_psnr, "d--");
hold on;
plot(partialSpace, homodyne_ramp_psnr, "s--");
hold on;
plot(partialSpace, pocs2_psnr, "v--");
hold on;
plot(partialSpace, pocs5_psnr, "o--");
hold on;
legend("Zero Padding", "Conj. Synt. w/o PC", "Conj. Synt. w/ PC", "Homodyne Step", "Homodyne Ramp", "POCS 2", "POCS 5");
title("Partial Space Ratio vs PSNR Value");
xlabel("Partial Space Ratio");
ylabel("PSNR Value");
%   SSIM values for different partial fourier reconstruction algorithms for
%   different partial space values.
figure("Name", "Structural Similarity(SSIM) value of reconstructed images wrt original");
plot(partialSpace, zeroPadding_ssim, "x--");
hold on;
plot(partialSpace, conjSynthesis_wo_PC_ssim, "+--");
hold on;
plot(partialSpace, conjSynthesis_w_PC_ssim, "*--");
hold on;
plot(partialSpace, homodyne_step_ssim, "d--");
hold on;
plot(partialSpace, homodyne_ramp_ssim, "s--");
hold on;
plot(partialSpace, pocs2_ssim, "v--");
hold on;
plot(partialSpace, pocs5_ssim, "o--");
hold on;
legend("Zero Padding", "Conj. Synt. w/o PC", "Conj. Synt. w/ PC", "Homodyne Step", "Homodyne Ramp", "POCS 2", "POCS 5");
title("Partial Space Ratio vs SSIM Value");
xlabel("Partial Space Ratio");
ylabel("SSIM Value");


%2)pocs_benchmark.m
%   PSNR values for different partial space for different number of
%   iterations.
figure("Name", "Structural Similarity(PSNR) value of reconstructed images wrt original");
plot(iteration, psnr_values_0_51, "+--");
hold on;
plot(iteration, psnr_values_0_6, "*--");
hold on;
plot(iteration, psnr_values_0_7, "d--");
hold on;
plot(iteration, psnr_values_0_8, "s--");
hold on;
plot(iteration, psnr_values_0_9, "x--");
hold on;
legend("0.51","0.6","0.7","0.8","0.9");
title("Number of Iterations vs PSNR Value");
xlabel("Number of Iterations");
ylabel("PSNR Value");
%   SSIM values for different partial space for different number of
%   iterations.
figure("Name", "Structural Similarity(SSIM) value of reconstructed images wrt original");
plot(iteration, ssim_values_0_51, "+--");
hold on;
plot(iteration, ssim_values_0_6, "*--");
hold on;
plot(iteration, ssim_values_0_7, "d--");
hold on;
plot(iteration, ssim_values_0_8, "s--");
hold on;
plot(iteration, ssim_values_0_9, "x--");
hold on;
legend("0.51","0.6","0.7","0.8","0.9");
title("Number of Iterations vs SSIM Value");
xlabel("Number of Iterations");
ylabel("SSIM Value");

