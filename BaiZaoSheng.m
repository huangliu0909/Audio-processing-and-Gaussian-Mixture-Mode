clear all; close all;
L=1000;  %仿真长度
n = 100;
y = [];% 100个白噪声的集合
c = [];% 第一个与其它的相关性集合
for i = 1:100
    x=randn(L,1);  %产生均值为0，方差为1的高斯白噪声序列
    y = [y,x];
    mm = corrcoef(y(:,1),x);
    c = [c,mm(1,2)];
end
plot(c);
xlabel('第一个与第k个序列');ylabel('相关度');title('白噪声序列');

