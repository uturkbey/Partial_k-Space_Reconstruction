load("brain.mat")

zeroPadding = [];
conjSynthesis_wo_PC = [];
conjSynthesis_w_PC = [];
homodyne_step = [];
homodyne_ramp = [];
pocs10 = [];
pocs100 = [];

partialSpace = [0.45:0.01:0.95]

for r = partialSpace
    zeroPadding = [zeroPadding, trivial_reconstruction_by_zero_padding(im, r, "V")];
    conjSynthesis_wo_PC = [conjSynthesis_wo_PC, Conjugate_Synthesis_wo_Phase_Correction(im, r)];
    conjSynthesis_w_PC = [conjSynthesis_w_PC, Conjugate_Synthesis_with_Phase_Correction(im, r)];
    homodyne_step = [homodyne_step, Homodyne_Reconstruction(im, r, "Step")];
%    homodyne_ramp = [homodyne_ramp, Homodyne_Reconstruction(im, r, "Ramp")];
    pocs10 = [pocs10, POCS(im, r, 10)];
    pocs100 = [pocs100, POCS(im, r, 100)];
end

figure("Name", "Peak Signal to Noise Ratio(PSNR) of reconstructed images wrt original");
plot(partialSpace, zeroPadding, "x");
hold on;
plot(partialSpace, conjSynthesis_wo_PC, "+");
hold on;
plot(partialSpace, conjSynthesis_w_PC, "*");
hold on;
plot(partialSpace, homodyne_step, "d");
hold on;
% plot(partialSpace, homodyne_ramp);
% hold on;
plot(partialSpace, pocs10, "v");
hold on;
plot(partialSpace, pocs100, "o");
hold on;
legend;