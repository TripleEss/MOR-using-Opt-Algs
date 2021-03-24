function Nelder_mead_Approx
clf
clear 
clc
warning('off') %#ok<WNOFF>
% This is Nelder-Meade method to find the minimum
sysorg=tf([1, 46.8, 957.6, 11144, 80511.9, 369601.6, 1060774.5, 1809006.4, 1669955.4, 638266],[1, 36.9, 620.8, 6257.9, 41888, 195879.7, 658023.2, 1611073.5, 2857356,3425885.4, 2110138.4 ]);
t=linspace(0,20,400);
resporg=step(sysorg,t);

tic
options = optimset('TolFun',1e-4,'TolX',1e-4);
[c fval] = fminsearch(@datafit,[3 3 3 4],options) % optimization

respfit = step(tf([c(1), c(2)],[1, c(3), c(4)]),t);
err = abs(norm(respfit-resporg));
toc
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
subplot(121)
sysred = tf([c(1), c(2)],[1, c(3), c(4)]);
bode(sysorg)
legend('Original','Reduced')
hold on
bode(sysred)
grid on
legend('Original','Reduced')

subplot(122)
plot(resporg,'b-');hold on; plot(respfit,'ro'); grid on;
legend('Original','Reduced')
function e2 = datafit(c)
respred=step(tf([c(1), c(2)],[1, c(3), c(4)]),t);
e2= sum((respred-resporg).^2)/length(resporg); 
end
disp(err)
end