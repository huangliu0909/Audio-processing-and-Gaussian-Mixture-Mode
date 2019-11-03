close all;
clear all;
                                                                            
fileName = 'visiontraffic.avi';  
obj = VideoReader(fileName); 
numFrames = obj.NumberOfFrames;                % ��ȡ��Ƶ��֡��  
for i = 1 : numFrames      
    frame = read(obj,i);
    % imshow(frame);
    imwrite(frame,strcat(num2str(1),'jpg'),'jpg');
end

source=dir('*.jpg');
% source(1).name

%��ȡ��һ֡��������֡
fr=imread(source(1).name);
% fr = imread(strcat(num2str(1),'jpg'));
fr_bw = rgb2gray(fr);     % convert background to greyscale
% imagesc(fr_bw)
fr_size = size(fr);             
width = fr_size(2);
height = fr_size(1);
fg = zeros(height, width);
bg_bw = zeros(height, width);

%��ʼ������
C = 3;                                  % ��˹ģ�͵ĸ���
M = 3;                                  % ����Ԫ�صĸ���
D = 2.5;                                % ��ֵ
alpha = 0.01;                           %ѧϰ��
thresh = 0.25;                          % foreground threshold 
sd_init = 1;                            % ��ʼ����
w = zeros(height,width,C);              % ��ʼȨ�ؾ���
mean = zeros(height,width,C);           % ��˹�ľ�ֵ
sd = zeros(height,width,C);             % ��˹�ķ���
u_diff = zeros(height,width,C);         % �Ծ�ֵ��ƫ��̶�
p = alpha/(1/C);                        % ���ڸ��¾�ֵ�ͷ���
rank = zeros(1,C);                      % �����ĸ���˹��ռ��
%��ʼ����ֵ�Ͳ���
pixel_depth = 8;                        % 8-bit resolution
pixel_range = 2^pixel_depth -1;         % pixel range (# of possible values)
for i=1:height
    for j=1:width
        for k=1:C
            
            mean(i,j,k) = rand*pixel_range;     % means random (0-255)
            w(i,j,k) = 1/C;                     % weights uniformly dist
            sd(i,j,k) = sd_init;                % initialize to sd_init
            
        end
    end
end

for n = 8:(length(source)-2)        
% n = 140

    fr = imread(source(n).name);       % read in frame
    fr_bw = rgb2gray(fr);       % convert frame to grayscale
    
    % calculate difference of pixel values from mean
    for m=1:C
        u_diff(:,:,m) = abs(double(fr_bw) - double(mean(:,:,m)));
    end
    sum_x=0;
    sum_y=0;
    num=0; 
    % update gaussian components for each pixel
    for i=1:height                       
        for j=1:width                     
                                                
            match = 0;            
                                          
            for k=1:C                       
                if (abs(u_diff(i,j,k)) <= D*sd(i,j,k))       % pixel matches component
                    match = 1;                          % variable to signal component match
                    % update weights, mean, sd, p
                    w(i,j,k) = (1-alpha)*w(i,j,k) + alpha;
                    p = alpha/w(i,j,k);                  
                    mean(i,j,k) = (1-p)*mean(i,j,k) + p*double(fr_bw(i,j));
                    sd(i,j,k) =   sqrt((1-p)*(sd(i,j,k)^2) + p*((double(fr_bw(i,j)) - mean(i,j,k)))^2);
                else                                    % pixel doesn't match component
                    w(i,j,k) = (1-alpha)*w(i,j,k);      % weight slighly decreases
                    
                end
            end
            
                  
            bg_bw(i,j)=0;
            for k=1:C
                bg_bw(i,j) = bg_bw(i,j)+ mean(i,j,k)*w(i,j,k);
            end
            
            % if no components match, create new component
            if (match == 0)
                [min_w, min_w_index] = min(w(i,j,:));  
                mean(i,j,min_w_index) = double(fr_bw(i,j));
                sd(i,j,min_w_index) = sd_init;
            end
            rank = w(i,j,:)./sd(i,j,:);             % calculate component rank
            rank_ind = [1:1:C];
            % calculate foreground
            fg(i,j) = 0;
            while ((match == 0)&&(k<=M))
 
                    if (abs(u_diff(i,j,rank_ind(k))) <= D*sd(i,j,rank_ind(k)))
                        fg(i,j) = 0; %black = 0
           
                    else
                        fg(i,j) = fr_bw(i,j);                  
                        sum_x=sum_x+j;        
                        sum_y=sum_y+i;
                        num=num+1;
                    end   
                k = k+1;                
            end
            
        end
    end
    
   
    if n==8||n==9||n==10
        route_x=[round(sum_x/num),round(sum_x/num)];
        route_y=[round(sum_y/num),round(sum_y/num)];
    else


        next_x=round(sum_x/num);
        next_y=round(sum_y/num);
        route_x=[route_x,next_x];
        route_y=[route_y,next_y];
    end
    num=0; 
end
      
figure(1);
subplot(3,1,1);    
imshow(fr);
title('ԭʼͼ��');
subplot(3,1,2);    
imshow(uint8(bg_bw));
title('����ͼ��');
subplot(3,1,3);  
imshow(uint8(fg)); hold on;
title('ǰ��ͼ��');
plot(route_x,route_y,'LineWidth',1,'Color','r');

% writerObj=VideoWriter('mixture_of_gaussians_output');  %// ����һ����Ƶ�ļ������涯��
% open(writerObj);  
% writeVideo(writerObj,frame);
% VideoWriter(Mov1,'mixture_of_gaussians_output','fps',30);           % save movie as avi 
% VideoWriter(Mov2,'mixture_of_gaussians_background','fps',30);           % save movie as avi 