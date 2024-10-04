function [q, Dq, t] = GeneracionDeTrayectorias(qi, qf, wmax, h)
    % qi = [q1i q2i q3i];       % q inicial para 3 GDL
    % qf = [q1f q2f q3f];       % q final para 3 GDL

    dof = max(size(qf));    % Grados de libertad (ahora 3 GDL)
    T = max(abs((qf - qi)) ./ wmax); % Tiempo total basado en la velocidad máxima

    wT = (qf - qi) / T;    % Velocidad constante para cada articulación

    % Inicializar tiempo y variables
    t = 0;
    q = zeros(1, dof);  % Posiciones articulares iniciales
    Dq = zeros(1, dof); % Velocidades articulares iniciales
    qdelta = 0.1 * ones(1, dof); % Umbral de error permitido en la posición
    watchDog = 1e3;  % Límite para evitar bucles infinitos
    contador = 1;
    i = 1;

    while contador < watchDog
        q(i,:) = qi' + wT' * t;   % Calcular posiciones articulares en el tiempo t
        Dq(i,:) = wT;             % Las velocidades son constantes

        % Verificar si todas las articulaciones han llegado al valor final
        condiciones_satisfechas = true;
        for j = 1:dof
            if abs(q(i,j) - qf(j)) >= qdelta(j) && ...
               (qf(j) >= qi(j) && q(i,j) <= qf(j)) && ...
               (qf(j) <= qi(j) && q(i,j) >= qf(j))
                condiciones_satisfechas = false;
                break; % Si alguna articulación no ha llegado, salimos del for
            end
        end

        if condiciones_satisfechas
            break; % Si todas las articulaciones han llegado a su posición final, terminamos el bucle
        end

        % Avanzar en el tiempo y en el índice
        t = t + h;
        i = i + 1;
        contador = contador + 1;
    end

    % Convertir el tiempo a un vector
    t = 0:h:(i-1)*h;

end
