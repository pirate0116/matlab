%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                         %
% gauss filter for 3D ear shape(mainly to the Z buffer)                   %
%                                                                         %
% code by Zhang feng @ USTB (2010-summer)                                 %
%                                                                         %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% function GaussFilter(Z)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                              下载数据                                    %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
addpath(addpath(genpath('0503')));%添加文件夹路径by lifs
%addpath(fulfile(pwd, 'lib'));
addpath(fulfile(pwd, '程序'));
clc
clear
tic
ear = dir('L:\400\2D_ear\');
num_ear = size(ear,1)

for index=3:num_ear
    % img = imread('L:\Program Files\final_work\2D_data\05066d001ear.jpg');
    img = imread(['L:\400\2D_ear\' ear(index).name(1:9) '_ear.jpg']);
    [h,w,rgb] = size(img);
    % P3D = load('L:\Program Files\final_work\3D_data\05066d001ear_filled.txt');
    P3D = load(['L:\400\3D_ear_holed\' ear(index).name(1:9) '_ear_holed.txt']);
    Z = P3D(:,3);
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %去尖峰粗操作
    Zn = size(Z,1);
    for cc = 1:Zn
       if abs(Z(cc))>=5000
           Z(cc)=0;
       end
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % save('ZO','Z');
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %                              高斯平滑                                    %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    Z = reshape(Z,h,w);
    template = fspecial('gaussian',7,2.5);
    Z2 = imfilter(Z, template,'replicate');
    Z2 = reshape(Z2,h*w,1);
    px = P3D(:,1);
    py = P3D(:,2);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %                              保存数据                                    %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % ear = dir('L:\Program Files\final_work\2D_data\');
    fid = fopen(['L:\400\3D_ear_smoothed\' ear(index).name(1:9) 'ear_smoothed.txt'],'w');%写入文件路径
    for i=1:size(Z2,1)
        fprintf(fid,'%g\t',px(i));
        fprintf(fid,'%g\t',py(i));
        fprintf(fid,'%g\n',Z2(i));
    end
    fclose(fid);
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %                              图像显示                                    %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     figure(1);
%     % save('Z2','Z2')
%     
%     %刷去最右边一列
%     % Z2(w*h-h+1:w*h)=[];
%     % px(w*h-h+1:w*h)=[];
%     % py(w*h-h+1:w*h)=[];
%     %刷去最下边一行
%     % for j=(w-1):-1:1
%     %     Z2(h:h:(w-1)*h)=[];
%     %     px(h:h:(w-1)*h)=[];
%     %     py(h:h:(w-1)*h)=[];
%     % % end
%     %刷去最上边一行
%     %     Z2(1:(h-1):(w-2)*(h-1))=[];
%     %     px(1:(h-1):(w-2)*(h-1))=[];
%     %     py(1:(h-1):(w-2)*(h-1))=[];
%     
%     %   plot3(px,py,Z2,'r.')
%     
%     subplot(1,2,1)
%     [X,Y] = meshgrid(min(px):max(px),min(py):max(py));
%     Z=griddata(px,py,Z2,X,Y);
%     surf(X,Y,Z);
%     grid off
%     % tri=delaunay(P3D(:,1),P3D(:,2));
%     % trimesh(tri,P3D(:,1),P3D(:,2),Z2(:,3))
%     
%     shading interp
%     colormap(jet(256))
%     camlight left
%     lighting phong
%     set(gcf,'color','w')
%     
%     % 为了对比平滑的效果，加入了显示原始数据的程序
%     subplot(1,2,2)
%     P3D_v = load(['L:\400\3D_vear\' ear(index).name(1:9) '_earv.txt']);
%     %     plot3(P3D_v(:,1),P3D_v(:,2),P3D_v(:,3))
%     
%     [Xx,Yy] = meshgrid(min(P3D_v(:,1)):max(P3D_v(:,1)),min(P3D_v(:,2)):max(P3D_v(:,2)));
%     Z=griddata(P3D_v(:,1),P3D_v(:,2),P3D_v(:,3),Xx,Yy);
%     surf(Xx,Yy,Z)
%     
%     shading interp
%     colormap(jet(256))
%     camlight left
%     lighting phong
%     set(gcf,'color','w')
%     grid off
    
    display(['第' num2str(index-2) '个样本的高斯滤波完毕！'])
%     msgbox('下一个？','提示')
end
toc
msgbox('所有样本的高斯滤波完毕！','注意：')


















