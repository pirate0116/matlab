%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                         %
% gauss filter for 3D shape(mainly to the Z buffer)                   %
%                                                                         %
% code by Zhang feng @ USTB (2010-summer)                                 %
%                                                                         %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% function GaussFilter(Z)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                              下载数据                                    %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc
clear
tic



    % img = imread('L:\Program Files\final_work\2D_data\05066d001ear.jpg');
    %[h,w,rgb] = size(img);
    % P3D = load('L:\Program Files\final_work\3D_data\05066d001ear_filled.txt');
    P3D = load('3D_orignal.txt');
    Z = P3D(:,3);% X,Y,Z start from 0
    X = P3D(:,1);
    Y = P3D(:,2);
    figure(1);
    title('3D PointImage ');
    set(gcf,'color','w')
    plot3(X,Y,Z,'.r')
    grid on
    axis equal
    view(0,90) %俯视图 投影到xoy面
    h_x = max(X)  %图像宽度 = 217.84
    w_y = max(Y)  %图像长度 = 263.34
    %{
    fid = fopen(['xyStartFrom0.txt'],'w');%写入文件路径
    for i=1:size(Z,1)
        fprintf(fid,'%g\t',X(i));
        fprintf(fid,'%g\t',Y(i));
        fprintf(fid,'%g\n',Z(i));
    end
    fclose(fid);
    %}
    %面颈分离 提取脸部点 新建矩阵[X1, Y1]
    %figure(2);scatter3(X,Y,zeros(length(X),1))
    figure(2);scatter(X,Y)
    axis equal
    %{
    int i =1; % 源数据索引
    int j = 1; % 待提取的数据索引
    for (i = 1: 13709)
        if (Y(i)>100)
            Y(i) = Y1(j);
            j = j + 1;
        end
        if (Y
    end
    
     %}   
    %{
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
    
   
%     msgbox('下一个？','提示')

toc
msgbox('高斯滤波完毕！','注意：')

%}
















