function p = cinematicaDirectaRobot2gdl(q)
%% Modelado de este robot: https://www.geogebra.org/m/espsungm

%% Constantes
l1 = 5;
l2 = 5;
%% Cálculo de la Cinemática Directa
x = l1 * cosd(q(1)) + l2 * cosd(q(1) + q(2));
y = l1 * sind(q(1)) + l2 * sind(q(1) + q(2));
p = [x y];