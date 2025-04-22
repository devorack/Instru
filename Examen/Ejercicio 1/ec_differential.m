function dy_dt = ec_differential(t,Y,E,u)
    global R1 R2 L C1 C2 
    Vc1 = Y(1);
    Vc2 = Y(2);
    IL = Y(3);
    
        
    dVc1_dt = ((E - Vc1 - Vc2)*(1-u))/(R1 *C1);
    dVc2_dt = ((E - Vc1 - Vc2)*(1-u))/(R1 *C2) - IL/C2;
    dIL_dt = (-IL*R2 + Vc2)/L ;
    
   
    dy_dt = [dVc1_dt; dVc2_dt; dIL_dt;];

end