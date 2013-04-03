%/*************************************************************************
    % Example: [ZI pointcloud]=wrl2mat('mywrl.wrl');
%     Input:         fname 	 wrl File Name
%     Outputs:       ZI          	 2D mesh File
%                    pointcloud 	 3xN  pointcloud data   
    % Suggestion:
    % to have a better output you should use crop3dface.m that is available in my
    % files in mathworks file exchange.

% In the case of any problem you can call me by 
% Email:Alibossagh@yahoo.co.uk
% This code is a modified version of the read_vrml.m written by "G. Akroyd"

% Version:    1.00       Published: 2008 June 07

%function [ZI pointcloud]=wrl2mat(fname)
function myselfFaceData(fname)
%fname = 'cara1_frontal1.wrl';
disp(['Reading The File  ', fname])
        vrfile=fopen(fname);
        p=1;counter=0;pointcloud=[0 0 0];
 while counter~=-1
    data=fgets(vrfile);
    fpoint=findstr(data,'point');% 2 checkers to find out the begining
    f2point=findstr(data,'[');   %of the x,y,z " point [ "
    while ~isempty(fpoint) & ~isempty(f2point)
      data=fgets(vrfile);
        if isempty(findstr(data,']'));
          t=sscanf(data,'%f %f %f');
          pointcloud(p,:)=t';
          p=p+1;
        else fpoint=[];counter=-1;
        end
    end
 end
 disp(['Convert to 2D Image'])
X=pointcloud(:,1);Y=pointcloud(:,2);Z=pointcloud(:,3);%Load positions to X,Y,Z
disp('[print 3d point x]')
%X  %一列数据
X=X-min(X);Y=Y-min(Y);%change X,Y to start from 0
x=[min(X):1:max(X)];y=[min(Y):1:max(Y)];%create image dimentions
[XI,YI] = meshgrid(x,y);%create matrix of positions
YI=max(YI(:))-YI;
Z=Z-min(Z(:));%Change Z data to start from 0 原句
ZI=griddata(X,Y,Z,XI,YI,'linear'); % calculate Z values from noninteger positions


%[XI,YI,ZI]
%网格图
%{
figure(1);mesh(XI,YI,ZI);grid off;title('3D Point Image');
%colormap('cool')
%light('position',[200,200,200],'style','local','color','w')
%shading flat;
shading interp
colormap(jet(256))
camlight left
lighting phong
set(gcf,'color','w')
%}
%%%%%%%%%%%%%%%%%%%%%%%%%%%点云图 原始点 没有加点%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(2);
title('3D PointImage ');
set(gcf,'color','w')
plot3(X,Y,Z,'.r')
grid on
axis equal

%%%%%%%%%%%%%%%%%%%%%%%%%%% 做三角化的图 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
shape = [X,Y,Z];
figure(3)
tri=delaunay(shape(:,1), shape(:,2));
trisurf(tri, shape(:,1), shape(:,2), shape(:,3))
shading interp
colormap(jet(256))
camlight left
lighting phong
set(gcf,'color','w')
%{
%二维图
%figure(4);imshow(ZI,[]);title('Extracted Image') 

%%%%%%%%%%%%保存导入的三维数据%%%%%%%%%%%%%%%%%
faceData3D = shape;
save('faceData3D','faceData3D');
[H W]=size(faceData3D) %h = 13709

%% 保存点云，还是按n*3的形式
%{    
    fid2=fopen(['3D_orignal.txt'],'w');%写入文件路径
    for i=1:H
        fprintf(fid2,'%g\t',X(i));
        fprintf(fid2,'%g\t',Y(i));
        fprintf(fid2,'%g\n',Z(i));
    end
    fclose(fid2);
%}

%}


%{
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 %                              高斯平滑                                    %
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %Zreshape = reshape(Z,H,W);
    template = fspecial('gaussian',7,2.5);
    %Z2 = imfilter(Z, template,'replicate');
    [hz1 wz1] = size(ZI)
    Z2 = imfilter(ZI, template,'replicate');
    [hz2 wz2] = size(Z2)
    Z2 = reshape(Z2,H,1);
    px = P3D(:,1);
    py = P3D(:,2);
    disp(['Gussian imfilter'])
%}
%%%%%%%%%%%%%%%%%%%%%%%%%%%点云图 Z方向高斯平滑后%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(5);
title('3D PointImage After imfilter');
set(gcf,'color','w')
plot3(X,Y,Zsmooth,'.r')
grid on
axis equal
%%%%%%%%%%%%%%%%%%%%做三角化的图 Z方向高斯平滑后%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%% 做三角化的图 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
shape = [X,Y,Z];
figure(6)
tri=delaunay(X,Y );
trisurf(tri, X,Y,Zsmooth)
shading interp
colormap(jet(256))
camlight left
lighting phong
set(gcf,'color','w')
end
