function [ber,nErr,nBits]=qpsk_mimo_ber(Htrue,Hest,snr_dB,seed,nFrames,nSym)
%QPSK_MIMO_BER Independent seeded Monte-Carlo verifier for manuscript Eq. (18)-(20).
rng(seed,'twister');
Ps=trace(Htrue*Htrue')/4; noiseVar=Ps/10^(snr_dB/10);
W=(Hest'*Hest + noiseVar*eye(4))\Hest';
nErr=0; nBits=0;
for f=1:nFrames
 b=randi([0 1],4,nSym,2);
 X=((1-2*b(:,:,1))+1i*(1-2*b(:,:,2)))/sqrt(2);
 N=sqrt(noiseVar/2)*(randn(4,nSym)+1i*randn(4,nSym));
 Xh=W*(Htrue*X+N);
 nErr=nErr+nnz((real(Xh)<0)~=logical(b(:,:,1)))+nnz((imag(Xh)<0)~=logical(b(:,:,2)));
 nBits=nBits+numel(b(:,:,1))+numel(b(:,:,2));
end
ber=nErr/nBits;
end
