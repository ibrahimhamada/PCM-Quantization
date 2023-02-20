clc;
clear;
%Parameters
fm = 10;  %Message Frequency
mp = 5;   %Peak
L = 8;    %No. of levels
t = 0:0.001:0.1;    %Time Vector
m = 5*cos(2*pi*fm.*t);  %Message Signal

%Mid-Tread Quantization
fs = 40;     %Sampling Frequency 
delta = (2*mp)/L;  %Delta Value 
ts = 1/fs;   %Sampling Time
n_samples = t(end)/ ts;   %No. of Samples
ts_vec = ts.*(0:1:n_samples);   %Sampling Time Vector
l_values= -mp + delta : delta : mp;  %Levels' Values
shif_m = (m- (-mp) ) / delta;   
m_l_index=round(shif_m); 


for i= 1:length(m_l_index)
    if(m_l_index(i)==0)
        m_l_index(i) =1;
    end
end

c=1;
for i = 1:length(ts_vec)
   for j=1:length(t)
      if(round(t(j),3) == round(ts_vec(i),3))
         index(c) = j;
         c = c+1;
         break;
      end
   end
end

for i = 1:length(index)
    l_index(i) = m_l_index(index(i));
end

for i = 1:length(l_index)
    quantized(i) = l_values(l_index(i));
end

   quantized1 =  quantized;
   ts_vec1 = ts_vec;
   
if(ts_vec(end) ~= t(end)) 
   ts_vec1(end+1) = t(end); 
   quantized1(end+1) = quantized1(end);
end

figure('Name','Test Case (1) Mid-Tread Uniform PCM Quantization');
plot(t, m,'b'); xlabel('Time(sec)'); ylabel('Amplitude(V)'); title('PCM Quantization - MidTread Uniform'); hold on;
stem(t(index),m(index),'g','LineWidth',1.2);
stairs(ts_vec1, quantized1,'r','LineWidth',1.5); grid on;
legend('Input Signal','Sampled Input Signal','Quantized Signal');

%MSE Calculations
for(i = 1:length(index))
   d(i) = m(index(i)); 
end

er = d - quantized;
er = er.^2;
MSE = mean(er)