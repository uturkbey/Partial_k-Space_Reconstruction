load("brain.mat")

partialSpace = [0.55:0.01:0.95];
[m, n] = size(partialSpace)
zeroPadding = [m, n];
conjSynthesis_wo_PC = [m, n];
conjSynthesis_w_PC = [m, n];
homodyne_step = [m, n];
homodyne_ramp = [m, n];
pocs10 = [m, n];
pocs100 = [m, n];


for i = [1:n]
    zeroPadding(i) = trivial_reconstruction_by_zero_padding(im, partialSpace(i), "V");
    conjSynthesis_wo_PC(i) = Conjugate_Synthesis_wo_Phase_Correction(im, partialSpace(i));
    conjSynthesis_w_PC(i) = Conjugate_Synthesis_with_Phase_Correction(im, partialSpace(i));
    homodyne_step(i) = Homodyne_Reconstruction(im, partialSpace(i), "Step");
    homodyne_ramp(i) = Homodyne_Reconstruction(im, partialSpace(i), "Ramp");
    pocs10(i) = POCS(im, partialSpace(i), 10);
    pocs100(i) = POCS(im, partialSpace(i), 100);
end


% figure("Name", "Peak Signal to Noise Ratio(PSNR) of reconstructed images wrt original");
% plot(partialSpace, zeroPadding, "x--");
% hold on;
% plot(partialSpace, conjSynthesis_wo_PC, "+--");
% hold on;
% plot(partialSpace, conjSynthesis_w_PC, "*--");
% hold on;
% plot(partialSpace, homodyne_step, "d--");
% hold on;
% plot(partialSpace, homodyne_ramp, "s--");
% hold on;
% plot(partialSpace, pocs10, "v--");
% hold on;
% plot(partialSpace, pocs100, "o--");
% hold on;
% legend("Zero Padding", "Conj. Synt. w/o PC", "Conj. Synt. w/ PC", "Homodyne Step", "Homodyne Ramp", "POCS 10", "POCS 100");
% title("Partial Space Ratio vs PSNR Value");
% xlabel("Partial Space Ratio");
% ylabel("PSNR Value");
