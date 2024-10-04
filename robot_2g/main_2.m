%% Generaci�n de trayectorias completo
% Robot de 2gdl, https://www.geogebra.org/m/espsungm
close all; clear all; clc
%% Coordenadas de la recta
p = 0.5;        % No cambiar para mantener las dimensiones de x e y iguales

y = [0:1-p 1:p:5 5*ones(1,6)];
x = [10 7 * ones(1,9) 7-p:-p:4];
qtotal = [0 0];
Dqtotal = [0 0];
deltap = [0.01 0.01];      % Error tolerado en la posici�n
wmax = [8 2];       % Velocidades m�ximas de las articulaciones
h = 1;            % Paso de integraci�n del generador de trayectorias.
for i = 1: length(y) - 1
    pi = [x(i) y(i)];           % Posici�n Inicial
    pf = [x(i + 1) y(i + 1)];   % Posici�n Final
   
    

    %% C�lculo de la cinem�tica inversa. 
    % Se devuelven dos configuraciones posibles: codo arriba y codo abajo
    qi = cinematicaInversaRobot2gdl(pi);
    qf = cinematicaInversaRobot2gdl(pf);

    %% Verificaci�n usando la cinem�tica directa
    % Puede ocurrir que alguna de las configuraciones propuestas por la CI no
    % sea correcta.
    pi1 = cinematicaDirectaRobot2gdl(qi(1,:));
    pi2 = cinematicaDirectaRobot2gdl(qi(2,:));
    pf1 = cinematicaDirectaRobot2gdl(qf(1,:));
    pf2 = cinematicaDirectaRobot2gdl(qf(2,:));

    if (abs(pi1 - pi ) < deltap)
        qiElegida = qi(1,:);
    elseif (abs(pi2 - pi ) < deltap)
        qiElegida = qi(1,:);
    else
        disp('Ninguna configuraci�n funciona!')
    end

    if (abs(pf1 - pf ) < deltap)
        qfElegida = qf(1,:);
    elseif (abs(pf2 - pf ) < deltap)
        qfElegida = qf(1,:);
    else
        disp('Ninguna configuraci�n funciona!')
    end

    %% Generacion de Trayectorias
    [q, Dq, t] = GeneracionDeTrayectorias(qiElegida, qfElegida, wmax, h);
    qtotal = [qtotal; q];
    Dqtotal = [Dqtotal; Dq];
end
% Borrar los ceros iniciales
qtotal = qtotal(2:end,:);
Dqtotal = Dqtotal(2:end,:);
dibujarTrayectorias(qtotal, Dqtotal, h);
figure; 
plot(x,y,'*', 'linewidth', 2); grid
title('Trayectoria Propuesta'); xlabel('x [cm]'); ylabel('y [cm]')
disp('Press key to continue')
pause()
movimientoRobot2dof(qtotal)
 
    