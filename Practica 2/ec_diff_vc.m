function dVc_dt = ec_differential(t, Vc,Il)
    % Ecuación diferencial para el circuito
    global R Rc C
    dVc_dt = ((Il*R) - Vc)/(R + Rc)*C;
end