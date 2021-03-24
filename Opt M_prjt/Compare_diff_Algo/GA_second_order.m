function sysredGA = GA_second_order(G)
clf
tic
t=linspace(0,20,400);
resporg=step(G,t);
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
    respredGA=step(tf([A(j), B(j)],[1, C(j), D(j)]),t);
 %minl = min(length(respred),length(resporg));
 %Fitness function with loss function
%E(j)= sum((respred(1:minl)-resporg(1:minl)).^2);
E(j)= sum((respredGA-resporg).^2)/length(resporg);
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
end
toc
sysredGA=tf([A(1), B(1)],[1, C(1), D(1)]);
end