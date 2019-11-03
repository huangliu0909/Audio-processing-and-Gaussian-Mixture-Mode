[y,Fs]=audioread('D:\hhhhhiiiiiiittttttt\大三上\随机计算\实验\11.23_声音图像etc\crane_bump.wav'); 
% y为读取片段，Fs为采样率
N = length(y);
t = (0:(N -1))/Fs;          %时间点
mag = abs(fft(y),N); %Magnitude
mag = mag(1:N/2); %幅度
f = Fs*(0:N/2-1)/N;   %频率
subplot(2,1,1);
plot(t, y);
xlabel('时间');ylabel('幅度');grid on;
subplot(2,1,2);
plot(f, mag);xlim([0 1000]);
xlabel('频率');ylabel('幅度');grid on;
