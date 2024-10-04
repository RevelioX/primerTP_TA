function p = cinematicaDirectaRobot2gdl(q)

d = 10;
a2 = 10;
a3 = 10;

theta = [q(1)+pi/2 q(2) q(3)];
d = [d 0 0];
a = [0 a2 a3]
alpha = [pi/2 0 0]


A01 = matrizDenavitHartenberg(theta(1), d(1), a(1), alpha(1))
A12 = matrizDenavitHartenberg(theta(2), d(2), a(2), alpha(2))
A23 = matrizDenavitHartenberg(theta(3), d(3), a(3), alpha(3))


TT(:,:,1) = eye(4);
TT(:,:,2) = A01;
TT(:,:,3) = A01 * A12;
TT(:,:,4) = A01 * A12 * A23;


T = A01 * A12 * A23

p = [5 5 5]

cinematicaInversaRobot3gdl(p)


dibujarSistemasDeEjesCoordenadosDeRobot(TT);
