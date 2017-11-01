N=10; %N=10
w=0:0.01*pi:2*pi; %successive frequency point
%separation is 0.01pi
dtft=exp(-j.*w.*(N)); %define DTFT function
subplot(2,1,1);
Mag=abs(dtft); %compute magnitude
plot(w./pi,Mag); %plot magnitude
subplot(2,1,2);
Pha=angle(dtft); %compute phase
plot(w./pi,Pha); %plot phase

syms z
F = (11-2*z^(-1)-.96*z^(-2))/(1-.2*z^(-1)-.48*z^(-2));
iztrans(F)