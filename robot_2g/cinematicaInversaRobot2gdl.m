function q = cinematicaInversaRobot2gdl(p)
%% Modelado de este robot: https://www.geogebra.org/m/espsungm
%% Constantes
l1 = 5;
l2 = 5;
%% Variables definidas por el usuario
x = p(1);
y = p(2);
%% Cálculo de la Cinemática inversa
argCos = (x^2 + y^2 - l1^2 - l2^2) / (2 * l1 * l2);
if (abs(argCos) > 1)
    argCos = sign(argCos);
    disp('Cuidado! Argumento del coseno > 1')
end

q2(1) = -acosd(argCos);
q2(2) = acosd(argCos);

q1(1) = atan2d(y, x) - atan2d(l2 * sind(q2(1)) , (l1 + l2 * cosd(q2(1))));
q1(2) = atan2d(y, x) - atan2d(l2 * sind(q2(2)) , (l1 + l2 * cosd(q2(2))));
q = [q1' q2'];