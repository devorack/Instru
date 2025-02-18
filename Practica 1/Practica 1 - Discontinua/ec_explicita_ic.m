function Vc = calcular_Vc(t, R2, Req, Rm, C, Ic0)
    % Funci�n para calcular Vc(t) dado los par�metros
    Vc = exp(-((R2 + Req) * t * 1 )/ ((R2 * Req + R2 * Rm + Req * Rm) *  C)) * Ic0;
end