function K = mie_mass_extinction(lambda_nm,rg_um,sigma_g,m,rho_p,rmin_um,rmax_um,Nr)
%MIE_MASS_EXTINCTION Manuscript Eq. (9), returns m^2/kg.
r = logspace(log10(rmin_um*1e-6),log10(rmax_um*1e-6),Nr).';
rg=rg_um*1e-6; lambda=lambda_nm*1e-9;
p=exp(-(log(r/rg)).^2/(2*log(sigma_g)^2)) ./ ...
  (r*log(sigma_g)*sqrt(2*pi));
q=zeros(size(r));
for k=1:numel(r), q(k)=mie_qext_sphere(m,2*pi*r(k)/lambda); end
num=trapz(r,pi*r.^2.*q.*p);
den=rho_p*trapz(r,(4*pi*r.^3/3).*p);
K=num/den;
end
