function dx = ecuaciones(~, x) 
 
  global L C E Rf Rml Rl R Rc
       %continuas            discontinuas 
     %x(1) = IL(t)           x(3) = VL(t)     
     %x(2) = VC(t)           x(4) = IC(t)     
  
    dx(1) = ((-R*Rc - R*Rf - R*Rl - R*Rml - Rc*Rf - Rc*Rl - Rc*Rml)/(L*(R + Rc))* x(1)) -(((R)/(L*(R + Rc)))*x(2)) +( E/L);
    dx(2) = (R / (R+Rc)*C )* x(1) - (x(2) / ((R+Rc)*C));
    
    dx(3) = ((-(Rc+Rf+Rl+Rml)*R-Rc*(Rf+Rl+Rml))*x(3)) / (L*(R+Rc)) - ( (R*x(4)) / (C*(R+Rc)));
    
    dx(4) = ( R * x(3)) / (L*(R+Rc))-((x(4))/(C*(R+Rc)));

    dx = dx';
  end
