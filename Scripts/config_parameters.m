function cfg = config_parameters()
%CONFIG_PARAMETERS Paper-specific parameters from the attached manuscript:
% Spectrally Differential Mie Pilots for Link-Resolved Dust Sensing and
% Self-Calibrated MIMO Visible-Light Communication.
% No parameters from other manuscripts are included.
cfg.lambdaB_nm = 450; cfg.lambdaD_nm = 530; cfg.lambdaR_nm = 660;
cfg.mp = 1.53 + 1i*0.002; cfg.rho_p = 1200;
cfg.rg_um = 0.50; cfg.sigma_g = 1.60; cfg.rmin_um = 0.04; cfg.rmax_um = 5.0;
cfg.mieNr = 90; %% reproduces rounded manuscript anchors: 1767/1832/1953 m^2/kg
cfg.tx = [-0.8 -0.8 4.0; -0.8 0.8 4.0; 0.8 -0.8 4.0; 0.8 0.8 4.0];
cfg.rx = [0.15 -0.10 1.0];
cfg.pdAzimuth_deg = [225 315 135 45]; cfg.pdTilt_deg = 40;
cfg.fov_deg = 50; cfg.A_PD = 1e-4; cfg.nConc = 1.5; cfg.Ts = 1.0;
cfg.ledHalfPower_deg = 60;
%% Exact nonuniform plume factors shown in manuscript Fig. 12 at mean 70 mg/m^3
cfg.plume = [1.35 1.10 0.85 0.65; 1.20 1.25 0.90 0.75; ...
             0.95 1.05 1.30 1.15; 0.70 0.85 1.10 1.40];
end
