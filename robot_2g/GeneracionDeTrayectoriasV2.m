function [q, Dq, t] = GeneracionDeTrayectorias(qi, qf, wmax, h)
% qi=[q1i q2i];       % q inicial
% qf=[q1f q2f];       % q final

dof = max(size(qf));    % Grados de libertad
T=max(abs((qf-qi))./wmax);

wT=(qf-qi)/T;

% Generaci�n de Trayectorias.
%h=1e-1;
t = 0;
q = zeros(length(t), dof);
Dq = zeros(length(t), dof);
qdelta = 0.1*ones(1,dof);
watchDog = 1e3;
contador = 1;
i = 1;
while contador < watchDog
    
    q(i,:)=qi'+wT'*t;       % Posici�n
    Dq(i,:)=wT;               % Velocidad
     % Verificar que ning�n valor de q(i,:) exceda los l�mites de qf considerando signos
     % Verificar para cada articulaci�n si ha alcanzado o superado el valor final
    for j = 1:dof
        % Condici�n de parada para cada articulaci�n
        if abs(q(i,j) - qf(j)) < qdelta(j) || ...  % Si est� dentro del umbral
           (qf(j) >= qi(j) && q(i,j) > qf(j)) || ... % Si se pasa del valor final
           (qf(j) <= qi(j) && q(i,j) < qf(j))       % Si se pasa del valor final en direcci�n opuesta
            break;  % Detener el bucle si cualquier articulaci�n cumple una condici�n
        end
    end
    % Si alguna articulaci�n cumple la condici�n, detener el loop principal
    if abs(q(i,j) - qf(j)) < qdelta(j) || ...
       (qf(j) >= qi(j) && q(i,j) > qf(j)) || ...
       (qf(j) <= qi(j) && q(i,j) < qf(j))
        break;  % Detener el bucle principal
    end
                
    t = t + h;
    i = i + 1;
    contador = contador + 1;
end

% dibujarTrayectorias(q, Dq, h);
% 
% disp('Press key to continue')
% pause()
% movimientoRobot2dof(q)