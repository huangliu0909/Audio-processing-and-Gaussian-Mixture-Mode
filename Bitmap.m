% x = imread('barbara.bmp')
imfinfo barbara.bmp
img=imread('barbara.bmp');
%img=double(img);
f=fft2(img);        %����Ҷ�任
f=fftshift(f);      %ʹͼ��Գ�
margin=log(abs(f));      %ͼ������ף���log������ʾ
phase=log(angle(f)*180/pi);     %ͼ����λ��
l=log(f);           
subplot(2,2,1);
imshow(img);title('ͼ��');
subplot(2,2,2);
imshow(margin,[]);title('ͼ�������');
subplot(2,2,3);
imshow(phase,[]);title('ͼ����λ��');