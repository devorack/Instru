function dx = ordentresecus(~, x)
global Rc1 Rc2 R2 C1 C2 L E U;

%dx = zeros(2,1); % Asegurar que dx es un vector columna de 2 elementos

dx(1) = ((E - Rc1*x(1) - x(2))/L  )*(1-U) + (-R2*Rc1*Rc2 - 2*Rc1*Rc2^2)*x(1)/(L*(R2*Rc1 + R2*Rc2 + Rc1*Rc2 + 2*Rc2^2)) + (-R2*Rc2 - 2*Rc2^2)*x(2)/(L*(R2*Rc1 + R2*Rc2 + Rc1*Rc2 + 2*Rc2^2)) - Rc1*R2*x(3)/(L*(R2*Rc1 + R2*Rc2 + Rc1*Rc2 + 2*Rc2^2)) + (E*R2*Rc1 + E*R2*Rc2 + E*Rc1*Rc2 + 2*E*Rc2^2)/(L*(R2*Rc1 + R2*Rc2 + Rc1*Rc2 + 2*Rc2^2)) ; % Il
dx(2) =  (x(1)/C1)*(1-U)+ (R2*Rc2 + 2*Rc2^2)*x(1)/(C1*(R2*Rc1 + R2*Rc2 + Rc1*Rc2 + 2*Rc2^2)) + (-R2 - Rc2)*x(2)/(C1*(R2*Rc1 + R2*Rc2 + Rc1*Rc2 + 2*Rc2^2)) + x(3)*R2/(C1*(R2*Rc1 + R2*Rc2 + Rc1*Rc2 + 2*Rc2^2)); % Vc1
dx(3) =  (-x(3)/(C2*(R2 + Rc2)))*(1-U) + (R2*Rc1 + 2*Rc1*Rc2)*x(1)/(C2*(R2*Rc1 + R2*Rc2 + Rc1*Rc2 + 2*Rc2^2)) + (R2 + 2*Rc2)*x(2)/(C2*(R2*Rc1 + R2*Rc2 + Rc1*Rc2 + 2*Rc2^2)) + (-R2 - Rc1 - 2*Rc2)*x(3)/(C2*(R2*Rc1 + R2*Rc2 + Rc1*Rc2 + 2*Rc2^2)) ; %vc2
dx=dx';
end
