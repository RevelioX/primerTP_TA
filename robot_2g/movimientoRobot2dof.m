function movimientoRobot2dof(q)

%% Articulaciones
q1 =q(:,1);
q2 =q(:,2);

%% Eslabones
l1 = 5;
l2 = 5;

%% Gráfico
figure; 
h = plot(NaN, NaN); grid on
%%set(h,'EraseMode', 'xor') Comentar para usar en Octave
axis([-1 l1 + l2 -1 l1 + l2]);
xlabel('Posición x []'); ylabel('Posición y []')
title('Cinemática directa de un robot de 2 gdl')
hold on
for i = 1:length(q1)
    x1 = [0 l1 * cosd(q1(i)) l1 * cosd(q1(i)) + l2 * cosd(q1(i) + q2(i))];
    y1 = [0 l1 * sind(q1(i)) l1 * sind(q1(i)) + l2 * sind(q1(i) + q2(i))];
    set(h,'XData',x1,'YData',y1, 'linewidth',3);
    plot(x1(end), y1(end),'ro','MarkerSize',5, 'MarkerFaceColor', 'r');
    M = sprintf('q_1 = %.2fº\nq_2 = %.2fº', q1(i), q2(i));
    legend(h, M );
    drawnow
    pause(0.05);
end
disp('Aplausos, por favor')
