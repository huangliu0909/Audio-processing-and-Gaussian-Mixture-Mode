% 通过差分方程求出系统的频率响应
% 向量化
clear all;
x = [0.0181, 0.0543, 0.0543, 0.0181];% 分子
y = [1.00, -1.76, 1.1829, -0.2781];% 分母
m = 0:length(x)-1;
l = 0:length(y)-1;
N = 1000;
k = 0:N;% 等分频率
w = pi*k/N;
num = x*exp(-j*m'*w);
den = y*exp(-j*l'*w);
H = num./den;
subplot(2,1,1);
plot(w/pi,abs(H),'LineWidth',2);
xlabel('Frenquency in units of Pi');ylabel('Magnitude Response');grid on;
subplot(2,1,2);
plot(w/pi,angle(H),'LineWidth',2);
xlabel('Frenquency in units of Pi');ylabel('Phase Response');grid on;
