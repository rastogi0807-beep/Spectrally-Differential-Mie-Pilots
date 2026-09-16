function [H,D,phi_deg,psi_deg]=los_vlc_channel(cfg)
%LOS_VLC_CHANNEL Manuscript Eqs. (1)-(3), 4x4 geometry from Table 2.
mL=-log(2)/log(cosd(cfg.ledHalfPower_deg));
g=cfg.nConc^2/(sind(cfg.fov_deg)^2);
H=zeros(4); D=zeros(4); phi_deg=zeros(4); psi_deg=zeros(4);
for i=1:4
 az=cfg.pdAzimuth_deg(i); tilt=cfg.pdTilt_deg;
 nPD=[sind(tilt)*cosd(az), sind(tilt)*sind(az), cosd(tilt)];
 for j=1:4
  v=cfg.tx(j,:)-cfg.rx; d=norm(v); u=v/d;
  cosphi=dot([0 0 -1],-u); cospsi=dot(nPD,u);
  phi=acosd(max(-1,min(1,cosphi))); psi=acosd(max(-1,min(1,cospsi)));
  D(i,j)=d; phi_deg(i,j)=phi; psi_deg(i,j)=psi;
  if psi<=cfg.fov_deg && cosphi>0 && cospsi>0
   H(i,j)=((mL+1)*cfg.A_PD/(2*pi*d^2))*cosphi^mL*cfg.Ts*g*cospsi;
  end
 end
end
end
