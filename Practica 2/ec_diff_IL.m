function dIL_dt = ec_diff_IL(t, Vc,Il, E,u)
    global R Rc Rf Rl Rml L  
    dIL_dt = ((-(R*Rc) - (Rf*R) - (Rl*R) - (Rml*R) - (Rf*Rc) - (Rl*Rc) - (Rml*Rc))*Il + (u*E*(R + Rc)) - (Vc*R))/(R + Rc)*L;
end