% x = imread('barbara.bmp')
imfinfo barbara.bmp
img=imread('barbara.bmp');
%img=double(img);
f=fft2(img);        %傅里叶变换
f=fftshift(f);      %使图像对称
margin=log(abs(f));      %图像幅度谱，加log便于显示
phase=log(angle(f)*180/pi);     %图像相位谱
l=log(f);           
subplot(2,2,1);
imshow(img);title('图像');
subplot(2,2,2);
imshow(margin,[]);title('图像幅度谱');
subplot(2,2,3);
imshow(phase,[]);title('图像相位谱');