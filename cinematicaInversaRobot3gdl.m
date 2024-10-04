function q = cinematicaInversa(p)
l1 = 10;
l2 = 10;
l3 = 10;

x = p(1);
y = p(2);
z = p(3);

q1 = atan2d(y, x);
if isnan(q1)
  disp('Cuidado! Argumento de la tangente con 0s')
end

sqrt_termino = sqrt(x^2 + y^2);

cos_q3 = (x^2 + y^2 + z^2 - l2^2 - l3^2) / (2 * l2 * l3);


if abs(cos_q3) > 1
        error('No hay solución real para los ángulos con los parámetros dados');
end

q3(1) = atan2d(sqrt(1 - cos_q3^2), cos_q3);

q3(2) = -atan2d(sqrt(1 - cos_q3^2), cos_q3);


q2(1) = atan2d(z, sqrt_termino) - atan2d((l3 * sind(q3(1))), (l2 + l3 * cos_q3));

q2(2) = - atan2d(z, sqrt_termino) - atan2d((l3 * sind(q3(2))), (l2 + l3 * cos_q3));

q = [q1, q2(1), q3(1);
     q1, q2(2), q3(2)
    ];
end
