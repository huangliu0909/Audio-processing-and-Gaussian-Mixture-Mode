# Audio-processing-and-Gaussian-Mixture-Mode
Random Computing Project_05

1.编程阅读一个wav音频文件和一幅灰度bitmap图像 ，然后对音频文件和灰度图像分别做离散傅立叶变换，画出其幅度和相位信息   
2.尝试画出给定低通滤波器的幅度和相位  
3.高斯白噪声序列相关性：取第一个白噪声序列，计算它与自己和其它所有序列的相关性，可以看出只有与自己的相关性为1，与其它的相关性都接近0  
4.给定一段摄像头固定的小视频  
  a.根据初始的一些视频帧，对其中的像素点进行混合高斯建模  
  b.然后根据模型，对新出现的视频帧进行模型更新，并对像素点进行判断，是前景像素点还是背景像素点
