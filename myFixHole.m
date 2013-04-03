%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% code by Alex @ ustb 2013-3-18                                      %
%                                                                         %
% function: fill the hole in the original 3D face data                     %
%                                                                         %
% algorithm: x,y--average of the nearest neighbour                        %
%            z--cubic spline interpolation                                %
%                                                                         %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clc
clear
tic
%face = dir('faceData3D');
%face_num = size(face,1);
%for index=1:face_num %此处为循环处理多个人脸图 目前只处理一个人的数据
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                              下载数据                                     %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%img = imread(['L:\400\2D_ear\' ear(index).name(1:9) '_ear.jpg']);
%[h,w,rgb] = size(img);
%P3D = load(['L:\400\3D_ear\' ear(index).name(1:9) '_ear.txt']);
%Z = P3D(:,3);
%X = P3D(:,1);
%Y = P3D(:,2);
% figure
% plot(1:size(Z,1),Z,'*b')
% hold on
faceBeforeFillHole = load (['faceData3D.mat']);
Z = faceBeforeFillHole(:,3);
X = faceBeforeFillHole(:,1);
Y = faceBeforeFillHole(:,2);
[h,w] = size(faceBeforeFillHole);
%%以每行为单位开始补洞,三次样条插值补Z
for i=1:h      %逐行处理
    hole = []; %存放点洞的索引
    holeZ = []; %存放插值后的点
    x_tmp = []; %存放有效索引
    y_tmp = []; %存放有效点
    Yt = [];
    Xt = 1:w;
    for k=1:w
        Yt = [Yt,Z((k-1)*h+i)]; %Y中存入了该行的数据
    end
    for j=1:w
        if Yt(j) == -999999
            hole = [hole,j];
        else
            x_tmp = [x_tmp,Xt(j)];
            y_tmp = [y_tmp,Yt(j)];
        end
    end
    if isempty(x_tmp)
        %这行全置0；
        for k=1:w
            Z((k-1)*h+i) = 0; %Y中存入了该行的数据
        end
    else
        if ~isempty(hole)
            %                 x_tmp;
            %                 y_tmp;
            holeZ = spline(x_tmp,y_tmp,hole);
            for m=1:size(hole,2)
                Z((hole(m)-1)*h+i) = holeZ(m);
            end
        end
    end
end
% plot(1:size(Z,1),Z,'or')
% save('Z','Z');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                            最近邻平均补Y                                 %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for i=1:h      %逐行处理,逐行处理时，最近邻法只适用于Y
    Yline = [];
    Yhole = [];
    Ynohole = [];
    Ymax = 0;
    Ymaxind = 0;
    
    for k=1:w
        Yline = [Yline,Y((k-1)*h+i)];
    end
    for j=1:w
        if Yline(j) == -999999
            Yhole = [Yhole,j];
        else
            Ynohole = [Ynohole,j];
        end
    end
    
    if isempty(Ynohole)
        for k=1:w
            Y((k-1)*h+i) = 0;
        end
    else
        if ~isempty(Yhole)
            for iy=1:size(Yhole,2);
                ydis = [];
                for jy=1:size(Ynohole,2)
                    ydis = [ydis,abs(Yhole(iy)-Ynohole(jy))]; %这里是索引在相减，找离点洞最近的有效点
                end
                [Ymax,Ymaxind] = min(ydis);
                k = Yhole(iy);
                Y((k-1)*h+i) = Yline(Ynohole(Ymaxind));
            end
        end
    end
end
% save('Y','Y')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                            最近邻平均补X                                 %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for i=1:w      %逐列处理,逐列处理时，最近邻法只适用于X
    Xline = [];
    Xhole = [];
    Xnohole = [];
    Xmax = 0;
    Xmaxind = 0;
    
    for k=1:h
        Xline = [Xline,X((i-1)*h+k)]; %抽取了第i列
    end
    for j=1:h
        if Xline(j) == -999999
            Xhole = [Xhole,j];
        else
            Xnohole = [Xnohole,j];
        end
    end
    
    if isempty(Xnohole)
        for k=1:h
            X((i-1)*h+k) = 0; %抽取了第i列
        end
    else
        if ~isempty(Xhole)
            for ix=1:size(Xhole,2);
                xdis = [];
                for jx=1:size(Xnohole,2)
                    xdis = [xdis,abs(Xhole(ix)-Xnohole(jx))]; %这里是索引在相减，找离点洞最近的有效点
                end
                [Xmax,Xmaxind] = min(xdis);
                k = Xhole(ix);
                X((i-1)*h+k) = Xline(Xnohole(Xmaxind));
            end
        end
    end
end
% save('X','X')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                           保存新的三维数据                               %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ear=dir('L:\Program Files\final_work\2D_data\');
% fid=fopen(['L:\Program Files\final_work\3D_data\' ear(3).name(1:9) 'ear_filled.txt'],'w');%写入文件路径

fid=fopen(['L:\400\3D_ear_holed\' ear(index).name(1:9) '_ear_holed.txt'],'w');%写入文件路径

for i=1:size(X,1)
    fprintf(fid,'%g\t',X(i));
    fprintf(fid,'%g\t',Y(i));
    fprintf(fid,'%g\n',Z(i));
end
fclose(fid);
display(['第' num2str(index) '个样本的点洞修补完毕！'])
end
msgbox('所有样本完成补洞！','注意：')
toc

























