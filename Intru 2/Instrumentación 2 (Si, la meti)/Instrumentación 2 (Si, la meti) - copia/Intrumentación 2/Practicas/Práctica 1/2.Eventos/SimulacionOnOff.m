function SimulacionOnOff
global a A qi n  % Defino las variables globales

    a =  0.1287; %0.13679 0.138 
    n = 0.2399; % 0.23199 0.22899
    A = 85.274; %Area transversal del tanque 92.90 85.27 89.99
    qiGPM = 5.75;
    qi = qiGPM*(3.85); %Flujo de entrada del tanque
     
    
    % Valores de tiempo de simulacion
    tt = [];
    %Valores de la salida (altura)
    yy = [];
    %Variacion del tiempo
    tspan = 0:1:1000;
    %Condicion inicial
    h0 = 0;
    
     
    %%Sacar data de archivos a un vector 
    filename3 = importdata('F0002CH2.CSV',',',0);
    filename4 = importdata('F0003CH2.CSV',',',0);
    filename5 = importdata('F0004CH2.CSV',',',0);
    filename6 = importdata('F0005CH2.CSV',',',0);
    
    v3t = filename3(1:1200,4);
    v3  = filename3(1:1200,5);%2
    
    v4t = filename4(1:1834,4);
    v4  = filename4(1:1834,5);%3
    
    v5t = filename5(1:1943,4);
    v5  = filename5(1:1943,5);%4
    
    v6t = filename6(1:903,4);
    v6  = filename6(1:903,5);%5


    for i = 1:length(v3t)
      v3t(i) = v3t(i) + (446.2);
    end


    for i = 1:length(v4t)
      v4t(i) = v4t(i) + (446.2+246);
    end    
    
    for i = 1:length(v5t)
      v5t(i) = v5t(i) + (446.2+246+370);
    end
     
    for i = 1:length(v6t)
     v6t(i) = v6t(i) + (446.2+246+370+392);
    end

DataTime= vertcat(v3t, v4t, v5t, v6t);
DataVolt= vertcat(v3, v4, v5, v6);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Simulacion y calculo numerico de la solucion
    for i=1:3
        %Subida
        qi = qiGPM*(3.85);
        options=odeset('Events',@evento1);
        [t,y]=ode23(@tanque1,tspan,h0,options);
        tt=[tt;t];
        yy=[yy;y];
        tspan =  [t(end) max(t(end)+1, 1000*i)];
        h0 = y(length(y));

        %Bajada
        qi=0; %Valor de la entrada
        options=odeset('Events',@evento2);
        [t,y]=ode23(@tanque1,tspan,h0,options);
        tt=[tt;t]; 
        yy=[yy;y];
        tspan= [t(end) max(t(end)+1, 1000*i)];
        h0=y(length(y));
    end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    figure(1);
    plot((DataTime(:)-460),((6.17*DataVolt(:)+1.072)-0.8),'b',tt,yy,'r');
    title('Simulacion Control On/Off');
    xlabel('Tiempo');
    ylabel('Altura');
    legend('Experimental','Teorico')
    grid on 
end

function dy = tanque1(t,y)
    global n a qi A
    dy = (qi/A)-(a*y^n);
end

%Limite superior
function [value,isterminal,direction]=evento1(t,y)    
    value = y - 15;
    isterminal = 1;   
    direction = 1;
end

%Limite inferior
function [value,istermal,direction]=evento2(t,y)
    value = y - 7.5;
    istermal = 1;
    direction = -1;
end

