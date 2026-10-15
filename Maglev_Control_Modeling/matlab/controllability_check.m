% Magnetic Levitation System - Controllability Analysis
% Author: Muhammad Ibrahim Zubair
% Description: Computes AB, A^2B and checks full-state controllability

clear; clc;

% Linearized system matrices (from Jacobian linearization)
A = [  0      1       0    ;
     3924     0   -28.03  ;
       0      0     -40   ];

B = [ 0 ;
      0 ;
     20 ];

% Controllability matrix C = [B  AB  A^2B]
AB  = A * B;
A2B = A * AB;

C = [B  AB  A2B];

disp('Controllability Matrix C = [B  AB  A^2B]:');
disp(C);

% Rank and determinant check
rank_C = rank(C);
det_C  = det(C);

fprintf('\nRank of C = %d\n', rank_C);
fprintf('Determinant of C = %.4e\n', det_C);

if rank_C == size(A,1)
    disp('Result: System is FULLY CONTROLLABLE');
else
    disp('Result: System is NOT fully controllable');
end
