load("brain.mat")

a =  Conjugate_Synthesis_wo_Phase_Correction(im,0.6)
% Conjugate_Synthesis_with_Phase_Correction(im, 0.6)
% Homodyne_Reconstruction(im,0.6,"Step")
 b = Homodyne_Reconstruction(im,0.6,"Ramp")

% trivial_reconstruction_by_zero_padding(im, 0.6, "V")