%=================================================================
fs= 16000;
f0= 150;
N1=.5;
N2=.5;

F1 = 540;
F2 = 1840;
F3 = 2480;

%=================================================================
w1 = 2*pi*F1/fs;
raise = -pi*250/fs;
r1 = exp(raise);

a11 = -2*r1*cos(w1);
a2 = r1^2;

w2 = 2*pi*F2/fs;
a12 = -2*r1*cos(w2);


w3 = 2*pi*F3/fs;
a13 = -2*r1*cos(w3);

%=================================================================
T=1/f0;     %period in seconds
pulselength=floor(T*fs);    %length of one period of pulse
%select N1 and N2 for duty cycle
N2=floor(pulselength*N2);
N1=floor(N1*N2);
gn=zeros(1,N2);
%calculate pulse samples
for n=1:N1-1
    gn(n)=0.5*(1-cos(pi*(n-1)/N1));
end
for n=N1:N2
    gn(n)=cos(pi*(n-N1)/(N2-N1)/2);
end
gn=[gn zeros(1,(pulselength-N2))];
plot(gn);

%=================================================================
yn = [gn gn gn];

%3 filters
sos3 = [1 0 0 1 -a11 a2; 1 0 0 1 -a12 a2; 1 0 0 1 -a13 a2];
[b3, a3] = sos2tf(sos3);

% %2 filters
% sos2 = [1 0 0 1 -a11 a2; 1 0 0 1 -a12 a2];
% [b2, a2] = sos2tf(sos2);
% 
% %1 filter
% sos3 = [1 0 0, 1 -a11 a2];
% [b1, a1] = sos2tf(sos3);
%=================================================================

result = filter(b3,a3,yn);
plot(result)
title('Fully Filtered Signal');
figure;

plot(yn)
title('Glottal Pulse Input');

sound(result)