function Genetic_Algorithm
clear
clc
clf
tic
sysorg=tf([1, 46.8, 957.6, 11144, 80511.9, 369601.6, 1060774.5, 1809006.4, 1669955.4, 638266],[1, 36.9, 620.8, 6257.9, 41888, 195879.7, 658023.2, 1611073.5, 2857356,3425885.4, 2110138.4 ]);
t=linspace(0,20,400);
resporg=step(sysorg,t);
m = 100;  % number of generations
n = 50;  % number of trials
n2= 10;  % number of trials to be kept , keep n2=n/5
A = 3+randn(n,1); 
B = 3+randn(n,1); 
C = 3+randn(n,1); 
D = 4+rand(n,1);
for jgen=1:m
    clf
for j=1:n % evaluate objective function
    respred=step(tf([A(j), B(j)],[1, C(j), D(j)]),t);
 %minl = min(length(respred),length(resporg));
 %Fitness function with loss function
%E(j)= sum((respred(1:minl)-resporg(1:minl)).^2);
E(j)= sum((respred-resporg).^2)/length(resporg);
end 
[Es,Ej] = sort(E); % sort from small to large
Ak1=A(Ej(1:n2)); % best 10 solutions
Bk1=B(Ej(1:n2));
Ck1=C(Ej(1:n2));
Dk1=D(Ej(1:n2));

Ak2=Ak1+randn(n2,1)/jgen; % 10 new mutations
Bk2=Bk1+randn(n2,1)/jgen;
Ck2=Ck1+randn(n2,1)/jgen;
Dk2=Dk1+randn(n2,1)/jgen;
Ak3=Ak1+randn(n2,1)/jgen; % 10 new mutations
Bk3=Bk1+randn(n2,1)/jgen;
Ck3=Ck1+randn(n2,1)/jgen;
Dk3=Dk1+randn(n2,1)/jgen;
Ak4=Ak1+randn(n2,1)/jgen; % 10 new mutations
Bk4=Bk1+randn(n2,1)/jgen;
Ck4=Ck1+randn(n2,1)/jgen;
Dk4=Dk1+randn(n2,1)/jgen;
Ak5=Ak1+randn(n2,1)/jgen; % 10 new mutations
Bk5=Bk1+randn(n2,1)/jgen;
Ck5=Ck1+randn(n2,1)/jgen;
Dk5=Dk1+randn(n2,1)/jgen;
A=[Ak1; Ak2; Ak3; Ak4; Ak5]; % group new 50
B=[Bk1; Bk2; Bk3; Bk4; Bk5];
C=[Ck1; Ck2; Ck3; Ck4; Ck5];
D=[Dk1; Dk2; Dk3; Dk4; Dk5];
respfit = step(tf([A(1), B(1)],[1, C(1), D(1)]),t);
figure(1);
subplot(2,1,1),  plot(resporg,'bo');hold on; plot(respfit,'r-'); grid on;  
subplot(2,1,2), semilogy(abs([A,B,C,D]),'o')
legend('A','B','C','D')
drawnow
disp(['A=',num2str(A(1)),', B=',num2str(B(1)),', C=',num2str(C(1)),',D=',num2str(D(1))])
end
toc

figure(2)
sysred=tf([A(1), B(1)],[1, C(1), D(1)]);
respfit = step(sysred,t);
err = abs(norm(respfit-resporg));
bode(sysorg);legend('Original','Reduced'); hold on
bode(sysred)
grid on
legend('Original','Reduced')
disp(err)
end