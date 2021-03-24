function compare_diff_orders
clf
clear 
clc
warning('off') %#ok<WNOFF>
% uses Nelder-Mead method to find the minimum
sysorg=tf([1, 46.8, 957.6, 11144, 80511.9, 369601.6, 1060774.5, 1809006.4, 1669955.4, 638266],[1, 36.9, 620.8, 6257.9, 41888, 195879.7, 658023.2, 1611073.5, 2857356,3425885.4, 2110138.4 ]);
t=linspace(0,20,400);
resporg=step(sysorg,t);

options = optimset('TolFun',1e-4,'TolX',1e-4);

%%%%%%%%%%%%%%%%%%%%%%%%%%% second order %%%%%%%%%%%%%%%%%%%%%%%%%%
tic

[c fval2] = fminsearch(@datafit_2ord,[3 3 3 4],options) % optimization
sysred2 = tf([c(1), c(2)],[1, c(3), c(4)]);
respfit_2ord = step(tf([c(1), c(2)],[1, c(3), c(4)]),t);
toc

%%%%%%%%%%%%%%%%%%%%%% 3rd order %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
tic

[d fval3] = fminsearch(@datafit_3ord,[3 3 3 4,7,5],options) % optimization
sysred3 = tf([d(1), d(2), d(3)],[1, d(4), d(5), d(6)]);
respfit_3ord = step(tf([d(1), d(2), d(3)],[1, d(4), d(5), d(6)]),t);
toc

tic
%%%%%%%%%%%%% fourth order %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[e fval4] = fminsearch(@datafit_4ord,[3 3 3 4,3,5,7,8],options) % optimization
respfit_4ord = step(tf([e(1), e(2), e(3), e(4)],[1, e(5), e(6), e(7), e(8)]),t);
sysred4 = tf([e(1), e(2), e(3), e(4)],[1, e(5), e(6), e(7), e(8)]);
toc
%%%%%%%%%%%%%%%%%%%  PLOTS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%
figure(1)
bode(sysorg); hold on
bode(sysred2); hold on
bode(sysred3); hold on
bode(sysred4); 
grid on
legend('Original','Second ord approx','Third ord approx','Fourth ord approx')

figure(2)
plot(resporg,'r'); hold on; plot(respfit_2ord);hold on; plot(respfit_3ord); hold on; plot(respfit_4ord); grid on
legend('Original','Second ord approx','Third ord approx','Fourth ord approx')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% function definitions %%%%%%%
function e2 = datafit_2ord(c)
respred2=step(tf([c(1), c(2)],[1, c(3), c(4)]),t);
e2= sum((respred2-resporg).^2)/length(resporg); 
end

function e3 = datafit_3ord(d)
respred3=step(tf([d(1), d(2), d(3)],[1, d(4), d(5), d(6)]),t);
e3= sum((respred3-resporg).^2)/length(resporg); 
end
function e4 = datafit_4ord(e)
respred4=step(tf([e(1), e(2), e(3), e(4)],[1, e(5), e(6), e(7), e(8)]),t);
e4= sum((respred4-resporg).^2)/length(resporg);
end
end

