
function movimientoDelRobot(q)
    disp('Dibujando...')
    % Articulaciones
    q1 = q(:,1);
    q2 = q(:,2);
    q3 = q(:,3);

    % Eslabones
    d1 = 15;
    a2 = 7;
    a3 = 3;

    % Crear un gráfico 3D
    figure;
    hold on;
    grid on;
    xlabel('Posicion x [cm]');
    ylabel('Posicion y [cm]');
    zlabel('Posicion z [cm]');
    title('Cinematica directa de un robot con 3 grados de libertad');
    axis equal;

    % Inicializar los objetos gráficos
    grafico_eslabon1 = plot3([NaN NaN], [NaN NaN], [NaN NaN], 'k', 'LineWidth', 2);
    grafico_eslabon2 = plot3([NaN NaN], [NaN NaN], [NaN NaN], 'k', 'LineWidth', 3);
    grafico_eslabon3 = plot3([NaN NaN], [NaN NaN], [NaN NaN], 'k', 'LineWidth', 3);
    grafico_base = plot3(NaN, NaN, NaN, 'ro', 'MarkerSize', 10, 'MarkerFaceColor', 'r');
    grafico_articulacion2 = plot3(NaN, NaN, NaN, 'ro', 'MarkerSize', 10, 'MarkerFaceColor', 'r');
    grafico_articulacion3 = plot3(NaN, NaN, NaN, 'ro', 'MarkerSize', 10, 'MarkerFaceColor', 'r');
    grafico_efector_final = plot3(NaN, NaN, NaN, 'bo', 'MarkerSize', 10, 'MarkerFaceColor', 'b');

    for i = 1:length(q1)

        % Calculo de puntos de las articulaciones para poder graficar (Las ecuaciones son sacadas del vector p de las matrices de transformación homogenea)
        articulacion2 = [0, 0, 15];
        articulacion3 = [7*cosd(q1(i))*cosd(q2(i)), 7*sind(q1(i))*cosd(q2(i)), 7*sind(q2(i)) + 15];
        x_efector_final = -3*sind(q2(i))*sind(q3(i))*cosd(q1(i)) + 3*cosd(q1(i))*cosd(q2(i))*cosd(q3(i)) + 7*cosd(q1(i))*cosd(q2(i));
        y_efector_final = -3*sind(q1(i))*sind(q2(i))*sind(q3(i)) + 3*sind(q1(i))*cosd(q2(i))*cosd(q3(i)) + 7*sind(q1(i))*cosd(q2(i));
        z_efector_final = 3*sind(q2(i))*cosd(q3(i)) + 7*sind(q2(i)) + 3*sind(q3(i))*cosd(q2(i)) + 15;
        efector_final = [x_efector_final, y_efector_final, z_efector_final];

        % Actualizar las coordenadas de los objetos gráficos
        set(grafico_eslabon1, 'XData', [0 articulacion2(1)], 'YData', [0 articulacion2(2)], 'ZData', [0 articulacion2(3)]);
        set(grafico_eslabon2, 'XData', [articulacion2(1) articulacion3(1)], 'YData', [articulacion2(2) articulacion3(2)], 'ZData', [articulacion2(3) articulacion3(3)]);
        set(grafico_eslabon3, 'XData', [articulacion3(1) efector_final(1)], 'YData', [articulacion3(2) efector_final(2)], 'ZData', [articulacion3(3) efector_final(3)]);
        set(grafico_base, 'XData', 0, 'YData', 0, 'ZData', 0);
        set(grafico_articulacion2, 'XData', articulacion2(1), 'YData', articulacion2(2), 'ZData', articulacion2(3));
        set(grafico_articulacion3, 'XData', articulacion3(1), 'YData', articulacion3(2), 'ZData', articulacion3(3));
        set(grafico_efector_final, 'XData', efector_final(1), 'YData', efector_final(2), 'ZData', efector_final(3));

        %Dibujar trayectoria realizada por el TCP
        plot3(x_efector_final, y_efector_final, z_efector_final, 'bo', 'MarkerSize', 10, 'MarkerFaceColor', 'g');

        % Mostrar valores de las articulaciones en las leyendas del gráfico
        leyendas = sprintf('q_1 = %.2f°\nq_2 = %.2f°\nq_3 = %.2f°', q1(i), q2(i), q3(i));
        legend(leyendas);

        % Mostrar la figura
        drawnow;
        pause(0.2);
    end
    disp('Aplausos, por favor. (Tomamos prestado sus aplausos profe)')
end