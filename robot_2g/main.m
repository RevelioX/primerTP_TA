%% Generación de trayectorias completo
% Robot de 2gdl, https://www.geogebra.org/m/espsungm
close all; clear all; clc
%% Posición inicial y final
pi = [10 0];   % Posición Inicial
pf = [8 1];   % Posición Final

%pi = [8 2];   % Posición Inicial
%pf = [8 4];   % Posición Final

deltap = [0.01 0.01];      % Error tolerado en la posición
wmax = [2 2];       % Velocidades máximas de las articulaciones
h = 1;            % paso de integración

%% Cálculo de la cinemática inversa. 
% Se devuelven dos configuraciones posibles: codo arriba y codo abajo
qi = cinematicaInversaRobot2gdl(pi);
qf = cinematicaInversaRobot2gdl(pf);

%% Verificación usando la cinemática directa
% Puede ocurrir que alguna de las configuraciones propuestas por la CI no
% sea correcta.
pi1 = cinematicaDirectaRobot2gdl(qi(1,:));
pi2 = cinematicaDirectaRobot2gdl(qi(2,:));
pf1 = cinematicaDirectaRobot2gdl(qf(1,:));
pf2 = cinematicaDirectaRobot2gdl(qf(2,:));

if (abs(pi1 - pi ) < deltap(1))
    qiElegida = qi(1,:);
elseif (abs(pi2 - pi ) < deltap(2))
    qiElegida = qi(1,:);
else
    disp('Ninguna configuración funciona!')
end

if (abs(pf1 - pf ) < deltap(1))
    qfElegida = qf(1,:);
elseif (abs(pf2 - pf ) < deltap(2))
    qfElegida = qf(1,:);
else
    disp('Ninguna configuración funciona!')
end

%% Generacion de Trayectorias
[q, Dq, t] = GeneracionDeTrayectorias(qiElegida, qfElegida, wmax, h);
dibujarTrayectorias(q, Dq, h);

disp('Press key to continue')
pause()
movimientoRobot2dof(q)
 
    