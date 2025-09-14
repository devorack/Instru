function dhdt = tanque_controlado(~, h, A, k, Qin_const, valvula_abierta)
    h = max(h, 0);  % Evita raíz de un número negativo o complejo
    Qin = valvula_abierta * Qin_const;
    Qout = k * sqrt(h);
    dhdt = (1 / A) * (Qin - Qout);
end
