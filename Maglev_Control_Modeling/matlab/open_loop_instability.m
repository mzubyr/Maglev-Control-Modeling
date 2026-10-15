% Magnetic Levitation System - Open-Loop Instability Demonstration
% Author: Muhammad Ibrahim Zubair
% Description: 
%   1. Computes eigenvalues of the linearized system
%   2. Simulates open-loop response from a small initial disturbance
%   3. Plots the unstable behavior of position, velocity and current

clear; clc; close all;

%% Linearized system matrices
A = [  0      1       0    ;
     3924     0   -28.03  ;
       0      0     -40   ];

B = [ 0 ;
      0 ;
     20 ];

%% 1. Eigenvalue analysis
eig_A = eig(A);
disp('Eigenvalues of A matrix:');
disp(eig_A);

% Check stability
if any(real(eig_A) > 0)
    disp('Result: System is UNSTABLE (has eigenvalue with positive real part)');
else
    disp('Result: System is stable');
end

%% 2. Open-loop simulation (no control input)
% Small initial disturbance in position (1 mm)
x0 = [0.001; 0; 0];   % [delta_z; delta_v; delta_i]

tspan = 0:0.001:0.15;  % short time window (system diverges quickly)

% Simulate: dx/dt = A*x  (u = 0)
[t, x] = ode45(@(t,x) A*x, tspan, x0);

%% 3. Plotting
figure('Name','Open-Loop Instability of Maglev System','NumberTitle','off');

subplot(3,1,1);
plot(t, x(:,1)*1000, 'b', 'LineWidth', 1.5);
grid on;
ylabel('Position error (mm)');
title('Open-Loop Response – Magnetic Levitation System (Unstable)');
legend('Position deviation','Location','northwest');

subplot(3,1,2);
plot(t, x(:,2), 'r', 'LineWidth', 1.5);
grid on;
ylabel('Velocity (m/s)');
legend('Velocity','Location','northwest');

subplot(3,1,3);
plot(t, x(:,3), 'g', 'LineWidth', 1.5);
grid on;
xlabel('Time (s)');
ylabel('Current error (A)');
legend('Current deviation','Location','northwest');

% Save figure
saveas(gcf, '../figures/open_loop_instability.png');
disp('Plot saved to figures/open_loop_instability.png');
