function generate_manuscript_datasets(outDir)
%GENERATE_MANUSCRIPT_DATASETS Regenerate deterministic model datasets for the attached paper only.
if nargin<1, outDir=fullfile(fileparts(mfilename('fullpath')),'..','generated_data'); end
if ~exist(outDir,'dir'), mkdir(outDir); end
cfg=config_parameters();
[H0,D,phi,psi]=los_vlc_channel(cfg); dmean=mean(D(:));
KB=mie_mass_extinction(cfg.lambdaB_nm,cfg.rg_um,cfg.sigma_g,cfg.mp,cfg.rho_p,cfg.rmin_um,cfg.rmax_um,cfg.mieNr);
KD=mie_mass_extinction(cfg.lambdaD_nm,cfg.rg_um,cfg.sigma_g,cfg.mp,cfg.rho_p,cfg.rmin_um,cfg.rmax_um,cfg.mieNr);
KR=mie_mass_extinction(cfg.lambdaR_nm,cfg.rg_um,cfg.sigma_g,cfg.mp,cfg.rho_p,cfg.rmin_um,cfg.rmax_um,cfg.mieNr);
dK=KR-KB;
%% Fig. 4
wl=(400:5:700).'; rgList=[0.35 0.50 0.70]; K=zeros(numel(wl),3);
for q=1:3, for k=1:numel(wl), K(k,q)=mie_mass_extinction(wl(k),rgList(q),cfg.sigma_g,cfg.mp,cfg.rho_p,cfg.rmin_um,cfg.rmax_um,cfg.mieNr); end, end
writetable(table(wl,K(:,1),K(:,2),K(:,3),'VariableNames',{'wavelength_nm','Kext_rg0p35_um_m2_per_kg','Kext_rg0p50_um_m2_per_kg','Kext_rg0p70_um_m2_per_kg'}),fullfile(outDir,'01_mie_extinction_spectrum.csv'));
%% Fig. 5
Cmg=(0:5:100).'; C=Cmg*1e-6; T=table(Cmg,'VariableNames',{'dust_concentration_mg_m3'});
for dd=[2 3 4], T.(sprintf('log_ratio_d%dm',dd))=dK*C*dd; T.(sprintf('field_transmittance_530nm_d%dm',dd))=exp(-KD*C*dd); end
writetable(T,fullfile(outDir,'02_concentration_response.csv'));
%% Fig. 6
short=(420:10:500).'; long=(600:10:690).'; R=[];
for a=1:numel(short), Ks=mie_mass_extinction(short(a),cfg.rg_um,cfg.sigma_g,cfg.mp,cfg.rho_p,cfg.rmin_um,cfg.rmax_um,cfg.mieNr); for b=1:numel(long), Kl=mie_mass_extinction(long(b),cfg.rg_um,cfg.sigma_g,cfg.mp,cfg.rho_p,cfg.rmin_um,cfg.rmax_um,cfg.mieNr); R=[R;short(a) long(b) Ks Kl abs(Kl-Ks)]; end,end %#ok<AGROW>
writetable(array2table(R,'VariableNames',{'short_wavelength_nm','long_wavelength_nm','K_short_m2_per_kg','K_long_m2_per_kg','abs_deltaK_m2_per_kg'}),fullfile(outDir,'03_pilot_pair_observability.csv'));
%% Fig. 9 geometry/channel
p0=norm(H0,'fro')^2; R=[];
for cmg=0:10:100, Hu=H0.*exp(-KD*(cmg*1e-6).*D); R=[R;cmg norm(Hu,'fro')^2/p0 10*log10(norm(Hu,'fro')^2/p0) cond(Hu)]; end %#ok<AGROW>
writetable(array2table(R,'VariableNames',{'uniform_dust_mg_m3','relative_channel_power_linear','relative_channel_power_db','condition_number'}),fullfile(outDir,'06_uniform_dust_channel.csv'));
fprintf('K450=%.3f K530=%.3f K660=%.3f deltaK=%.3f, mean path=%.4f m, cond(H)=%.4f\n',KB,KD,KR,dK,dmean,cond(H0));
end
