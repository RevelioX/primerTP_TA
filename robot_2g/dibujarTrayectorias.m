function dibujarTrayectorias(q,Dq, h)
t = 0:h:length(q) * h - h;
figure
subplot(211)
colors_q = lines(size(q, 2));

for i = 1:size(q,2)
    stem(t, q(:,i), 'linewidth', 2, 'DisplayName', ['q_', num2str(i)], 'Color', colors_q(i, :));
    hold on
end
grid on
axis([0 t(end) min(q(:))-5 max(q(:))+5])
xlabel('Tiempo [seg]'); ylabel('q [rad]');
title('Generador de Trayectorias');
legend('show');


subplot(212),
for i= 1: size(Dq,2)
    stem(t, Dq(:,i), 'linewidth', 2, 'DisplayName', ['Dq_', num2str(i)], 'Color', colors_q(i, :));
    hold on
end
grid on
axis([0 t(end) min(Dq(:))-0.5 max(Dq(:))+0.5])
xlabel('Tiempo [seg]'); ylabel('\omega [rad/seg]')
legend('show');




