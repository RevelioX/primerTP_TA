close all; clear all; clc

% Definir los puntos para el corazón
t = linspace(0, 2*pi, 1000);  % 1000 puntos para el corazón
alpha = 0.5;  % Factor de inclinación (ajusta esto para cambiar la inclinación)

% Ecuaciones paramétricas del corazón
x = 16 * sin(t).^3;  % Coordenada x
y = 13 * cos(t) - 5 * cos(2*t) - 2 * cos(3*t) - cos(4*t);  % Coordenada y

% Inclinación en el eje X
z = alpha * x;  % Coordenada z, depende de x para inclinar el corazón% Constante + pequeña variación sinusoidal

% Inicialización de variables
qtotal = [0 0 0];      % Configuración inicial (3GDL)
Dqtotal = [0 0 0];     % Velocidades articulares iniciales
deltap = [0.1 0.1 0.1];  % Error tolerado en la posición
wmax = [8 2 1];        % Velocidades máximas de las articulaciones
h = 1;                 % Paso de integración

% Bucle para generar trayectorias punto a punto del corazón
for i = 1:length(x) - 1
    pi = [x(i) y(i) z(i)];         % Posición Inicial
    pf = [x(i + 1) y(i + 1) z(i + 1)];  % Posición Final

    %% Cálculo de la cinemática inversa (para 3GDL)
    qi = cinematicaInversaRobot3gdl(pi);   % Cinemática inversa (debe implementar esta función)
    qf = cinematicaInversaRobot3gdl(pf);

    %% Verificación usando la cinemática directa (para 3GDL)
    pi1 = cinematicaDirectaRobot3gdl(qi(1,:));  % Cinemática directa para verificar (debe implementar esta función)
    pi2 = cinematicaDirectaRobot3gdl(qi(2,:));
    pf1 = cinematicaDirectaRobot3gdl(qf(1,:));
    pf2 = cinematicaDirectaRobot3gdl(qf(2,:));

    % Comparación usando la norma en lugar de abs
    if (norm(pi1 - pi) < norm(deltap))
        qiElegida = qi(1,:);
    elseif (norm(pi2 - pi) < norm(deltap))
        qiElegida = qi(2,:);
    else
        disp('Ninguna configuración inicial es correcta!')
        qiElegida = qi(2,:);
        %return;  % Detener ejecución si no hay configuración válida
    end

    if (norm(pf1 - pf) < norm(deltap))
        qfElegida = qf(1,:);
    elseif (norm(pf2 - pf) < norm(deltap))
        qfElegida = qf(2,:);
    else
        qfElegida = qf(2,:);
        disp('Ninguna configuración final es correcta!')
        %return;  % Detener ejecución si no hay configuración válida
    end

    %% Generación de Trayectorias (3GDL)
    [q, Dq, t] = GeneracionDeTrayectorias(qiElegida, qfElegida, wmax, h);  % Implementar para 3GDL
    qtotal = [qtotal; q];
    Dqtotal = [Dqtotal; Dq];
end

% Eliminar los ceros iniciales
qtotal = qtotal(2:end,:);
Dqtotal = Dqtotal(2:end,:);

% Dibujar la trayectoria del corazón
figure; 
plot3(x, y, z, '*', 'linewidth', 2); grid
title('Trayectoria'); xlabel('x [cm]'); ylabel('y [cm]'); zlabel('z [cm]')

% Animar el movimiento del robot de 3GDL
disp('Presione una tecla para continuar')
pause()
movimientoDelRobot(qtotal)  % Función para simular el movimiento del robot (debe implementarla)
