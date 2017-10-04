fs = 16000
x = audioread('C:\Users\Rocky\Documents\GitHub\Speech Processing\Lab 1\SA1.wav', 'double');
audioinfo('C:\Users\Rocky\Documents\GitHub\Speech Processing\Lab 1\SA1.wav')

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
total_sample_powers = zeros(147,1);
total_fft = zeros(320,147);
hold on 
for i = 1:147
    F = fft(y(:,i));
    total_fft(:,i) = fft(y(:,i));
    pow = F.*conj(F);
    total_sample_powers(i,1) = sum(pow);
end
hold off


tempval = zeros(147,1);
for i = 1:147
    tempval(i:1) = i;
end

plot(y(:,25))
title('ham 25')
figure
plot(x)
figure

plot(total_sample_powers,'-o')
title('power all')



%bar(total_fft(:,1))


meme = fft(y(:,25));


%========
% sze = 320;
% abs_area = abs(meme);
% y_fft = abs_area(1:160);
% FF = fs*(0:160-1)/320;
% figure
% plot(FF, y_fft, '-x')
% title('fft 1')
% xlabel('freq and hz');
% ylabel('Amplitude');
% figure
%=====

Thresh = zeros(147:1)
for j = 1:147
    count = 0;
    for i = 1:320
        if i > 1
            if y(i-1,j)*y(i,j)<0 
                count = count + 1;
            end
        end
    end
    Thresh (j,1) = count;
end

plot(Thresh, '-o')
title('Thresh')

%Code to figure out vowel and stuff
voice1 = zeros(160:147);
for i = 1:147
    ham1 = fft(y(:,i));
    sze = 320;
    abs_area = abs(ham1);
    y_fft = abs_area(1:160);
    FF = fs*(0:160-1)/320;
    
    [val, index] = max(y_fft);
    idx_max = FF(1:index);
    
    for j = 1:160
        if idx_max > 840
            voice1(j:i) = 1
        elseif idx_max >= 840 & idx_max <1380
            voice (j:i) = 2
        elseif idx_max >= 1380 & idx_max <1920
            voice (j:i) = 3
        elseif idx_max >= 1920 & idx_max <2460
            voice (j:i) = 4
        elseif idx_max >= 2460
            voice (j:i) = 5
        end
    end
end
            