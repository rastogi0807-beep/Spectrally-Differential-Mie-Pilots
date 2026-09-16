function Qext = mie_qext_sphere(m,x)
%MIE_QEXT_SPHERE Extinction efficiency from manuscript Eqs. (6)-(8).
if x <= 0, error('x must be positive'); end
nmax = ceil(x + 4*x^(1/3) + 2);
n = (0:nmax).';
psi_x  = sqrt(pi*x/2) .* besselj(n+0.5,x);
chi_x  = sqrt(pi*x/2) .* bessely(n+0.5,x);
xi_x   = psi_x + 1i*chi_x;
mx = m*x;
psi_mx = sqrt(pi*mx/2) .* besselj(n+0.5,mx);
nn=(1:nmax).';
psi_x_p  = psi_x(1:end-1)  - (nn/x).*psi_x(2:end);
xi_x_p   = xi_x(1:end-1)   - (nn/x).*xi_x(2:end);
psi_mx_p = psi_mx(1:end-1) - (nn/mx).*psi_mx(2:end);
psi_x_n=psi_x(2:end); xi_x_n=xi_x(2:end); psi_mx_n=psi_mx(2:end);
an=(m.*psi_mx_n.*psi_x_p - psi_x_n.*psi_mx_p) ./ ...
   (m.*psi_mx_n.*xi_x_p  - xi_x_n.*psi_mx_p);
bn=(psi_mx_n.*psi_x_p - m.*psi_x_n.*psi_mx_p) ./ ...
   (psi_mx_n.*xi_x_p  - m.*xi_x_n.*psi_mx_p);
Qext=(2/x^2)*sum((2*nn+1).*real(an+bn));
end
