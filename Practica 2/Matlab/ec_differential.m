function dy_dt = ec_differential(t,Y,E,u)
    global R Rc Rf Rl Rml L C 
    Vc = Y(1);
    Il = Y(2);
        
    dVc_dt = (Il*R - Vc)/((R + Rc)*C);
    dIl_dt = ( (E*u *(R + Rc)) - (Vc * R)-((R*Rc + Rf*R + Rl*R + Rml*R + Rf*Rc + Rl*Rc + Rml*Rc)*(Il)) ) / ((R + Rc) * L);

    dy_dt = [dVc_dt; dIl_dt];

end