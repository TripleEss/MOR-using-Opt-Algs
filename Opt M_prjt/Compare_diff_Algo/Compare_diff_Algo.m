function Compare_diff_Algo
clear
clc
clf
G=tf([1, 46.8, 957.6, 11144, 80511.9, 369601.6, 1060774.5, 1809006.4, 1669955.4, 638266],[1, 36.9, 620.8, 6257.9, 41888, 195879.7, 658023.2, 1611073.5, 2857356,3425885.4, 2110138.4 ]);

%%%%%%%%%% different Models %%%%%%%%%%%%%%%%

GrGA = GA_second_order(G);
GrNM = Nelde_Mead_second_order(G);
GrRW = Routh_Approximation_second_order(G);
GrPade = Pade_Approximation_second_order(G);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%555

%%%%%%%%%%%%%%%%%%%%%%Plot comparision%%%%%%%%%%%%%%%%%%%
figure(1)
bode(G); hold on; bode(GrGA); hold on; bode(GrNM);hold on; bode(GrRW); hold on; bode(GrPade) 
legend('Original', 'Genetic Alg', 'Nelder-Mead', 'Routh', 'Pade')
title('Comparison of Bode plot different Algorithms for second order approximation')
grid on

%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Step-responses%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
figure(2)
t=linspace(0,20,400);
sysG = step(G,t);
sysGrGA = step(GrGA,t);
sysGrNM = step(GrNM,t);
sysGrRW = step(GrRW,t);
plot(sysG); hold on; plot(sysGrGA); hold on; plot(sysGrNM);hold on; plot(sysGrRW); grid on 
legend('Original', 'Genetic Alg', 'Nelder-Mead', 'Routh')
title('Comparison of Step_responses of different Algorithms for second order approximation')
end