clc;
clear;
fm = 10;
mp = 5;
L = 32;
u=100;
t = 0:0.001:1/fm;
m = 5*cos(2*pi*fm.*t);
m1=m+mp; 
m_h=m1/(2*mp);
y= log(1+u*m_h)/log(1+u); %for non_uniform quantization
mp=1;                                            
delta = (mp)/L;
l_values=  delta : delta : mp;  
shif_m = (y ) / delta;   
m_l_index=round(shif_m);
                    
for i= 1:length(m_l_index)
    if(m_l_index(i)==0)
       m_l_index(i) =1;
    end
end
fs = 20;
ts = 1/fs;
n_samples = t(end)/ ts;
ts_vec = ts.*(0:1:n_samples);
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
    quantized(i)= l_values(l_index(i));
end

figure('Name','Test Case (4) Non-Uniform PCM Quantization');
plot(t, y,'b'); xlabel('Time(sec)'); ylabel('Amplitude(V)'); title('PCM Quantization - Non-Uniform'); hold on;
stem(t(index),y(index),'g','LineWidth',1.2);
stairs(ts_vec, quantized,'r','LineWidth',1.2); grid on;

legend('Input Signal (Normalized and Compressed)','Sampled Input Signal','Quantized Signal');
 
for i = 1:length(quantized)
   er(i) = y(i)-quantized(i);
   er(i) = er(i)^2;
end

MSE = mean(er)
               
               