function datos = LeerData()

%archivo = csvread('./Data/TanqueAbierto.csv', 1, 0); 
%tiempoTanqueAbierto = archivo(:, 1);
%voltajeTanqueAbierto = archivo(:, 2);
%figure(2);
%subplot(4, 1, 4);

%plot(tiempoTanqueAbierto,((voltajeTanqueAbierto*p1) + p2)-1.1,'r');
%hold on;
    %RelacionProcentajePulgaga
    archivo = csvread('./Data/RelacionProcentajePulgaga.csv', 1, 0); 
    porcentaje = archivo(:, 1);
    pulgadas = archivo(:, 2);

        figure(2);
        plot(porcentaje,pulgadas,'r');
        xlabel('porcentaje');
        ylabel('pulgadas X');
        title('RelacionProcentajePulgaga');
        hold on;

    %DesplazamientoBastago
    archivo = csvread('./Data/DesplazamientoBastago.csv', 1, 0); 
    tiempo = archivo(:, 1);
    data = archivo(:, 2);

        figure(1);
        subplot(4, 1, 1);
        plot(tiempo-0.4, data/1000);
        xlabel('Tiempo');
        ylabel('Desplazamiento X');
        title('Desplazamiento vastago');
        hold on;

flujoDesaplazamiento = csvread('./Data/FlujoDesaplazamiento.csv', 1, 0); 
Q = flujoDesaplazamiento(:, 1);
X_F = flujoDesaplazamiento(:, 2);
%figure(2);
%plot(X_F, Q,'r');
%hold on;
end