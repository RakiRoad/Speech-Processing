fs = 16000
x = audioread('C:\Users\Rocky\Documents\GitHub\Speech Processing\Lab 1\SA1.wav', 'double');
%audioinfo('C:\TIMIT\TRAIN\DR1\FCJF0\SA1.wav');

%==============================================================
%finds the total number of samples
num_el = numel(x) 
n = 147;
%fills the x vector with zeros until it is divisible by 2
x(numel(x) + (320 - mod(numel(x), 320))) = 0;

%reshapes the vector so each column is 320 samples long
y = reshape(x,[320,147]); 

%multiply each column by a hamming window
y = y.*repmat(hamming(320),1,147); 

%needed so that each plot call doesn't overwrite previous iteration
hold on 
for i = 1:147
%     plot(y(:,i))%plots each column
%     figure %makes it so that each plot creates a new figure
end
hold off; 

%calculates the total power of each window and stores it in the array
%'total_sample_powers'
total_sample_powers = zeros(147,1)
hold on 
for i = 1:147
    F = fft(y(:,i));
    pow = F.*conj(F);
    total_sample_powers(i,1) = sum(pow)
end
hold off