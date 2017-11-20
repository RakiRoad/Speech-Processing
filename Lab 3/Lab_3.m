%Code for Lab 3
%==============================================================
info = audioinfo('SA1.wav');
read = audioread('SA1.wav');

%==============================================================
%Hamming Windows Section of the Code

num_el = numel(read); %finds the total number of samples
n = 147;

%fills the x vector with zeros until it is divisible by 2
read(num_el + (320 - mod(num_el, 320))) = 0;

%reshapes the vector so each column is 320 samples long
y = reshape(read,[320,147]); 

%multiply each column by a hamming window
y = y.*repmat(hamming(320),1,147); 

% hold on 
% for i = 1:10
% %     plot(y(:,i))%plots each column
% %     title(i)
% %     figure %makes it so that each plot creates a new figure
% end
% hold off;

%==============================================================
%Don't know if this is even needed at all

read_fft = fft(read);
read_abs_fft = abs(read_fft);

Len = 47040; %length of the sound file
Fs = 16000; %sampling frequency
P2 = abs(read_fft/Len);
P1 = P2(1:Len/2+1); %computes the single sided amplitude spectrum
P1(2:end-1) = 2*P1(2:end-1);
f = Fs*(0:(Len/2))/Len;
plot(f,P1)
title('Single-Sided Amplitude Spectrum of X(t)')
xlabel('f (Hz)')
ylabel('|P1(f)|')

%==============================================================
%Short time zero crossing