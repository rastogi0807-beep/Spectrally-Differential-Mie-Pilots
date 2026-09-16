function plot_reference_figures()
%PLOT_REFERENCE_FIGURES Plots paper-specific datasets shipped in ../data.
root=fileparts(mfilename('fullpath')); dataDir=fullfile(root,'..','data'); outDir=fullfile(root,'..','generated_figures');
if ~exist(outDir,'dir'), mkdir(outDir); end
%% Fig 4
T=readtable(fullfile(dataDir,'01_mie_extinction_spectrum.csv')); figure; plot(T.wavelength_nm,T.Kext_rg0p35_um_m2_per_kg,'-o',T.wavelength_nm,T.Kext_rg0p50_um_m2_per_kg,'-o',T.wavelength_nm,T.Kext_rg0p70_um_m2_per_kg,'-o'); grid on; xlabel('Wavelength (nm)'); ylabel('K_{ext} (m^2 kg^{-1})'); legend('r_g=0.35 um','r_g=0.50 um','r_g=0.70 um'); exportgraphics(gcf,fullfile(outDir,'Fig04_mie_extinction.png'),'Resolution',250); close;
%% Fig 7
T=readtable(fullfile(dataDir,'04_rmse_vs_pilot_snr.csv')); figure; hold on; for N=[32 128 512], I=T.coherent_average_chips==N; semilogy(T.pilot_snr_db_per_chip(I),T.rmse_mg_m3(I),'-o','DisplayName',sprintf('%d chips',N)); end; grid on; xlabel('Per-chip pilot SNR (dB)'); ylabel('Dust concentration RMSE (mg m^{-3})'); legend; exportgraphics(gcf,fullfile(outDir,'Fig07_rmse_vs_snr.png'),'Resolution',250); close;
%% Fig 10
T=readtable(fullfile(dataDir,'07_ber_vs_snr_reference.csv')); figure; hold on; C=unique(T.receiver_case,'stable'); for k=1:numel(C), I=strcmp(T.receiver_case,C{k}); semilogy(T.electrical_snr_db(I),T.ber(I),'-o','DisplayName',strrep(C{k},'_',' ')); end; grid on; xlabel('Electrical SNR per receive branch (dB)'); ylabel('QPSK BER'); legend; exportgraphics(gcf,fullfile(outDir,'Fig10_ber_vs_snr.png'),'Resolution',250); close;
%% Fig 11
T=readtable(fullfile(dataDir,'08_ber_vs_dust_reference.csv')); figure; hold on; C=unique(T.receiver_case,'stable'); for k=1:numel(C), I=strcmp(T.receiver_case,C{k}); semilogy(T.mean_dust_mg_m3(I),T.ber(I),'-o','DisplayName',strrep(C{k},'_',' ')); end; grid on; xlabel('Dust concentration (mg m^{-3})'); ylabel('QPSK BER'); legend; exportgraphics(gcf,fullfile(outDir,'Fig11_ber_vs_dust.png'),'Resolution',250); close;
end
