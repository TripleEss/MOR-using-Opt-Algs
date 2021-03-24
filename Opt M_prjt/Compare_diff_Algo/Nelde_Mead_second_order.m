function sysred_2 = Nelde_Mead_second_order(G)
clf 
clc
warning('off') %#ok<WNOFF>
% uses Nelder-Meade method to find the minimum
t=linspace(0,20,400);
resporg=step(G,t);
options = optimset('TolFun',1e-4,'TolX',1e-4);
[c fval] = fminsearch(@datafit,[3 3 3 4],options); % optimization
sysred_2 = tf([c(1), c(2)],[1, c(3), c(4)]);

function e2 = datafit(c)
respred=step(tf([c(1), c(2)],[1, c(3), c(4)]),t);
e2= sum((respred-resporg).^2)/length(resporg); 
end

end


