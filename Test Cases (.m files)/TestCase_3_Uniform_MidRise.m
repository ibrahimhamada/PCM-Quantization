clc;
clear;
%Parameters
fm_mr = 10;  %Message Frequency
mp_mr = 5;   %Peak
L_mr = 16;    %No. of levels
t_mr = 0:0.001:0.1;    %Time Vector
m_mr = 5*cos(2*pi*fm_mr.*t_mr);  %Message Signal

%Mid-Rise Quantization
fs_mr = 15;     %Sampling Frequency 
ts_mr = 1/fs_mr;   %Sampling Time
n_samples_mr = t_mr(end)/ ts_mr;   %No. of Samples
ts_vec_mr = ts_mr.*(0:1:n_samples_mr);   %Sampling Time Vector
delta_mr = (2*mp_mr)/L_mr;  %Delta Value 
l_values_mr= -mp_mr + delta_mr/2 : delta_mr : mp_mr-delta_mr / 2 ;  %Levels' Values
shif_m_mr = (m_mr- (-mp_mr) ) / delta_mr + 1/2 ;    
m_l_index_mr=round(shif_m_mr);
m_l_index_mr=min ( m_l_index_mr , L_mr);

c=1;
for i = 1:length(ts_vec_mr)
   for j=1:length(t_mr)
      if(round(t_mr(j),3) == round(ts_vec_mr(i),3))
         index_mr(c) = j;
         c = c+1;
         break;
      end
   end
end

for i = 1:length(index_mr)
    l_index_mr(i) = m_l_index_mr(index_mr(i));
end

for i = 1:length(l_index_mr)
    quantized_mr(i) = l_values_mr(l_index_mr(i));
end

quantized_mr1 =  quantized_mr;
ts_vec_mr1 = ts_vec_mr;
if(ts_vec_mr(end) ~= t_mr(end))
   ts_vec_mr1(end+1) = t_mr(end); 
   quantized_mr1(end+1) = quantized_mr1(end);
end

figure('Name','Test Case (3) Mid-Rise Uniform PCM Quantization');
plot(t_mr, m_mr,'b'); xlabel('Time(sec)'); ylabel('Amplitude(V)'); title('PCM Quantization - Midrise Uniform'); hold on;
stem(t_mr(index_mr),m_mr(index_mr),'g','LineWidth',1.2);
stairs(ts_vec_mr1, quantized_mr1,'r','LineWidth',1.2); grid on;
legend('Input Signal','Sampled Input Signal','Quantized Signal');

%MSE Calculations
for(i = 1:length(index_mr))
   d(i) = m_mr(index_mr(i)); 
end

er = d - quantized_mr;
er = er.^2;
MSE = mean(er)