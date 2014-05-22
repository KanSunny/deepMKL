function answ = TwoLayerDeriv(Kf,K,betas2,sig)

    [r,~] = size(Kf); r=sqrt(r);
    Kf = reshape(Kf,r,r); K = reshape(K,r,r);
    
    answ = betas2(1).*normalizeKernel_Grad(Kf,rbfDeriv(Kf,K,sig)) + betas2(2)*normalizeKernel_Grad(Kf,polyDeriv(Kf,K))...
        + betas2(3)*normalizeKernel_Grad(Kf,polyDeriv2(Kf,K)) + betas2(4)*normalizeKernel_Grad(Kf,linDeriv(Kf));
    
end

function answ = polyDeriv(Kf,K)
    answ = 2.*(Kf+1).*K;
end

function answ = polyDeriv2(Kf,K)
    answ = 3.*((Kf+1).^2).*K;
end

function answ = rbfDeriv(Kf,K,sig)
    answ = exp(-2/(2*sig^2).*(1-Kf)).*(2/(2*sig^2).*K);
end

function answ = linDeriv(Kf)
    answ = Kf;
end

function answ = normalizeKernel_Grad(Kf,KfDeriv)
answ = KfDeriv.*((diag(Kf)*diag(Kf)').^0.5)...
    +Kf.*(-0.5.*(diag(Kf)*diag(Kf)').^(1.5))...
    .*(diag(KfDeriv)*diag(Kf)')+(diag(Kf)*diag(KfDeriv)');
end
