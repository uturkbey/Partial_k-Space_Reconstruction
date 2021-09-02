load("brain.mat")

Conjugate_Synthesis_wo_Phase_Correction(im,0.6)

Conjugate_Synthesis_with_Phase_Correction(im, 0.6)

Homodyne_Reconstruction(im,0.6,"Step")
Homodyne_Reconstruction(im,0.6,"Ramp")
% 
% filt = zeros(96,96);
% filt(26:72,:) = 1;    % L
% filt(1:25,:) = 2;     % H
% plt(filt,'Homodyne Filter')
% 
% filt2 = smoothdata(filt,1,'gaussian',48);
% plt(filt2,'Smoothed Homodyne Filter')
% 
% function plt(data,label)
%     plot(data,'linewidth',2);
%     grid on;
%     title(label);
%     hold on;
% end
