## Exact manuscript alignment
- 4x4 VLC geometry: Tx at (±0.8, ±0.8, 4.0) m; receiver at (0.15, -0.10, 1.0) m.
- Wavelengths: 450 / 530 / 660 nm.
- Dust model: m = 1.53 + j0.002, density 1200 kg/m^3, r_g = 0.50 um, sigma_g = 1.60, radius 0.04–5 um.
- The Mie radius grid uses **90 points**, which gives Kext = 1767.416, 1831.635, 1952.889 m^2/kg and DeltaK = 185.473 m^2/kg; these round to the manuscript values 1767 / 1832 / 1953 and ~185.
- Mean optical path = 3.2110 m; dust-free 4x4 condition number = 4.9323.
- Fig. 12's exact 4x4 true/recovered dust matrices are included; their RMSE is 1.8422 mg/m^3.
- The 35-dB / 512-chip sensing reference reproduces 1.8401 mg/m^3 (~1.84 in the manuscript).
- Dynamic filtered RMSEs are 1.7100 mg/m^3 dual-color and 9.7800 mg/m^3 single-color (~1.71 and 9.78 in the manuscript).
- BER reference CSVs preserve the manuscript's 14-dB headline values: perfect 9.98e-4, proposed 8.85e-4, full 530-nm pilots 7.55e-4, single-color 1.04e-3, stale CSI 3.37e-3.

- ## Scientific status
All numerical datasets are **theoretical/simulated**. 
