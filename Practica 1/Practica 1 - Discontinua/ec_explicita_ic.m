function Vc = calcular_Vc(t, R2, Req, Rm, C, Ic0)
    % Función para calcular Vc(t) dado los parámetros
    Vc = exp(-((R2 + Req) * t * 1 )/ ((R2 * Req + R2 * Rm + Req * Rm) *  C)) * Ic0;
end