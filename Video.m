[y,Fs]=audioread('D:\hhhhhiiiiiiittttttt\������\�������\ʵ��\11.23_����ͼ��etc\crane_bump.wav'); 
% yΪ��ȡƬ�Σ�FsΪ������
N = length(y);
t = (0:(N -1))/Fs;          %ʱ���
mag = abs(fft(y),N); %Magnitude
mag = mag(1:N/2); %����
f = Fs*(0:N/2-1)/N;   %Ƶ��
subplot(2,1,1);
plot(t, y);
xlabel('ʱ��');ylabel('����');grid on;
subplot(2,1,2);
plot(f, mag);xlim([0 1000]);
xlabel('Ƶ��');ylabel('����');grid on;
